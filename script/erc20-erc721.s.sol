// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {ERC20_ERC721} from "../src//erc20-erc721.sol";

contract ERC20_ERC721Script is Script {
    ERC20_ERC721 public erc20_erc721;

    function setUp() public {
        erc20_erc721 = new ERC20_ERC721();
    }

    function run() public {
        vm.broadcast();
    }
}
