pragma solidity ^0.5.2;

import "./OrderRoomTest.sol";

// ChickenHouse 역할
contract ChickenHouseTest {

  function() external payable {}

  string storeName;
  uint roomIndex;
  Menu menus;
  Location location;
  address owner;
  uint salesOnOff;
  
  struct Menu {
    uint256 price;
    string chickenName;
  }

  string[] menus;  
  
  OrderRoomTest[] orderRooms;


  // 주문방 만들기
  function createRoom() public {
    // room 생성!!!!
    OrderRoomTest orderRoom = new OrderRoomTest();
    orderRooms.push(orderRoom);
    address(uint160(address(orderRoom))).transfer(10);
  }

  function approveOrder(uint256 _roomNumber) public payable {
    OrderRoomTest orderRoom = orderRooms[_roomNumber]; // 해당 치킨하우스에 해당하는 orderRoom을 찾는다.
    // require (tx.origin == owner);  
    orderRoom.approveOrder();
    
  }

  function getBalance(uint256 _roomIndex) public view returns (uint256) {
    OrderRoomTest orderRoom = orderRooms[_roomIndex];
    return address(orderRoom).balance;

  }
}
