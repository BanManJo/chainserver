pragma solidity ^0.5.2;

import "./OrderRoomTest.sol";

// ChickenHouse 역할
contract ChickenHouseTest {
  string storeName;
  address owner;
  uint8 onOff;
  string latitude;
  string longitude;
  Menu menu;
  

  struct Menu {
    uint256 price;
    string chickenName;
  }


  OrderRoomTest[] orderRooms;

  // 주문방 만들기
  function createRoom(uint256 _price, uint256 _finish, string memory _chickenName) public payable {
    // room 생성!!!!
    OrderRoomTest orderRoom = new OrderRoomTest(_price, _finish, _chickenName);
    orderRooms.push(orderRoom);
    address(uint160(address(orderRoom))).transfer(address(this).balance);
  }

  function() external payable {}
      
   function matchRoom(uint256 _roomIndex) public payable {
    // 바로 할당을 위한 생성
    OrderRoomTest orderRoom = orderRooms[_roomIndex];
     address(uint160(address(orderRoom))).transfer(address(this).balance);
    orderRoom.matchRoom();
  }
  
  function approveOrder(uint256 _roomIndex) public {
    OrderRoomTest orderRoom = orderRooms[_roomIndex]; // 해당 치킨하우스에 해당하는 orderRoom을 찾는다.
    // require (tx.origin == owner);  
    orderRoom.approveOrder();
  }

  function getBalance(uint256 _roomIndex) public view returns (uint256) {
    OrderRoomTest orderRoom = orderRooms[_roomIndex];
    return address(orderRoom).balance;

  }

   function getStateRoom(uint256 _roomIndex) public view returns (uint256) {
    OrderRoomTest orderRoom = orderRooms[_roomIndex];
    return orderRoom.getStateRoom();

  }


}
