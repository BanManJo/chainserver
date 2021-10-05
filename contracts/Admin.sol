pragma solidity ^0.5.2;
pragma experimental ABIEncoderV2;

import "./ChickenHouse.sol";

// Admin 역할
contract Admin {
  ChickenHouse[] chickenHouses;

  mapping(string => uint256) storeIndexs;

  //치킨집 배열에 길이를 반환하는 함수
  function getStoreCount() public view returns (uint256 storeCount) {
    // ChickenHouse chickenHouse = findChickenHouse(_storeName);
    return chickenHouses.length;
  }

  // 해당 치킨하우스를 찾는 함수 (이름으로)
  function findChickenHouse(string memory _storeName)
    public
    view
    returns (ChickenHouse chickenHouse)
  {
    bytes memory tempEmptyStringTest = bytes(_storeName); // Uses memory
    require(tempEmptyStringTest.length != 0);

    ChickenHouse chickenHouse = chickenHouses[storeIndexs[_storeName]];
    return chickenHouse;
  }

  // 해당 치킨하우스를 찾는 함수 (인덱스로)
  function findChickenHouseByIndex(uint256 idx)
    public
    view
    returns (ChickenHouse chickenHouse)
  {
    return chickenHouses[idx];
  }

  // ChickenHouse (메뉴와함께) 등록
  function registerChickenHouse(
    string memory _storeName,
    string memory _latitude,
    string memory _longitude,
    string[] memory _chickenNames,
    uint256[] memory _prices,
    uint8[] memory _menuState
  ) public {
    if (chickenHouses.length == 0) {
      // require(msg.sender == 0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c);
      ChickenHouse chickenHouse = new ChickenHouse(
        _storeName,
        _latitude,
        _longitude,
        msg.sender
      );

      storeIndexs[_storeName] = chickenHouses.push(chickenHouse) - 1;
      chickenHouse.registerChickenHouse(_chickenNames, _prices, _menuState);
    } else {
      ChickenHouse chickenHouse = new ChickenHouse(
        _storeName,
        _latitude,
        _longitude,
        msg.sender
      );

      storeIndexs[_storeName] = chickenHouses.push(chickenHouse) - 1;
      chickenHouse.registerChickenHouse(_chickenNames, _prices, _menuState);
    }
  }
}
