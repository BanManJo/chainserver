pragma solidity ^0.5.2;

// OrderRoom 역할
contract OrderRoomTest {

  uint256 public price;
  string public chickenName;
  uint8 public state;
  uint256 public startTime;
  uint256 public finishTime;
  address public user1;
  address public user2;

  event matchFinish(string _chickenName, uint256 _roomIndex);
  event approveFinish(string _chickenName, uint256 _roomIndex);

  function() external payable {}

      constructor(uint256 _price, uint256 _finish, string memory _chickenName) public {
          price = _price;
          chickenName = _chickenName;
          state = 1;
          startTime = now;
          finishTime = now;
          user1 = tx.origin;
        
      }
  // function blah(int x, int y) payable public {}

  function matchRoom(string memory _chickenName, uint256 _roomIndex) public {
      state = 2;
      user2 = tx.origin;

      emit matchFinish(_chickenName,  _roomIndex);
      
  }

  function approveOrder(string memory _chickenName,  uint256 _roomIndex) public payable{
    tx.origin.transfer(address(this).balance);  
    state = 3;
    

    emit approveFinish(_chickenName,  _roomIndex);

    
  }

  function getStateRoom() external view returns (uint){

    return state;
  }

  function getRoomInfo() public view returns (string memory, uint256, uint8, address){
    return (chickenName, price, state, user1);
  } 
}
