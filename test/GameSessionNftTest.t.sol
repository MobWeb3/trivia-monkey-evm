// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {DeployGameSessionNft} from "../script/DeployGameSessionNft.s.sol";
import {GameSessionNft} from "../src/GameSessionNft.sol";
import {Test, console} from "forge-std/Test.sol";
import {StdCheats} from "forge-std/StdCheats.sol";
import {MintGameSessionNft} from "../script/Interactions.s.sol";

contract GameSessionNftTest is StdCheats, Test {
    string constant NFT_NAME = "MonkeyTrivia NFT";
    string constant NFT_SYMBOL = "MTSession";
    GameSessionNft public gameSessionNft;
    DeployGameSessionNft public deployer;
    address public deployerAddress;

    string public constant ACTIVE_URI =
        "https://bafkreiapzeyrdkua4x7fkzfcdnbxro5bh2kzqqfta5knstzo54ittisbga.ipfs.nftstorage.link";

    string public constant COMPLETE_URI =
        "https://bafkreih3uethjok3wtnyyg6knpc3oyko4lc5cehs4nx6qvmmsgnu6qebgm.ipfs.nftstorage.link/";

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

    function testCanMintAndHaveABalance() public {
        vm.prank(USER);
        gameSessionNft.mintNftActive(ACTIVE_URI);

        assert(gameSessionNft.balanceOf(USER) == 1);
    }

    function testTokenActiveURIIsCorrect() public {
        vm.prank(USER);
        gameSessionNft.mintNftActive(ACTIVE_URI);

        assert(
            keccak256(abi.encodePacked(gameSessionNft.tokenURI(0))) ==
                keccak256(abi.encodePacked(ACTIVE_URI))
        );
    }

    function testTokenCompleteURIIsCorrect() public {
        vm.prank(USER);
        gameSessionNft.mintNftComplete(COMPLETE_URI);

        assert(
            keccak256(abi.encodePacked(gameSessionNft.tokenURI(0))) ==
                keccak256(abi.encodePacked(COMPLETE_URI))
        );
    }

    function testMintWithActiveSessionScript() public {
        uint256 startingTokenCount = gameSessionNft.getTokenCounter();
        MintGameSessionNft mintGameSessionNft = new MintGameSessionNft();
        mintGameSessionNft.mintNftActiveSessionOnContract(address(gameSessionNft));
        assert(gameSessionNft.getTokenCounter() == startingTokenCount + 1);
        assert(gameSessionNft.getTokenIdToState(0) == GameSessionNft.NFTState.ACTIVE);
    }

    function testMintWithCompleteSessionScript() public {
        uint256 startingTokenCount = gameSessionNft.getTokenCounter();
        MintGameSessionNft mintGameSessionNft = new MintGameSessionNft();
        mintGameSessionNft.mintNftCompletedSessionOnContract(address(gameSessionNft));
        assert(gameSessionNft.getTokenCounter() == startingTokenCount + 1);
        assert(gameSessionNft.getTokenIdToState(0) == GameSessionNft.NFTState.COMPLETE);
    }
}
