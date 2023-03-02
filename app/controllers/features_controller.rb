class FeaturesController < ApplicationController
  def index
    post_params = params
  end

  def home
    client = ApiClient.new
    response = client.get_all_deals_for_city("glasgow")
    @response = JSON.parse(response.to_s)
  end

  def picks
    redirect_to action: index
  end

  def show
  end

  private

  def permitted_params
    params.permit(:city, :type, :authenticity_token, :commit, :deal_id, :format)
  end
end
