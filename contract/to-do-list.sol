// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PhexAir {
    string public name = "PhexAir";
    string public symbol = "PhexA";
    uint8 public decimals = 18;
    uint256 public totalSupply = 1000000 * (10 ** uint256(decimals));
    uint256 public claimAmount = 1000 * 10 ** decimals; // จำนวนเหรียญที่แจกต่อคน
    uint256 public rewardPerMinute = 10 * 10 ** decimals; // รางวัล Staking 10 PHEX ต่อ 1 นาที
    
    mapping(address => uint256) public balanceOf;
    mapping(address => bool) public hasClaimed; // ตรวจสอบว่าผู้ใช้เคย claim แล้วหรือยัง
    mapping(address => uint256) public stakedAmount; // จำนวนเหรียญที่ Staked
    mapping(address => uint256) public lastClaimTime; // เวลาที่ทำการ Staking ล่าสุด

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

    // 📌 1️⃣ ฟังก์ชันโอนเหรียญไปยังกระเป๋าที่ต้องการ
    function transferToken(address recipient, uint256 amount) external {
        require(balanceOf[msg.sender] >= amount, "Insufficient balance");
        balanceOf[msg.sender] -= amount;
        balanceOf[recipient] += amount;
    }

    // 📌 2️⃣ ฟังก์ชันเผาเหรียญในระบบ (ไม่ใช่จากกระเป๋าผู้ใช้)
    function burnFromContract(uint256 amount) external {
        require(balanceOf[address(this)] >= amount, "Not enough tokens in contract to burn");
        balanceOf[address(this)] -= amount; // ลดจำนวนเหรียญใน contract
        totalSupply -= amount; // ลด total supply
    }

    // 📌 3️⃣ ฟังก์ชัน Staking (ได้รับ 10 PHEX ทุก 1 นาที)
    function stake(uint256 amount) external {
        require(amount > 0, "Amount must be greater than 0");
        require(balanceOf[msg.sender] >= amount, "Insufficient balance");

        balanceOf[msg.sender] -= amount; // โอนเหรียญจากผู้ใช้ไปยัง contract
        stakedAmount[msg.sender] += amount; // อัปเดตจำนวนที่ Staked
        lastClaimTime[msg.sender] = block.timestamp; // บันทึกเวลาเริ่มต้น
    }

    // 📌 4️⃣ ฟังก์ชันสำหรับการ claim รางวัลจาก Staking
    function claimStakingReward() external {
        require(stakedAmount[msg.sender] > 0, "No staked tokens");

        uint256 timeElapsed = (block.timestamp - lastClaimTime[msg.sender]) / 60; // คำนวณเวลาที่ผ่านไปในนาที
        require(timeElapsed > 0, "Wait at least 1 minute");

        uint256 reward = timeElapsed * rewardPerMinute; // คำนวณรางวัลจากการ Staking
        require(balanceOf[address(this)] >= reward, "Not enough reward tokens");

        lastClaimTime[msg.sender] = block.timestamp; // อัปเดตเวลา claim ล่าสุด
        balanceOf[address(this)] -= reward; // ลดจำนวนเหรียญใน contract
        balanceOf[msg.sender] += reward; // โอนเหรียญรางวัลให้กับผู้ที่ Staked
    }

    // 📌 5️⃣ ฟังก์ชันถอน Staking (Unstake)
    function unstake() external {
        require(stakedAmount[msg.sender] > 0, "No staked tokens");

        uint256 amount = stakedAmount[msg.sender];
        stakedAmount[msg.sender] = 0; // รีเซ็ตจำนวน staked
        balanceOf[address(this)] -= amount; // ลดจำนวนเหรียญจาก contract
        balanceOf[msg.sender] += amount; // โอนเหรียญที่ Staked กลับไปให้ผู้ใช้
    }
}
