require "httparty"

class ApiClient
  include HTTParty

  def get_all_deals_for_city(city)
    url = "https://api.itison.com/api/110/#{city}/deals"
    self.class.get(url)
  end

  def get_deal_for_city(city, deal_id)
    url = "https://api.itison.com/api/110/#{city}/deals/#{deal_id}"
    self.class.get(url)
  end

  def get_deals_for_city_in_category(city, category_type)
    url = "https://api.itison.com/api/110/#{city}/deals/category/#{category_type}"
    self.class.get(url)
  end
end

"https://api.itison.com/api/110/glasgow/all"
