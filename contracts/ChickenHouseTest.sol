pragma solidity ^0.5.2;

import "./OrderRoomTest.sol";

// ChickenHouse 역할
contract ChickenHouseTest {
  OrderRoomTest[] orderRooms;
  Menu menu;
  Location location;
  string storeName;
  address owner;
  uint roomIndex;
  uint salesOnOff;
  uint roomIndex; 
  string latitude;
  string longitude;
  

    struct Menu {
    uint256 price;
    string chickenName;
  }

  uint256 public storeIndex = 0;

  function() external payable {}

  // 주문방 만들기
  function createRoom(uint256 _price, uint8 _finish, string memory _chickenName) public {
    // room 생성!!!!
    OrderRoomTest orderRoom = new OrderRoomTest(_price, _finish, _chickenName);
    orderRooms.push(orderRoom);
    address(uint160(address(orderRoom))).transfer(10);
  }

  function getBalance(uint256 id) public view returns (uint256) {
    OrderRoomTest orderRoom = orderRooms[id];
    return address(orderRoom).balance;
  }
}
