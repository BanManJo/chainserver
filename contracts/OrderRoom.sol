pragma solidity ^0.5.2;

contract OrderRoom {

      struct OrderRoom{
            uint256 roomNumber;
            string storeName;
            address user1;
            address user2;
            string menu;
            uint startTime;
            uint finishTime;
            uint state;
      }

      OrderRoom[] public orderRooms;

      function createRoom(uint256 _roomNumber, string memory _storeName, address _user1, address _user2, string memory _menu, uint _startTime, uint _finishTime, uint _state) public returns(bool){
            OrderRoom memory newRoom;
            newRoom.roomNumber = _roomNumber;
            newRoom.storeName = _storeName;
            newRoom.user1 = _user1;
            newRoom.user2 = _user2;
            newRoom.menu = _menu;
            newRoom.startTime = _startTime;
            newRoom.finishTime = _finishTime;
            newRoom.state = _state;
            
            orderRooms.push(newRoom);

            return true;
      }

      function getRoomById(uint _roomId) public view returns(
            uint256 roomNumber,
            string memory storeName,
            address user1,
            address user2,
            string memory menu,
            uint startTime,
            uint finishTime,
            uint state){
            
            OrderRoom memory orderRoom = orderRooms[_roomId];
            
            return (
                    orderRoom.roomNumber,
                    orderRoom.storeName,
                    orderRoom.user1,
                    orderRoom.user2,
                    orderRoom.menu,
                    orderRoom.startTime,
                    orderRoom.finishTime,
                    orderRoom.state    
            );
      }

      
      
}