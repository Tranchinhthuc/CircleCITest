class StaticPagesController < ApplicationController
  def home
    # render layout: false
  end

  def baokim
    render layout: false
  end

  def nganluong
    render layout: false
  end
end
