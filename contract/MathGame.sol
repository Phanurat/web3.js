// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MathReward {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    // เติมเงินให้ smart contract
    function deposit() public payable {}

    // โอนเหรียญรางวัลให้กับผู้ใช้
    function rewardUser(address user) public {
        uint256 rewardAmount = 0.01 ether;  // รางวัลที่ต้องการโอน
        require(address(this).balance >= rewardAmount, "Insufficient funds in contract");

        payable(user).transfer(rewardAmount);
    }

    // ฟังก์ชันเช็คยอดใน smart contract
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

    // ดึงเงินออกจาก smart contract โดย owner
    function withdraw(uint256 amount) public {
        require(msg.sender == owner, "Only owner can withdraw funds");
        require(amount <= address(this).balance, "Not enough funds in contract");

        payable(owner).transfer(amount);
    }
}
