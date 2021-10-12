pragma solidity ^0.5.2;
pragma experimental ABIEncoderV2;
import "./OrderRoom.sol";
import "./Ownable.sol";

// ChickenHouse 역할
contract ChickenHouse is Ownable {
    OrderRoom[] orderRooms;

    string storeName;
    uint8 onOff = 0;
    string latitude;
    string longitude;
    Menu[] menus;
    uint256 roomCount = 0;

    enum FreshJuiceSize {
        SUNSAL,
        BBUE,
        LARGE
    }

    struct Menu {
        string chickenName;
        uint256 price;
        uint8 menuState;
        uint256 menuIndex;
    }

    //userMyPage 이벤트 기록
    event roomCreated(
        string _storeName,
        string _chickenName,
        uint256 _price,
        uint256 _roomNumber,
        OrderRoom orderRoom,
        uint256 _finish,
        uint8 _menuState,
        uint256 _date,
        address indexed _Ownedby
    );
    event matchFinish(uint256 _roomIndex);
    event approveFinish(
        string _storeName,
        uint256 _roomIndex,
        address indexed user1,
        address indexed user2
    );

    constructor(
        string memory _storeName,
        string memory _latitude,
        string memory _longitude,
        address _owner
    ) public Ownable(_owner) {
        storeName = _storeName;
        latitude = _latitude;
        longitude = _longitude;
    }

    // 메뉴(치킨, 가격)등록
    function registerChickenHouse(
        string[] memory _chickenNames,
        uint256[] memory _prices,
        uint8[] memory _menuState
    ) public {
        require(_chickenNames.length == _prices.length);

        for (uint256 i = 0; i < _chickenNames.length; i++) {
            menus.push(Menu(_chickenNames[i], _prices[i], _menuState[i], i));
        }
    }

    function getRoomsCount() public view returns (uint256) {
        return orderRooms.length;
    }

    function findOrderRoom(uint256 _roomIndex) public view returns (OrderRoom) {
        OrderRoom orderRoom = orderRooms[_roomIndex];
        return orderRoom;
    }

    //메뉴 인덱스 값의 치킨이름, 가격 , state(뼈1, 순살2) 수정 함수
    function setMenu(
        uint256 _index,
        string memory _chickenNames,
        uint256 _price,
        uint8 _menuState
    ) public returns (bool) {
        require(_index < menus.length);

        menus[_index].chickenName = _chickenNames;
        menus[_index].price = _price;
        menus[_index].menuState = _menuState;
    }

    // 메뉴 인덱스 삭제 후 맨뒤에 인덱스 해당 삭제된 인덱스로 가져오기 함수
    function deleteMenu(uint256 _index) public returns (bool) {
        menus[_index] = menus[menus.length - 1];
        menus[_index].menuIndex = _index;
        delete menus[menus.length - 1];
        menus.length--;
    }

    // 주문방 만들기
    function createRoom(
        string memory _storeName,
        string memory _chickenName,
        uint256 _price,
        uint256 _finish,
        uint8 _menuState
    ) public payable {
        uint256 _date = block.timestamp;
        // room 생성!!!!
        OrderRoom orderRoom = new OrderRoom(
            _price,
            _date,
            _finish,
            _chickenName,
            _menuState,
            msg.sender
        );
        orderRooms.push(orderRoom);
        // OrderRoom a = OrderRoom(address(uint160(address(orderRoom))));
        // a.blah.value(_valueToSend)(0,0);
        address(uint160(address(orderRoom))).transfer(msg.value);
        roomCount++;
        uint256 _roomNumber = orderRooms.length - 1;
        address _Ownedby = msg.sender;
        emit roomCreated(
            _storeName,
            _chickenName,
            _price,
            _roomNumber,
            orderRoom,
            _finish,
            _menuState,
            _date,
            _Ownedby
        );
    }

    function matchRoom(uint256 _roomIndex) public payable {
        OrderRoom orderRoom = findOrderRoom(_roomIndex);
        orderRoom.matchRoom(msg.sender);
        address(uint160(address(orderRoom))).transfer(msg.value);

        emit matchFinish(_roomIndex);
    }

    // function() external payable {}

    function approveOrder(string memory _storeName, uint256 _roomIndex)
        public
        onlyOwner
    {
        OrderRoom orderRoom = findOrderRoom(_roomIndex);
        address user1;
        address user2;

        (user1, user2) = orderRoom.approveOrder(_roomIndex, owner());

        emit approveFinish(_storeName, _roomIndex, user1, user2);
    }

    function finishCook(uint256 _roomIndex) public onlyOwner {
        OrderRoom orderRoom = findOrderRoom(_roomIndex);

        orderRoom.finishCook();
    }

    // 방의 모인 금액을 가져옴
    function getBalance(uint256 _roomIndex)
        public
        view
        returns (uint256 _balance)
    {
        OrderRoom orderRoom = findOrderRoom(_roomIndex);
        return _balance = address(orderRoom).balance;
    }

    // 2. 원하는 치킨집의 정보를 치킨집 이름으로 가져온다?
    function getChickenHouse()
        public
        view
        returns (
            string memory _storeName,
            string memory _latitude,
            string memory _longitude,
            uint8 _onOff
        )
    {
        return (
            _storeName = storeName,
            _latitude = latitude,
            _longitude = longitude,
            _onOff = onOff
        );
    }

    // 2.5 원하는 치킨집의 메뉴를 가져온다?
    function getStoreMenu() public view returns (Menu[] memory _menus) {
        return (_menus = menus);
    }

    // 2.5 다른방법
    // function getStoreMenu2(uint256 _storeIndex) public view returns(Menu[] memory){
    //   return menus;
    // }

    // onOff 변경 함수
    function changeOnOff() public {
        if (onOff == 0) {
            onOff = 1;
        } else if (onOff == 1) {
            onOff = 0;
        }
    }

    // 하나의 메뉴를 추가하는 함수
    function addOneMenu(
        string memory _chickenName,
        uint256 _price,
        uint8 _menuState
    ) public {
        menus.push(Menu(_chickenName, _price, _menuState, menus.length - 1));
    }

    // location 변경 함수
    function changeLocation(string memory _longitude, string memory _latitude)
        public
    {
        longitude = _longitude;
        latitude = _latitude;
    }

    // user1이 돈을 넣고 시간이 초과되었을때 환불되는 함수
    function refundToAUser(uint256 _roomIndex) public {
        OrderRoom orderRoom = findOrderRoom(_roomIndex);
        orderRoom.refundToAUser();
        roomCount--;
    }

    // user1과 user2 에게 환불
    function refundToBothUsers(uint256 _roomIndex) public onlyOwner {
        OrderRoom orderRoom = findOrderRoom(_roomIndex);
        orderRoom.refundToBothUsers();
        roomCount--;
    }
}
