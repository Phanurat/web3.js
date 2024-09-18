// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PhexAir {
    string public name = "PhexAir";
    string public symbol = "PhexA2"; // เปลี่ยนชื่อเป็น PhexA2
    uint8 public decimals = 18;
    uint256 public totalSupply = 1000000 * (10 ** uint256(decimals));
    uint256 public claimAmount = 1000 * 10 ** decimals; // จำนวนเหรียญที่แจกต่อคน
    mapping(address => uint256) public balanceOf;
    mapping(address => uint256) public questionResult; // ผลลัพธ์ของโจทย์คณิตศาสตร์ที่ต้องตอบ

    constructor() {
        // โอนเหรียญ 1 ล้านเหรียญให้กับ Smart Contract เอง
        balanceOf[address(this)] = totalSupply;
    }

    // ฟังก์ชันสำหรับการสร้างโจทย์คณิตศาสตร์ง่าย ๆ
    function generateMathQuestion() public {
        // สร้างเลข 2 ตัวที่ใช้ในโจทย์คณิตศาสตร์ (ไม่ต้องซับซ้อน)
        uint256 num1 = uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender))) % 10 + 1;
        uint256 num2 = uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender, num1))) % 10 + 1;
        
        // กำหนดให้เป็นโจทย์บวก
        questionResult[msg.sender] = num1 + num2;

        // ส่งโจทย์ให้ผู้ใช้ (ไม่สามารถส่งแบบ chain ได้ ให้ผู้ใช้จำลองว่ารับโจทย์ไปตอบ)
        // ตัวอย่าง: "Solve: num1 + num2"
        // ผู้ใช้ต้องนำคำตอบมาใส่ในฟังก์ชัน claimTokens
    }

    // ฟังก์ชันสำหรับการ claim เหรียญเมื่อผู้ใช้ตอบถูก
    function claimTokens(uint256 answer) external {
        require(balanceOf[address(this)] >= claimAmount, "Not enough tokens left to claim."); // ตรวจสอบว่ามีเหรียญพอหรือไม่
        require(answer == questionResult[msg.sender], "Incorrect answer to the math question."); // ตรวจสอบว่าผู้ใช้ตอบโจทย์ถูกหรือไม่

        // ส่งเหรียญให้กับผู้ใช้ได้หลายครั้งตามต้องการ (ไม่มีข้อจำกัดแล้ว)
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
