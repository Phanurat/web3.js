// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Login {
    address public tokenAddress;
    IERC20 public token;

    mapping(address => bool) public loggedIn;

    constructor(address _tokenAddress) {
        tokenAddress = _tokenAddress;
        token = IERC20(tokenAddress);
    }

    function login(uint256 amount) external {
        require(!loggedIn[msg.sender], "Already logged in");
        require(token.transferFrom(msg.sender, address(this), amount), "Transfer failed");

        loggedIn[msg.sender] = true;
    }

    function logout() external {
        require(loggedIn[msg.sender], "Not logged in");
        loggedIn[msg.sender] = false;
    }

    function checkLoginStatus() external view returns (bool) {
        return loggedIn[msg.sender];
    }
}
