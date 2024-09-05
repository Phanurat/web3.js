// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IMyToken {
    function transfer(address _to, uint256 _value) external returns (bool);
    function balanceOf(address _owner) external view returns (uint256);
}

contract Airdrop {
    IMyToken public token;
    mapping(address => bool) public hasClaimed;

    uint256 public airdropAmount = 100 * (10 ** 18); // ให้ claim 100 เหรียญต่อผู้ใช้

    constructor(address _tokenAddress) {
        token = IMyToken(_tokenAddress);
    }

    function claimAirdrop() public {
        require(!hasClaimed[msg.sender], "You have already claimed your airdrop");
        require(token.balanceOf(address(this)) >= airdropAmount, "Insufficient contract balance");

        hasClaimed[msg.sender] = true;
        token.transfer(msg.sender, airdropAmount);  // โอนเหรียญให้ผู้ใช้
    }
}
