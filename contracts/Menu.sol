pragma solidity ^0.5.2;

contract Menu {
  struct Menu {
    uint256 price;
    string chickenName;
  }
  Menu[] public meuns;

  function setMenu(
    Store memory store,
    uint256 _price,
    string memory _chickenName
  ) public returns (bool) {
    Menu memory menu;
    menu.price = _price;
    menu.chickenName = _chickenName;
    store.meuns.push(menu);
    return true;
  }

  function getMenu(uint256 _priceId)
    public
    view
    returns (string memory chickenName)
  {
    Menu memory menu = meuns[_priceId];
    return (menu.chickenName);
  }
}
