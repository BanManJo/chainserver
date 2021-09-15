pragma solidity ^0.5.2;

import "./ChickenHouseTest.sol";
import "./OrderRoomTest.sol";
// Admin 역할
contract AdminTest {
   
  ChickenHouseTest[] chickenHouses;

  // ChickenHouse 등록
  function registerChickenHouse() public {
    ChickenHouseTest chickenHouse = new ChickenHouseTest();
    chickenHouses.push(chickenHouse);
  }
  

  // 방 Match 함수
  function matchRoom(uint256 _storeIndex, uint256 _roomIndex) public payable {
    // 바로 할당을 위한 생성
    ChickenHouseTest chickenHouse = chickenHouses[_storeIndex];
    address(uint160(address(chickenHouse))).transfer(msg.value);
    chickenHouse.matchRoom(_roomIndex);
  }

}
