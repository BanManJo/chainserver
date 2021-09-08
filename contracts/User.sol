pragma solidity ^0.5.2;

contract User {
    struct UserInfo {
        string userId;
        address userAccount;
    }
    UserInfo[] public users;

    function userIf(string memory _userId, address _userAccount)
        public
        returns (bool)
    {
        UserInfo memory newUserInfo;
        newUserInfo.userId = _userId;
        newUserInfo.userAccount = _userAccount;
        users.push(newUserInfo);
        return true;
    }

    function getUserIf(uint256 _userAccountId)
        public
        view
        returns (string memory userId)
    {
        UserInfo memory userzz = users[_userAccountId];
        return (userzz.userId);
    }
}
