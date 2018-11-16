class WelcomeController < ApplicationController
  def index
    require 'rest-client'
    # cryptocurrency_list = RestClient.get "https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest", :params => { :CMC_PRO_API_KEY => "1e2242a2-55be-463c-989e-d411fc3661c9", :start => 1, :limit => 1 }
    # @btc_price = JSON.parse(cryptocurrency_list.body)["data"][0]
    cryptocurrency_list = RestClient.get "https://api.coinmarketcap.com/v2/ticker/?convert=BTC&limit=1"
    @btc_price = JSON.parse(cryptocurrency_list.body)["data"]["1"]

    difficulty = RestClient.get "https://blockexplorer.com/api/status", :params => { :q => "getDifficulty" }
    @btc_difficulty = JSON.parse(difficulty.body)

  end
end
