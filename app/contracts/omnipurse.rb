class OmnipurseContract < Etheruby::Contract
  # The contract can be found here in the blockchain
  at_address 0x81a47e985b7a133728e97efc7f9ec3654b6e73f0
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
    returns :address, :uint256, :string, :uint8, :uint256, :uint256
  end
  # This method is used to list the contributions made on a purse
  method :getPurseContributions do
    parameters :uint256, :uint256
    returns :address, :uint256, :bool
  end
end
