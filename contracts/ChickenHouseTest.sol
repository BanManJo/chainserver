pragma solidity ^0.5.2;

import "./OrderRoomTest.sol";

// ChickenHouse 역할
contract ChickenHouseTest {
  OrderRoomTest[] orderRooms;

  function() external payable {}

  // 주문방 만들기
  function createRoom() public {
    // room 생성!!!!
    OrderRoomTest orderRoom = new OrderRoomTest();
    orderRooms.push(orderRoom);
    address(uint160(address(orderRoom))).transfer(10);
  }

  function getBalance(uint256 id) public view returns (uint256) {
    OrderRoomTest orderRoom = orderRooms[id];
    return address(orderRoom).balance;
  }
}
