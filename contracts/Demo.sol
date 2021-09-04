pragma solidity ^0.5.2;

// solidity version

contract Demo {
  // contract name is Demo
  string public constant name = "DEMO token";
  string public constant symbol = "DEMO";
  uint256 public constant decimals = 18;
  uint256 public constant INITIAL_SUPPLY = 1000 * 10**decimals;
  string constant test = "You can not see this";

  // Array with all rooms
  Room[] public rooms;

  struct Room {
    uint256 roomNumber;
    string name;
    string menu;
  }

  function createRoom(uint256 _roomNumber, string memory _name, string memory _menu) public returns(bool) {
    Room memory newRoom;
    newRoom.roomNumber = _roomNumber;
    newRoom.name = _name;
    newRoom.menu = _menu;
    rooms.push(newRoom);
    return true;
  }

  function getRoomsById(uint256 _roomId) public view returns(
    string memory name,
    string memory menu) {

    Room memory room = rooms[_roomId];
    return (
    room.name,
    room.menu);
  }

  function getRoomCounts() public view returns(uint) {
    return rooms.length;
  }

  function testing() public returns (string memory) {
    return "hello world";
  }
}
