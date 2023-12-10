// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script, console} from "forge-std/Script.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";
import {MoodNft} from "../src/MoodNft.sol";
import {GameSessionNft} from "../src/GameSessionNft.sol";
import {SourceMinter} from "../src/ccip/SourceMinter.sol";

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
}

contract MintCompleteGameSessionNftBase64 is Script {
    string public constant COMPLETE_URL =
        "data:application/json;base64,ewogICAgIm5hbWUiOiAiTW9ua2V5IFRyaXZpYSBTZXNzaW9uIENvbXBsZXRlZCIsCiAgICAiZGVzY3JpcHRpb24iOiAiR2FtZSBzZXNzaWlvbiBjb21wbGV0ZWQuICBZb3UgYXJlIGEgd2lubmVyISIsCiAgICAiaW1hZ2UiOiAiaHR0cHM6Ly9iYWZ5YmVpZXh4eTd2cHRwdGo2eXg2cmVodjV4cDRnYTd6enRiZTJ1ZHUyZDNnYTNiZTRnc243bmt4NC5pcGZzLm5mdHN0b3JhZ2UubGluay8iLAogICAgImF0dHJpYnV0ZXMiOiBbCiAgICAgICAgewogICAgICAgICAgICAidHJhaXRfdHlwZSI6ICJwbGFjZSIsCiAgICAgICAgICAgICJ2YWx1ZSI6ICIxc3QiCiAgICAgICAgfQogICAgXQp9";

    uint256 deployerKey;

    function run() external {
        address mostRecentlyDeployedBasicNft = DevOpsTools
            .get_most_recent_deployment("GameSessionNft", block.chainid);
        mintNftCompletedSessionOnContract(mostRecentlyDeployedBasicNft);
    }

    function mintNftCompletedSessionOnContract(address nftAddress) public {
        vm.startBroadcast();
        GameSessionNft(nftAddress).mintNftComplete(COMPLETE_URL);
        vm.stopBroadcast();
    }
}
