pragma solidity ^0.5.2;

// OrderRoom 역할
contract OrderRoom {
  uint256 private price;
  string private chickenName;
  uint8 private menuState;
  uint8 private state;
  uint256 private startTime;
  uint256 private finishTime;
  address private user1;
  address private user2;

  function() external payable {}

  constructor(
    uint256 _price,
    uint256 _finish,
    string memory _chickenName,
    uint8 _menuState,
    address _user1
  ) public {
    price = _price;
    chickenName = _chickenName;
    menuState = _menuState;
    state = 1;
    startTime = now;
    finishTime = now;
    user1 = _user1;
  }

  // function blah(int x, int y) payable public {}

  function matchRoom(address _address) public payable {
    state = 2;
    user2 = _address;
  }

  function approveOrder(uint256 _roomIndex, address _owner) public payable {
    address(uint160(address(_owner))).transfer(address(this).balance);
    state = 3;
  }

  function finishCook() public {
    state = 4;
  }

  function getStateRoom() external view returns (uint256 _state) {
    return _state = state;
  }

  function getRoomInfo()
    external
    view
    returns (
      string memory _chickenName,
      uint256 _price,
      uint8 _state,
      uint8 _menuState,
      address _user1
    )
  {
    return (
      _chickenName = chickenName,
      _price = price,
      _state = state,
      _menuState = menuState,
      _user1 = user1
    );
  }

  // user1이 돈을 넣고 시간이 초과되었을때 환불되는 함수
  function refund1() public {
    address(uint160(address(user1))).transfer(address(this).balance);
  }

  // user1과 user2 에게 환불
  function refund2() public {
    address(uint160(address(user1))).transfer(address(this).balance / 2);
    address(uint160(address(user2))).transfer(address(this).balance);
    state = 4;
  }
}
