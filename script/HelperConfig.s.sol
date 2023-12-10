// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

// import {VRFCoordinatorV2Mock} from "../test/mocks/VRFCoordinatorV2Mock.sol";
// import {LinkToken} from "../test/mocks/LinkToken.sol";
import {Script} from "forge-std/Script.sol";

contract HelperConfig is Script {
    NetworkConfig public activeNetworkConfig;

    struct NetworkConfig {
        address link;
    }

    struct RouterConfig {
        address address_;
        string chainSelector;
    }

    uint256 public DEFAULT_ANVIL_PRIVATE_KEY =
        0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80;

    // event HelperConfig__CreatedMockVRFCoordinator(address vrfCoordinator);

    constructor() {
        if (block.chainid == 11155111) {
            (activeNetworkConfig, ) = getSepoliaEthConfig();
        } 
        else if (block.chainid == 43113) {
            (activeNetworkConfig, ) = getFujiAvalancheConfig();
        }
        else if (block.chainid == 80001) {
            (activeNetworkConfig, ) = getMumbaiPolygonConfig();
        }
        else {
            // activeNetworkConfig = getOrCreateAnvilEthConfig();
        }
    }

    function getMainnetEthConfig()
        public
        pure
        returns (NetworkConfig memory mainnetNetworkConfig)
    {
        mainnetNetworkConfig = NetworkConfig({
            link: 0x514910771AF9Ca656af840dff83E8264EcF986CA
        });
    }

    function getSepoliaEthConfig()
        public
        pure
        returns (NetworkConfig memory sepoliaNetworkConfig,
            RouterConfig memory sepoliaRouterConfig)
    {
        sepoliaNetworkConfig = NetworkConfig({
            link: 0x779877A7B0D9E8603169DdbD7836e478b4624789
        });

        sepoliaRouterConfig = RouterConfig({
            address_: 0xD0daae2231E9CB96b94C8512223533293C3693Bf,
            chainSelector: "16015286601757825753"
        });
    }

    function getFujiAvalancheConfig()
        public
        pure
        returns (NetworkConfig memory avalancheFujiNetworkConfig,
            RouterConfig memory avalancheRouterConfig)
    {
        avalancheFujiNetworkConfig = NetworkConfig({
            link: 0x0b9d5D9136855f6FEc3c0993feE6E9CE8a297846
        });

        avalancheRouterConfig = RouterConfig({
            address_: 0x554472a2720E5E7D5D3C817529aBA05EEd5F82D8,
            chainSelector: "14767482510784806043"
        });
    }

        function getMumbaiPolygonConfig()
        public
        pure
        returns (NetworkConfig memory polygonMumbaiNetworkConfig,
            RouterConfig memory polygonMumbaiRouterConfig)
    {
        polygonMumbaiNetworkConfig = NetworkConfig({
            link: 0x326C977E6efc84E512bB9C30f76E30c160eD06FB
        });

        polygonMumbaiRouterConfig = RouterConfig({
            address_: 0x70499c328e1E2a3c41108bd3730F6670a44595D1,
            chainSelector: "12532609583862916517"
        });
    }

    // function getOrCreateAnvilEthConfig()
    //     public
    //     returns (NetworkConfig memory anvilNetworkConfig)
    // {
    //     // Check to see if we set an active network config
    //     if (activeNetworkConfig.vrfCoordinatorV2 != address(0)) {
    //         return activeNetworkConfig;
    //     }

    //     uint96 baseFee = 0.25 ether;
    //     uint96 gasPriceLink = 1e9;

    //     vm.startBroadcast(DEFAULT_ANVIL_PRIVATE_KEY);
    //     VRFCoordinatorV2Mock vrfCoordinatorV2Mock = new VRFCoordinatorV2Mock(
    //         baseFee,
    //         gasPriceLink
    //     );

    //     LinkToken link = new LinkToken();
    //     vm.stopBroadcast();

    //     emit HelperConfig__CreatedMockVRFCoordinator(
    //         address(vrfCoordinatorV2Mock)
    //     );

    //     anvilNetworkConfig = NetworkConfig({
    //         subscriptionId: 0, // If left as 0, our scripts will create one!
    //         gasLane: 0x474e34a077df58807dbe9c96d3c009b23b3c6d0cce433e59bbf5b34f823bc56c, // doesn't really matter
    //         automationUpdateInterval: 30, // 30 seconds
    //         raffleEntranceFee: 0.01 ether,
    //         callbackGasLimit: 500000, // 500,000 gas
    //         vrfCoordinatorV2: address(vrfCoordinatorV2Mock),
    //         link: address(link),
    //         deployerKey: DEFAULT_ANVIL_PRIVATE_KEY
    //     });
    // }
}
