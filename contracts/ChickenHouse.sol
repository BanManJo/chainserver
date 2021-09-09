pragma solidity ^0.5.2;

// solidity version
contract ChickenHouse {
  struct Menu {
    uint256 price;
    string chickenName;
  }
  struct Location {
    string latitude;
    string longitude;
  }
  struct Store {
    string storeName;
    address ceoAccount;
    Location location;
    mapping(uint256 => Menu) menus;
    uint256 menuSize;
    uint256 countRoom;
    uint256 cookingTime;
    uint8 finishType;
  }
  mapping(address => uint256) private ownerToIndex;
  Store[] private stores;

  function setMenu(string memory _chickenName, uint256 _price) public {
    //   Store store = // 어떤 스토어?
    uint256 idx = ownerToIndex[msg.sender];
    Store storage store = stores[idx];
    // Store storage store = stores[idx];
    Menu memory menu = Menu(_price, _chickenName);
    store.menus[store.menuSize] = menu;
  }

  function getMenuById(uint256 _id)
    public
    view
    returns (string memory chickenName, uint256 price)
  {
    Menu memory menu = stores[ownerToIndex[msg.sender]].menus[_id];
    return (menu.chickenName, menu.price);
  }

  function StoreRegistration(
    string memory _storeName,
    string memory _latitude,
    string memory _longitude,
    uint256 _countRoom,
    uint256 _cookingTime,
    uint8 _finishType
  ) public returns (bool) {
    Store memory newStore;
    newStore.storeName = _storeName;
    newStore.ceoAccount = msg.sender;
    newStore.location = Location(_latitude, _longitude);
    //newStore.menus = Menu[]; // null
    newStore.countRoom = _countRoom;
    newStore.cookingTime = _cookingTime;
    newStore.finishType = _finishType;
    newStore.menuSize = 0;
    stores.push(newStore);
    ownerToIndex[msg.sender] = stores.length - 1;

    return true;
  }

  function getStoresById(uint256 _storeId)
    public
    view
    returns (
      string memory storeName,
      address ceoAccount,
      string memory latitude,
      string memory longitude,
      uint256 countRoom,
      uint256 cookingTime,
      uint8 finishType
    )
  {
    Store memory store = stores[_storeId];
    return (
      store.storeName,
      store.ceoAccount,
      store.location.latitude,
      store.location.longitude,
      store.countRoom,
      store.cookingTime,
      store.finishType
    );
  }
}
