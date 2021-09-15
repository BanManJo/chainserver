pragma solidity ^0.5.2;

import "./OrderRoomTest.sol";

// ChickenHouse 역할
contract ChickenHouseTest {
  OrderRoomTest[] orderRooms;
  Menu menu;
  string storeName;
  address owner;
  uint8 onOff;
  string latitude;
  string longitude;
  

    struct Menu {
    uint256 price;
    string chickenName;
  }

  // 주문방 만들기
  function createRoom(uint256 _price, uint8 _finish, string memory _chickenName) public {
    // room 생성!!!!
    OrderRoomTest orderRoom = new OrderRoomTest(_price, _finish, _chickenName);
    orderRooms.push(orderRoom);
    address(uint160(address(orderRoom))).transfer(10);
  }

  function() external payable {
      
  }

   function matchRoom(uint256 _roomIndex) public payable {
    // 바로 할당을 위한 생성
    OrderRoomTest orderRoom = orderRooms[_roomIndex];
     address(uint160(address(orderRoom))).transfer(msg.value);
    orderRoom.matchRoom();
  }

}
