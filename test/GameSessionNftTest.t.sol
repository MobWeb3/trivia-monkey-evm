// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {DeployGameSessionNft} from "../script/DeployGameSessionNft.s.sol";
import {GameSessionNft} from "../src/GameSessionNft.sol";
import {Test, console} from "forge-std/Test.sol";
import {StdCheats} from "forge-std/StdCheats.sol";
import {MintBasicNft} from "../script/Interactions.s.sol";

contract GameSessionNftTest is StdCheats, Test {
    string constant NFT_NAME = "MonkeyTrivia NFT";
    string constant NFT_SYMBOL = "MTSession";
    GameSessionNft public gameSessionNft;
    DeployGameSessionNft public deployer;
    address public deployerAddress;

    string public constant ACTIVE_URI =
        "https://bafkreiapzeyrdkua4x7fkzfcdnbxro5bh2kzqqfta5knstzo54ittisbga.ipfs.nftstorage.link/";
    address public constant USER = address(1);

    function setUp() public {
        deployer = new DeployGameSessionNft();
        gameSessionNft = deployer.run();
    }

    function testInitializedCorrectly() public view {
        assert(
            keccak256(abi.encodePacked(gameSessionNft.name())) ==
                keccak256(abi.encodePacked((NFT_NAME)))
        );
        assert(
            keccak256(abi.encodePacked(gameSessionNft.symbol())) ==
                keccak256(abi.encodePacked((NFT_SYMBOL)))
        );
    }

    // function testCanMintAndHaveABalance() public {
    //     vm.prank(USER);
    //     basicNft.mintNft(PUG_URI);

    //     assert(basicNft.balanceOf(USER) == 1);
    // }

    // function testTokenURIIsCorrect() public {
    //     vm.prank(USER);
    //     basicNft.mintNft(PUG_URI);

    //     assert(
    //         keccak256(abi.encodePacked(basicNft.tokenURI(0))) ==
    //             keccak256(abi.encodePacked(PUG_URI))
    //     );
    // }

    // function testMintWithScript() public {
    //     uint256 startingTokenCount = basicNft.getTokenCounter();
    //     MintBasicNft mintBasicNft = new MintBasicNft();
    //     mintBasicNft.mintNftOnContract(address(basicNft));
    //     assert(basicNft.getTokenCounter() == startingTokenCount + 1);
    // }

    // can you get the coverage up?
}
