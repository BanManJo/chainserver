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
    uint256 private receiveTime;

    function() external payable {}

    constructor(
        uint256 _price,
        uint256 _start,
        uint256 _finish,
        string memory _chickenName,
        uint8 _menuState,
        address _user1
    ) public {
        price = _price;
        chickenName = _chickenName;
        menuState = _menuState;
        state = 1;
        startTime = _start;
        finishTime = _finish;
        user1 = _user1;
    }

    // function blah(int x, int y) payable public {}

    function matchRoom(address _address) public payable {
        state = 2;
        user2 = _address;

        receiveTime = now;
    }

    function approveOrder(uint256 _roomIndex, address _owner)
        public
        payable
        returns (address, address)
    {
        address(uint160(address(_owner))).transfer(address(this).balance);
        state = 3;
        return (user1, user2);
    }

    function finishCook() public {
        state = 4;
    }

    function getStateRoom() external view returns (uint256 _state) {
        return (_state = state);
    }

    function getRoomInfo()
        external
        view
        returns (
            string memory _chickenName,
            uint256 _price,
            uint8 _state,
            uint8 _menuState,
            uint256 _startTime,
            uint256 _finishTime,
            address _user1,
            uint256 _receiveTime
        )
    {
        return (
            _chickenName = chickenName,
            _price = price,
            _state = state,
            _menuState = menuState,
            _startTime = startTime,
            _finishTime = finishTime,
            _user1 = user1,
            _receiveTime = receiveTime
        );
    }

    function getBalance() external view returns (uint256 balance) {
        return balance = address(this).balance;
    }

    // user1이 돈을 넣고 시간이 초과되었을때 환불되는 함수
    function refundToAUser() public {
        address(uint160(address(user1))).transfer(address(this).balance);
    }

    // user1과 user2 에게 환불
    function refundToBothUsers() public {
        address(uint160(address(user1))).transfer(address(this).balance / 2);
        address(uint160(address(user2))).transfer(address(this).balance / 2);
        state = 4;
    }
}
