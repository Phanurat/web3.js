// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MathToken is ERC20 {
    mapping(address => address) public userWallets;
    uint256 private correctAnswer;

    constructor() ERC20("MathToken", "MTK") {
        _mint(address(this), 1000000 * 10 ** decimals()); // Mint initial tokens to the contract
    }

    function setUserWallet(address _wallet) public {
        userWallets[msg.sender] = _wallet;
    }

    function setQuestion(uint256 _answer) public {
        correctAnswer = _answer;
    }

    function answerQuestion(uint256 _answer) public {
        require(_answer == correctAnswer, "Incorrect answer");
        address userWallet = userWallets[msg.sender];
        require(userWallet != address(0), "Wallet not set");

        _transfer(address(this), userWallet, 10 * 10 ** decimals()); // Example: Transfer 10 tokens
    }
}
