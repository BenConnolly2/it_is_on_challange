class UsersController < ApplicationController
  def home
    url = "https://api.itison.com/api/110/glasgow/all"
    @data = Faraday.get(url)
  end
end
