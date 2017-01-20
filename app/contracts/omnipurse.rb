class OmnipurseContract < Etheruby::Contract
  at_address 0xf9e6117e2322f4ba94a6a2be7df4fd76cf36aa97
  method :createPurse do
    parameters :string
    returns :uint256
  end
  method :getPurseDetails do
    parameters :uint256
    returns :address, :uint256, :string, :uint8, :uint256, :uint256
  end
  method :getPurseContributions do
    parameters :uint256, :uint256
    returns :address, :uint256, :bool
  end
end
