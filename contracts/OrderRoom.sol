pragma solidity ^0.5.2;

contract OrderRoom {
  struct Menu {
    uint16 price;
    string chickenName;
  }

  struct OrderRoom {
    uint256 roomNumber;
    string storeName;
    address user1;
    address user2;
    Menu menu;
    uint256 startTime;
    uint256 finishTime;
    uint8 state;
  }

  OrderRoom[] private orderRooms;

  function createRoom(
    uint256 _roomNumber,
    string memory _storeName,
    address _user1,
    address _user2,
    //     Menu memory _menu,
    string memory _chickenName,
    uint16 _price,
    uint256 _startTime,
    uint256 _finishTime,
    uint8 _state
  ) public returns (bool) {
    OrderRoom memory newRoom;
    newRoom.roomNumber = _roomNumber;
    newRoom.storeName = "BBQ"; // 하드 코딩 값!
    newRoom.user1 = _user1;
    newRoom.user2 = _user2;
    Menu memory menu;
    menu.chickenName = _chickenName;
    menu.price = _price;
    newRoom.menu = menu;
    newRoom.startTime = _startTime;
    newRoom.finishTime = _finishTime;
    newRoom.state = _state;

    orderRooms.push(newRoom);

    return true;
  }

  function getRoomById(uint256 _roomId)
    public
    view
    returns (
      uint256 roomNumber,
      string memory storeName,
      address user1,
      address user2,
      uint16 price,
      string memory chickenName,
      uint256 startTime,
      uint256 finishTime,
      uint256 state
    )
  {
    OrderRoom memory orderRoom = orderRooms[_roomId];

    return (
      orderRoom.roomNumber,
      orderRoom.storeName,
      orderRoom.user1,
      orderRoom.user2,
      orderRoom.menu.price,
      orderRoom.menu.chickenName,
      orderRoom.startTime,
      orderRoom.finishTime,
      orderRoom.state
    );
  }
}
