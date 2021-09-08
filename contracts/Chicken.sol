pragma solidity ^0.5.2;

contract Chicken {
    struct creatChicken {
    uint256 price;
    string chickenName;
  }
  creatChicken[] public Chickens;

  function ownerIf(uint256 _price, string memory _chickenName) public returns(bool) {
    creatChicken memory newcreatChicken;
    newcreatChicken.price = _price;
    newcreatChicken.chickenName = _chickenName;
    Chickens.push(newcreatChicken);
    return true;
  }

    function getOwnerIf(uint256 _priceId) public view returns(string memory chickenName) {
    creatChicken memory chickenzz = Chickens[_priceId];
    return (chickenzz.chickenName);
  }

}


