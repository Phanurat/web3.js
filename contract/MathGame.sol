// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MathReward {
    address public owner;
    mapping(address => uint256) public balances;

    event RewardSent(address indexed user, uint256 amount);

    constructor() {
        owner = msg.sender;
    }

    // ฟังก์ชันสำหรับการโอนเหรียญให้กับผู้ใช้
    function rewardUser(address user) external {
        require(msg.sender == owner, "Only the contract owner can reward users");
        uint256 rewardAmount = 10 * 10**18;  // รางวัล 10 เหรียญ (ขึ้นอยู่กับจำนวนทศนิยม)
        
        // เพิ่มยอดคงเหลือของผู้ใช้
        balances[user] += rewardAmount;

        emit RewardSent(user, rewardAmount);
    }

    // ฟังก์ชันให้ผู้ใช้ถอนเงิน
    function withdraw() external {
        uint256 amount = balances[msg.sender];
        require(amount > 0, "No balance to withdraw");
        
        balances[msg.sender] = 0;

        // โอนเหรียญไปยังผู้ใช้
        payable(msg.sender).transfer(amount);
    }

    // รับการฝากเงินเข้ามาใน contract
    receive() external payable {}
}
