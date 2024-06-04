// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {ERC20_ERC721} from "../src/erc20_erc721.sol";

contract CounterTest is Test {
    ERC20_ERC721 public erc20_erc721;

    function setUp() public {
        erc20_erc721 = new ERC20_ERC721();
    }
}
