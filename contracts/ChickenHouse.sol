pragma solidity ^0.5.2;
import "./Menu.sol";

// solidity version
contract ChickenHouse {
  struct Menu {
    uint256 price;
    string chickenName;
  }
  struct Store {
    string storeName;
    address ceoAccount;
    string location;
    Menu[] menus;
    uint256 countRoom;
    uint256 cookingTime;
    uint8 finishType;
  }

  Store[] public stores;

  //   function _setMenu(
  //     Store memory store,
  //     uint256 _price,
  //     string memory _chickenName
  //   ) public returns (bool) {
  //     Menu memory menu;
  //     menu.price = _price;
  //     menu.chickenName = _chickenName;
  //     store.meuns.push(menu);
  //     return true;
  //   }

  //   function setMenu(chicke, price) {
  //     //   Store store = // 어떤 스토어?
  //     _setMenu(store, chicke, price);
  //   }

  function StoreRegistration(
    string memory _storeName,
    address _ceoAccount,
    string memory _location,
    string memory _menu,
    uint256 _countRoom,
    uint256 _cookingTime,
    uint8 _finishType
  ) public returns (bool) {
    Store memory newStore;
    newStore.storeName = _storeName;
    newStore.ceoAccount = _ceoAccount;
    newStore.location = _location;
    newStore.menu = _menu;
    newStore.countRoom = _countRoom;
    newStore.cookingTime = _cookingTime;
    newStore.finishType = _finishType;

    stores.push(newStore);

    return true;
  }

  function getStoresById(uint256 _storeId)
    public
    view
    returns (
      string memory storeName,
      address ceoAccount,
      string memory location,
      string memory menu,
      uint256 countRoom,
      uint256 cookingTime,
      uint8 finishType
    )
  {
    Store memory store = stores[_storeId];
    return (
      store.storeName,
      store.ceoAccount,
      store.location,
      store.menu,
      store.countRoom,
      store.cookingTime,
      store.finishType
    );
  }
}
