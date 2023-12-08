// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script, console} from "forge-std/Script.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";
import {BasicNft} from "../src/BasicNft.sol";
import {MoodNft} from "../src/MoodNft.sol";
import {GameSessionNft} from "../src/GameSessionNft.sol";

contract MintBasicNft is Script {
    string public constant PUG_URI =
        "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";
    uint256 deployerKey;

    function run() external {
        address mostRecentlyDeployedBasicNft =
            DevOpsTools.get_most_recent_deployment("BasicNft", block.chainid);
        mintNftOnContract(mostRecentlyDeployedBasicNft);
    }

    function mintNftOnContract(address basicNftAddress) public {
        vm.startBroadcast();
        BasicNft(basicNftAddress).mintNft(PUG_URI);
        vm.stopBroadcast();
    }
}

contract DeployGameSessionNft is Script {
    string public constant ACTIVE_URI =
        "https://bafkreiapzeyrdkua4x7fkzfcdnbxro5bh2kzqqfta5knstzo54ittisbga.ipfs.nftstorage.link/";
    uint256 deployerKey;

    function run() external {
        address mostRecentlyDeployedBasicNft = DevOpsTools
            .get_most_recent_deployment("GameSessionNft", block.chainid);
        mintNftOnContract(mostRecentlyDeployedBasicNft);
    }

    function mintNftOnContract(address basicNftAddress) public {
        vm.startBroadcast();
        GameSessionNft(basicNftAddress).mintNftActive(ACTIVE_URI);
        vm.stopBroadcast();
    }
}

contract MintGameSessionNft is Script {
    string public constant ACTIVE_URL =
        "https://bafkreiapzeyrdkua4x7fkzfcdnbxro5bh2kzqqfta5knstzo54ittisbga.ipfs.nftstorage.link/";

    string public constant COMPLETE_URL =
        "https://bafkreih3uethjok3wtnyyg6knpc3oyko4lc5cehs4nx6qvmmsgnu6qebgm.ipfs.nftstorage.link/";
    uint256 deployerKey;

    function run() external {
        address mostRecentlyDeployedBasicNft = DevOpsTools
            .get_most_recent_deployment("GameSessionNft", block.chainid);
        mintNftActiveSessionOnContract(mostRecentlyDeployedBasicNft);
    }

    function mintNftActiveSessionOnContract(address nftAddress) public {
        vm.startBroadcast();
        GameSessionNft(nftAddress).mintNftActive(ACTIVE_URL);
        vm.stopBroadcast();
    }

    function mintNftCompletedSessionOnContract(address nftAddress) public {
        vm.startBroadcast();
        GameSessionNft(nftAddress).mintNftComplete(COMPLETE_URL);
        vm.stopBroadcast();
    }
}

contract MintMoodNft is Script {
    function run() external {
        address mostRecentlyDeployedBasicNft =
            DevOpsTools.get_most_recent_deployment("MoodNft", block.chainid);
        mintNftOnContract(mostRecentlyDeployedBasicNft);
    }

    function mintNftOnContract(address moodNftAddress) public {
        vm.startBroadcast();
        MoodNft(moodNftAddress).mintNft();
        vm.stopBroadcast();
    }
}

contract FlipMoodNft is Script {
    uint256 public constant TOKEN_ID_TO_FLIP = 0;

    function run() external {
        address mostRecentlyDeployedBasicNft =
            DevOpsTools.get_most_recent_deployment("MoodNft", block.chainid);
        flipMoodNft(mostRecentlyDeployedBasicNft);
    }

    function flipMoodNft(address moodNftAddress) public {
        vm.startBroadcast();
        MoodNft(moodNftAddress).flipMood(TOKEN_ID_TO_FLIP);
        vm.stopBroadcast();
    }
}
