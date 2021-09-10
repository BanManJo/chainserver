pragma solidity ^0.5.2;

import "./ChickenHouseTest.sol";

// Admin 역할
contract AdminTest {
  ChickenHouseTest[] chickenHouses;

  // ChickenHouse 등록
  function registerChickenHouse() public {
    ChickenHouseTest chickenHouse = new ChickenHouseTest();
    chickenHouses.push(chickenHouse);
  }

  // 방만들기 함수
  function createRoom(uint256 storeName) public payable {
    // chickenHouse를 찾자 storeName 으로!
    ChickenHouseTest chickenHouse = chickenHouses[storeName];
    address(uint160(address(chickenHouse))).transfer(msg.value); // msg.value : 사용자가 전달한 이더
    chickenHouse.createRoom();
  }

  function getBalanceOfRomm(uint256 storeName, uint256 roomNumber)
    public
    view
    returns (uint256)
  {
    ChickenHouseTest chickenHouse = chickenHouses[storeName];
    return chickenHouse.getBalance(roomNumber);
  }
}
