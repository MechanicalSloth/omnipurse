pragma solidity ^0.4.8;

contract Omnipurse {

  struct Contribution {
    address sender;
    uint value;
    bool refunded;
    uint256 timestamp;
  }

  struct Purse {
    address creator;
    uint256 timestamp;
    string title;
    uint8 status;
    uint numContributions;
    mapping (uint => Contribution) contributions;
  }

  uint numPurse;
  mapping (uint => Purse) purses;
  mapping (address => string) nicknames;

  function createPurse(string title) returns (uint purseId) {
    purseId = numPurse++;
    purses[purseId] = Purse(msg.sender, block.timestamp, title, 1, 0);
  }

  function getPurseDetails(uint purseId) returns (
    address cr,
    uint256 ts,
    string t,
    uint8 s,
    uint n,
    uint cb
  ) {
    Purse p = purses[purseId];
    cr = p.creator;
    ts = p.timestamp;
    t = p.title;
    s = p.status;
    n = p.numContributions;
    for (uint i=0; i<p.numContributions; i++) {
      Contribution c = p.contributions[i];
      cb += c.value;
    }
  }

  function getPurseContributions(uint purseId, uint contributionId) returns (
    address s,
    uint v,
    bool r,
    string n
  ) {
    Purse p = purses[purseId];
    Contribution c = p.contributions[contributionId];
    s = c.sender;
    v = c.value;
    r = c.refunded;
    n = nicknames[c.sender];
  }

  function contributeToPurse(uint purseId) payable {
    Purse p = purses[purseId];
    if (p.status != 1) { throw; }
    p.contributions[p.numContributions++] = Contribution(msg.sender, msg.value, false, block.timestamp);
  }

  function dissmisPurse(uint purseId) {
    Purse p = purses[purseId];
    if (p.creator != msg.sender || (p.status != 1 && p.status != 4) ) { throw; }
    bool success = true;
    for (uint i=0; i<p.numContributions; i++) {
      Contribution c = p.contributions[i];
      if(!c.refunded) {
        c.refunded = c.sender.send(c.value);
      }
      success = success && c.refunded;
    }
    if (success) {
      p.status = 3;
    } else {
      p.status = 4;
    }
  }

  function finishPurse(uint purseId) {
    Purse p = purses[purseId];
    uint total = 0;
    if (p.creator != msg.sender || p.status != 1) { throw; }
    for (uint i=0; i<p.numContributions; i++) {
      Contribution c = p.contributions[i];
      total += c.value;
    }
    if (p.creator.send(total)) {
      p.status = 2;
    }
  }

  function registerNickname(string nickname) {
    nicknames[msg.sender] = nickname;
  }

}
