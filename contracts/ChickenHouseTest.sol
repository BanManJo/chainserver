pragma solidity ^0.5.2;

import "./OrderRoomTest.sol";

// ChickenHouse 역할
contract ChickenHouseTest {
  Menu menu;
  Location location;
  address owner;
  uint salesOnOff;
  

  struct Location{
    string latitude;
    string longitude;
  }

  struct Menu {
    uint256 price;
    string chickenName;
  }

  OrderRoomTest[] orderRooms;

  function() external payable {
      
  }

   function matchRoom(uint256 _roomIndex) public payable {
    // 바로 할당을 위한 생성
    OrderRoomTest orderRoom = orderRooms[_roomIndex];
     address(uint160(address(orderRoom))).transfer(msg.value);
    orderRoom.matchRoom();
  }

}
