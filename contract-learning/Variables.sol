// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

// การประกาศสัญญา (Smart Contract)
contract Variable {
    // ตัวแปรสาธารณะ (Public) ของสัญญา
    string public text = "Hello";  // ตัวแปรสตริงที่เก็บข้อความ "Hello"
    uint256 public num = 123;      // ตัวแปรจำนวนเต็มที่เก็บค่าที่เป็นตัวเลข 123

    // ฟังก์ชันที่เรียกใช้งานได้จากภายนอก
    function doSomething() public {
        uint256 i = 456;               // ตัวแปรจำนวนเต็มที่เก็บค่าที่เป็นตัวเลข 456
        uint256 timestamp = block.timestamp; // ตัวแปรที่เก็บเวลาปัจจุบันของบล็อก
        address sender = msg.sender;  // ตัวแปรที่เก็บที่อยู่ของผู้ที่เรียกใช้งานฟังก์ชัน
    }
}
