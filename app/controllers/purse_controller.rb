class PurseController < ApplicationController

  before_action :load_purse, except: [:search]

  def show
  end

  def search
    @result = OmnipurseContract.list_purses_by_address params[:address]
  end

  def details
    @contributions = OmnipurseContract.list_contributions_of_purse params[:id]
  end

  private

    def load_purse
      @purse = OmnipurseContract.get_purse_details params[:id]
    end

end
