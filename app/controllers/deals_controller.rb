class DealsController < ApplicationController
  def index
    @deals = Deal.all
  end

  def home
    client = ApiClient.new
    response = client.get_all_deals_for_city("glasgow")
    @response = JSON.parse(response.to_s)
    @response.each do |deal|
      if deal.has_key?("deal")
        offer = {
          offer_id: deal.values.first.dig("id"),
          short_title: deal.values.first.dig("short_title"),
          price: deal.values.first.dig("price"),
          about: deal.values.first.dig("about"),
          what_to_expect: deal.values.first.dig("what_to_expect")
        }
        Deal.find_or_create_by(offer)
      end
    end
  end

  def picks
    redirect_to action: show
  end

  def show
    @selected_deals = Deal.select(:offer_id, :short_title, :price, :about, :what_to_expect)where(city: params[:city])
  end

  private

  def permitted_params
    params.permit(:city, :type, :authenticity_token, :commit, :deal_id, :format)
  end
end
