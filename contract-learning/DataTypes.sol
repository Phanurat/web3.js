// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract Primitives {
    bool public  boo = true;

    int8 public u8 = 1;
    uint256 public u256 = 456;
    uint256 public u = 123;

    int8 public i8 = -1;
    int256 public i256 = 456;
    int256 public i = -123;

    int256 public minInt = type(int256).min;
    int256 public maxInt = type(int256).max;

    address public addr = 0x7007bb372140F253fb6279471918ECe999DDb37b;

    bytes1 a = 0xb5;
    bytes1 b = 0x56;

    bool public defaultBoo;
    uint256 public defaultUint;
    int256 public defaultInt;
    address public defaultAddr;
}
