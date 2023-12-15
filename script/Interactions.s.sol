// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script, console} from "forge-std/Script.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";
import {MoodNft} from "../src/MoodNft.sol";
import {GameSessionNft} from "../src/GameSessionNft.sol";
import {SourceMinter} from "../src/ccip/SourceMinter.sol";
import {HelperConfig} from "./HelperConfig.s.sol";
import {LinkTokenInterface} from "@chainlink/contracts/src/v0.8/shared/interfaces/LinkTokenInterface.sol";

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

// contract MintCompleteXChainSepoliaToPolygon is Script {
//     string public constant COMPLETE_URL =
//         "data:application/json;base64,ewogICAgIm5hbWUiOiAiTW9ua2V5IFRyaXZpYSBTZXNzaW9uIENvbXBsZXRlZCIsCiAgICAiZGVzY3JpcHRpb24iOiAiR2FtZSBzZXNzaWlvbiBjb21wbGV0ZWQuICBZb3UgYXJlIGEgd2lubmVyISIsCiAgICAiaW1hZ2UiOiAiaHR0cHM6Ly9iYWZ5YmVpZXh4eTd2cHRwdGo2eXg2cmVodjV4cDRnYTd6enRiZTJ1ZHUyZDNnYTNiZTRnc243bmt4NC5pcGZzLm5mdHN0b3JhZ2UubGluay8iLAogICAgImF0dHJpYnV0ZXMiOiBbCiAgICAgICAgewogICAgICAgICAgICAidHJhaXRfdHlwZSI6ICJwbGFjZSIsCiAgICAgICAgICAgICJ2YWx1ZSI6ICIxc3QiCiAgICAgICAgfQogICAgXQp9";

//     uint256 deployerKey;

//     function run() external {
//         address mostRecentlyDeployedSourceMinter = DevOpsTools
//             .get_most_recent_deployment("SourceMinter", block.chainid);
//         mintNftCompletedSessionOnContract(mostRecentlyDeployedSourceMinter);
//         console.log("SourceMinter address: %s", mostRecentlyDeployedSourceMinter);
//     }

//     function mintNftCompletedSessionOnContract(address sourceMinterAddress) public {
//         HelperConfig helperConfig = new HelperConfig();
//         (,HelperConfig.RouterConfig memory routerConfig) = helperConfig.getMumbaiPolygonConfig();
//         vm.startBroadcast();
//         /*
//             Fees LINK:1, NATIVE:0
//         */

//        // get latest sourceMinterAddress mint(chainSelector, destinationMinter, PayFeesInLinkOrNative)
//         SourceMinter(payable(0x9041b59b5CCC47EFA7dfBF1497bC8bAD7AD5ad1E)).mint(routerConfig.chainSelector, address(0xBC4cF7731Dd2c8C5fed08F21E7cFc4c292D4C8a7), SourceMinter.PayFeesIn.Native,"");
//         vm.stopBroadcast();
//     }
// }

contract MintNftCompletedSessionPolygonToFuji is Script {
    string public constant COMPLETE_URL =
        "data:application/json;base64,ewogICAgIm5hbWUiOiAiTW9ua2V5IFRyaXZpYSBTZXNzaW9uIENvbXBsZXRlZCIsCiAgICAiZGVzY3JpcHRpb24iOiAiR2FtZSBzZXNzaWlvbiBjb21wbGV0ZWQuICBZb3UgYXJlIGEgd2lubmVyISIsCiAgICAiaW1hZ2UiOiAiaHR0cHM6Ly9iYWZ5YmVpZXh4eTd2cHRwdGo2eXg2cmVodjV4cDRnYTd6enRiZTJ1ZHUyZDNnYTNiZTRnc243bmt4NC5pcGZzLm5mdHN0b3JhZ2UubGluay8iLAogICAgImF0dHJpYnV0ZXMiOiBbCiAgICAgICAgewogICAgICAgICAgICAidHJhaXRfdHlwZSI6ICJwbGFjZSIsCiAgICAgICAgICAgICJ2YWx1ZSI6ICIxc3QiCiAgICAgICAgfQogICAgXQp9";

    uint256 deployerKey;

    function run() external {
        // address mostRecentlyDeployedSourceMinter = DevOpsTools
        //     .get_most_recent_deployment("SourceMinter", block.chainid);
        mintNftCompletedSessionPolygonToFuji();
        // console.log("SourceMinter address: %s", mostRecentlyDeployedSourceMinter);
    }

    function mintNftCompletedSessionPolygonToFuji() public {
        HelperConfig helperConfig = new HelperConfig();
        (HelperConfig.NetworkConfig memory networkConfig ,HelperConfig.RouterConfig memory routerConfig) = helperConfig.getMumbaiPolygonConfig();
        vm.startBroadcast();

        address mostRecentlyDeployedSourceMinter = DevOpsTools
            .get_most_recent_deployment("SourceMinter", block.chainid);

        address mostRecentlyDeployedDestinationMinter = DevOpsTools
            .get_most_recent_deployment("DestinationMinter", block.chainid);

        console.log("Link address: %s", networkConfig.link);

        uint balance = LinkTokenInterface(networkConfig.link).balanceOf(mostRecentlyDeployedSourceMinter);

        console.log("Link balance: %s", balance);
        //if link balance is less than 0.4, send 0.4 link to SourceMinter
        if(balance < 400000000000000000){            
            LinkTokenInterface(networkConfig.link).transferFrom(msg.sender, mostRecentlyDeployedSourceMinter, 400000000000000000);
            //print tx hash

            console.log("sending 0.4 link to SourceMinter, Try again!"); return;
        }

        // send 0.4 link to SourceMinter
        // LinkTokenInterface(networkConfig.link).transferFrom(msg.sender, mostRecentlyDeployedSourceMinter, 400000000000000000);
        // console.log("Link balance: %s", LinkTokenInterface(networkConfig.link).balanceOf(mostRecentlyDeployedSourceMinter));

       // get latest sourceMinterAddress mint(chainSelector, destinationMinter, PayFeesInLinkOrNative)
        SourceMinter(payable(mostRecentlyDeployedSourceMinter)).mint(
            routerConfig.chainSelector,
            address(mostRecentlyDeployedDestinationMinter), 
            SourceMinter.PayFeesIn.LINK,
            COMPLETE_URL
        );
        vm.stopBroadcast();
    }
}
