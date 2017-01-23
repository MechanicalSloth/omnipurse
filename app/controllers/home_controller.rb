class HomeController < ApplicationController

  def index
    @total_purses = OmnipurseContract.numPurse.total_purses
    @last_purses = OmnipurseContract.last_purses
  end

end
