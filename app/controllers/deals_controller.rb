class DealsController < ApplicationController
  API_CLIENT = ApiClient.new
  skip_forgery_protection

  def index
    response = API_CLIENT.get_all_deals_for_city(permitted_params[:city])
    @response = JSON.parse(response.to_s)
    @response.each do |deal|
      if deal.has_key?("deal")
        entry = deal.values.first
        entry.symbolize_keys!
        offer = {
          city: permitted_params[:city],
          offer_id: entry[:id],
          short_title: entry[:short_title],
          price: entry[:price],
          about: entry[:about],
          what_to_expect: entry[:what_to_expect]
        }
        Deal.find_or_create_by(offer)
      end
    end
    @deals ||= Deal.select(:short_title, :price, :offer_id, :city).where(city: permitted_params[:city])
  end

  def home
  end

  def picks
    respond_to do |format|
      format.html { redirect_to action: index }
    end
  end

  def show
    @selected_deal = Deal.find_by(offer_id: permitted_params[:id])
    response = API_CLIENT.get_deal_for_city(@selected_deal.city, @selected_deal.offer_id)
    parsed_response = JSON.parse(response.to_s)
    properties = {
      short_title: parsed_response["deal"]["short_title"],
      about: parsed_response["deal"]["about"],
      what_to_expect: parsed_response["deal"]["what_to_expect"]
    }
    @selected_deal.update(properties)
    if @selected_deal.save!
      @selected_deal
    end
  end

  private

  def permitted_params
    params.permit(:city, :type, :authenticity_token, :commit, :id, :format)
  end
end
