class HomeController < ApplicationController

  def index
    @total_purses = OmnipurseContract.num_purse
    @last_purses = OmnipurseContract.last_purses
  end

end
