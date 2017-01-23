class OmnipurseContract < Etheruby::Contract
  # The contract can be found here in the blockchain
  at_address(if Rails.env.production?
    0x81a47e985b7a133728e97efc7f9ec3654b6e73f0
  else
    0x4a0ba852fb10ffa742c54d4976b35ebbeab026cf
  end)

  # This method is used to retrieve the total number of purses
  method :numPurse do
    returns total_purses: :uint256
  end

  # This method is used to list all the purses made by an address
  method :searchPursesByAddress do
    parameters :address
    returns result: array(:uint256)
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
    np = self.numPurse.total_purses
    return [] unless np > 0
    ((np-10 < 0 ? 0 : np-10)..np-1).map { |id| self.getPurseDetails(id) }
  end

  # Wrapper to search all purses created by `address`
  def self.list_purses_by_address(address)
    self.searchPursesByAddress(address).result.map { |id| self.getPurseDetails(id) }
  end

  # Wrapper to get all the contributions
  def self.list_contributions_of_purse(purse_id)
    num_contribs = self.getPurseDetails(purse_id).num_contributions
    return [] unless num_contribs > 0
    (0..num_contribs-1).map { |id| self.getPurseContributions(purse_id, id) }
  end
end
