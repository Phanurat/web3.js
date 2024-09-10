// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PhexAir {
    string public name = "PhexAir";
    string public symbol = "PhexA";
    uint8 public decimals = 18;
    uint256 public totalSupply = 1000000 * (10 ** uint256(decimals));
    uint256 public claimAmount = 1000 * 10 ** decimals; // จำนวนเหรียญที่แจกต่อคน
    mapping(address => uint256) public balanceOf;
    mapping(address => bool) public hasClaimed; // ตรวจสอบว่าผู้ใช้เคย claim แล้วหรือยัง

    constructor() {
        // โอนเหรียญ 1 ล้านเหรียญให้กับ Smart Contract เอง
        balanceOf[address(this)] = totalSupply;
    }

    // ฟังก์ชันสำหรับการ claim เหรียญ
    function claimTokens() external {
        require(!hasClaimed[msg.sender], "You have already claimed your tokens."); // ตรวจสอบว่าผู้ใช้เคย claim แล้วหรือยัง
        require(balanceOf[address(this)] >= claimAmount, "Not enough tokens left to claim."); // ตรวจสอบว่ามีเหรียญพอหรือไม่

        hasClaimed[msg.sender] = true; // ตั้งค่าว่าผู้ใช้นี้รับเหรียญแล้ว
        balanceOf[address(this)] -= claimAmount; // ลดจำนวนเหรียญใน contract
        balanceOf[msg.sender] += claimAmount; // เพิ่มจำนวนเหรียญให้กับผู้ใช้
    }

    // ฟังก์ชันสำหรับเจ้าของในการเติมเหรียญเข้ามาใน contract
    function fundContract(uint256 amount) external {
        require(balanceOf[msg.sender] >= amount, "Insufficient balance");
        balanceOf[msg.sender] -= amount;
        balanceOf[address(this)] += amount;
    }
}
