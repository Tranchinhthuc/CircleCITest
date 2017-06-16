class CardsController < ApplicationController
  before_action :authenticate_user!
  include StandardActions
  load_and_authorize_resource

  def index
    @cards = Card.all
  end
end
