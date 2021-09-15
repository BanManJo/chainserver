pragma solidity ^0.5.2;

import "./ChickenHouseTest.sol";
import "./OrderRoomTest.sol";
// Admin 역할
contract AdminTest {
   
  ChickenHouseTest[] chickenHouses;

  // ChickenHouse 등록
  function registerChickenHouse() public {
    ChickenHouseTest chickenHouse = new ChickenHouseTest();
    // 인스턴스를 만들어 준것 ?
    chickenHouses.push(chickenHouse);
  }
  


  // 방만들기 함수
  function createRoom(uint256 _storeIndex, uint256 _price, uint8 _finish, string _chickenName) public payable {
    // chickenHouse를 찾자 storeName 으로!
    ChickenHouseTest chickenHouse = chickenHouses[_storeIndex];
    address(uint160(address(chickenHouse))).transfer(msg.value); // msg.value : 사용자가 전달한 이더
    chickenHouse.createRoom(_price, _finish, _chickenName);
  // 방 Match 함수
  function matchRoom(uint256 _storeIndex, uint256 _roomIndex) public payable {
    // 바로 할당을 위한 생성
    ChickenHouseTest chickenHouse = chickenHouses[_storeIndex];
    address(uint160(address(chickenHouse))).transfer(msg.value);
    chickenHouse.matchRoom(_roomIndex);
  }

}
