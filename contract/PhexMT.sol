// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract PhexMT is ERC20, Ownable {
    constructor() ERC20("PhexMT", "PHEX") {
        // Mint 1 million tokens to the owner
        _mint(msg.sender, 1000000 * 10 ** decimals());
    }

    function airdrop(address recipient, uint256 amount) external onlyOwner {
        require(amount <= 1000 * 10 ** decimals(), "Cannot send more than 1000 tokens at once");
        require(amount <= balanceOf(owner()), "Insufficient balance in contract");
        _transfer(owner(), recipient, amount);
    }
}
