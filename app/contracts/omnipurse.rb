class OmnipurseContract < Etheruby::Contract
  # The contract can be found here in the blockchain
  at_address ENV['OMNIPURSE_ADDRESS'] || 0x81a47e985b7a133728e97efc7f9ec3654b6e73f0

  # This method is used to retrieve the total number of purses
  method :numPurse do
    returns :uint256
  end

  # This method is used to list all the purses made by an address
  method :searchPursesByAddress do
    parameters :address
    returns array(:uint256)
  end

  # This method is used to get details of a purse
  method :getPurseDetails do
    parameters :uint256
    returns creator: :address,
            timestamp: :uint256,
            title: :string,
            status: :uint8,
            num_contributions: :uint256,
            total_contributed: :uint256
  end

  # This method is used to list the contributions made on a purse
  method :getPurseContributions do
    parameters :uint256, :uint256
    returns sender: :address,
            value: :uint256,
            refunded: :bool,
            nickname: :string,
            timestamp: :uint256
  end

  # Get 10 last purses
  def self.last_purses
    np = num_purse
    return [] unless np > 0
    ((np-10 < 0 ? 0 : np-10)..np-1).map { |id| get_purse_details(id) }
  end

  # Wrapper to search all purses created by `address`
  def self.list_purses_by_address(address)
    search_purses_by_address(address).map { |id|
      get_purse_details(id)
    }
  end

  # Wrapper to get all the contributions
  def self.list_contributions_of_purse(purse_id)
    num_contribs = get_purse_details(purse_id).num_contributions
    return [] unless num_contribs > 0
    (0..num_contribs-1).map { |id|
      get_purse_contributions(purse_id, id)
    }
  end
end
