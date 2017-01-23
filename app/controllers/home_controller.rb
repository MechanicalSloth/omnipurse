class HomeController < ApplicationController

  def index
    @total_purses = OmnipurseContract.numPurse
    @last_purses = OmnipurseContract.last_purses
  end

end
