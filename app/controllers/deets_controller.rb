class DeetsController < ApplicationController
  def index
    api = Expedia::Api.new
    response = api.get_list({:propertyName => 'Doubletree', :destinationString => 'puntarenas'})
    @response = response.body
  end
end
