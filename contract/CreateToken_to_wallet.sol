// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Phexpha is ERC20, Ownable {
    constructor(uint256 initialSupply) ERC20("Phex", "PHEX") {
        // ไม่มีการส่งพารามิเตอร์ไปยัง Ownable
        _mint(msg.sender, initialSupply * (10 ** uint256(decimals())));
    }

    function deductTokens(address from, uint256 amount) public onlyOwner {
        require(balanceOf(from) >= amount, "Insufficient balance");
        _transfer(from, address(this), amount);
    }
}
