class DealsController < ApplicationController
  API_CLIENT = ApiClient.new
  skip_forgery_protection

  def index
    response = API_CLIENT.get_all_deals_for_city(params[:city])
    @response = JSON.parse(response.to_s)
    @response.each do |deal|
      if deal.has_key?("deal")
        entry = deal.values.first
        entry.symbolize_keys!
        offer = {
          city: params[:city],
          offer_id: entry[:id],
          short_title: entry[:short_title],
          price: entry[:price],
          about: entry[:about],
          what_to_expect: entry[:what_to_expect]
        }
        Deal.find_or_create_by(offer)
      end
    end
    @deals ||= Deal.select(:short_title, :price, :offer_id, :city).where(city: params[:city])
  end

  def home
  end

  def picks
    respond_to do |format|
      format.html { redirect_to action: index }
    end
  end

  def show
    @foo = Deal.find_by(offer_id: params[:id])
    @bar = API_CLIENT.get_deal_for_city(@foo.city, params[:id])
    @baz = JSON.parse(@bar.to_s)
    properties = {
      short_title: @baz["deal"]["short_title"],
      about: @baz["deal"]["about"],
      what_to_expect: @baz["deal"]["what_to_expect"]
    }
    @foo.update(properties)
    if @foo.save!
      @foo
    end
  end

  private

  def permitted_params
    params.permit(:city, :type, :authenticity_token, :commit, :deal_id, :format)
  end
end
