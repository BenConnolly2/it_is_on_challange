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
        entry = deal.values.first
        entry.symbolize_keys!
        offer = {
          offer_id: entry[:id],
          short_title: entry[:short_title],
          price: entry[:price],
          about: entry[:about],
          what_to_expect: entry[:what_to_expect]
        }
        Deal.find_or_create_by(offer)
      end
    end
  end

  def picks
  end

  def show
    # @selected_deals = Deal.select(:offer_id, :short_title, :price, :about, :what_to_expect).where(city: params[:city])

    client = ApiClient.new
    deal = client.get_deal_for_city("glasgow", "celentano-s-italian-dining")
    @single_deal = JSON.parse(deal.to_s)
  end

  private

  def permitted_params
    params.permit(:city, :type, :authenticity_token, :commit, :deal_id, :format)
  end
end
