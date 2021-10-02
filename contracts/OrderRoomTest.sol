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

  function matchRoom(string memory _storeName, uint256 _roomIndex) public {
      state = 2;
      user2 = tx.origin;

      emit matchFinish(_storeName,  _roomIndex);
      
  }

  function approveOrder(string memory _storeName,  uint256 _roomIndex) public payable{
    tx.origin.transfer(address(this).balance);  
    state = 3;
    

    emit approveFinish(_storeName,  _roomIndex);
  }

  function orderReject() public {
    state = 4;

  }

  function getStateRoom() external view returns (uint){

    return state;
  }

  function getRoomInfo() public view returns (string memory, uint256, uint8, address){
    return (chickenName, price, state, user1);
  }

  // user1이 돈을 넣고 시간이 초과되었을때 환불되는 함수
  // function refund1() public {
  //     address(uint160(address(user1))).transfer(address(this).balance);  
      
  // }
  
  // user1과 user2 에게 환불
  //   function refund2() public {
  //    address(uint160(address(user1))).transfer(address(this).balance / 2);  
  //     address(uint160(address(user2))).transfer(address(this).balance);
  // }    
}
