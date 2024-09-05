// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PhexMT {
    string public name = "PhexMT";
    string public symbol = "Phex";
    uint8 public decimals = 18;
    uint256 public totalSupply = 1000000 * (10 ** uint256(decimals));
    mapping(address => uint256) public balanceOf;

    constructor() {
        // โอนเหรียญ 1 ล้านเหรียญให้กับ Smart Contract เอง
        balanceOf[address(this)] = totalSupply;
    }

    function transfer(address _to, uint256 _value) public returns (bool success) {
        require(balanceOf[address(this)] >= _value, "Insufficient contract balance");
        balanceOf[address(this)] -= _value;
        balanceOf[_to] += _value;
        return true;
    }
}
