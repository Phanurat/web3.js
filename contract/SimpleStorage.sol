// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleStorage {
    uint256 public storedData;

    // ฟังก์ชันสำหรับตั้งค่า
    function set(uint256 x) public {
        storedData = x;
    }

    // ฟังก์ชันสำหรับดึงค่า
    function get() public view returns (uint256) {
        return storedData;
    }
}
