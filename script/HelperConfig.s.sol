// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

// import {VRFCoordinatorV2Mock} from "../test/mocks/VRFCoordinatorV2Mock.sol";
// import {LinkToken} from "../test/mocks/LinkToken.sol";
import {Script} from "forge-std/Script.sol";

contract HelperConfig is Script {
    NetworkConfig public activeNetworkConfig;
    RouterConfig public activeRouterConfig;

    struct NetworkConfig {
        address link;
    }

    struct RouterConfig {
        address address_;
        uint64 chainSelector;
    }

    uint256 public DEFAULT_ANVIL_PRIVATE_KEY = 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80;

    // event HelperConfig__CreatedMockVRFCoordinator(address vrfCoordinator);

    constructor() {
        if (block.chainid == 11155111) {
            (activeNetworkConfig, activeRouterConfig) = getSepoliaEthConfig();
        } else if (block.chainid == 43113) {
            (activeNetworkConfig, activeRouterConfig) = getFujiAvalancheConfig();
        } else if (block.chainid == 80001) {
            (activeNetworkConfig, activeRouterConfig) = getMumbaiPolygonConfig();
        } else if (block.chainid == 84532) {
            (activeNetworkConfig, activeRouterConfig) = getBaseTestnetConfig();
        } else {
            // activeNetworkConfig = getOrCreateAnvilEthConfig();
            (activeNetworkConfig, activeRouterConfig) = getSepoliaEthConfig();
        }
    }

    function getMainnetEthConfig() public pure returns (NetworkConfig memory mainnetNetworkConfig) {
        mainnetNetworkConfig = NetworkConfig({link: 0x514910771AF9Ca656af840dff83E8264EcF986CA});
    }

    function getActiveNetworkConfig() public view returns (NetworkConfig memory) {
        return activeNetworkConfig;
    }

    function getActiveRouterConfig() public view returns (RouterConfig memory) {
        return activeRouterConfig;
    }

    function getSepoliaEthConfig()
        public
        pure
        returns (NetworkConfig memory sepoliaNetworkConfig, RouterConfig memory sepoliaRouterConfig)
    {
        sepoliaNetworkConfig = NetworkConfig({link: 0x779877A7B0D9E8603169DdbD7836e478b4624789});

        sepoliaRouterConfig =
            RouterConfig({address_: 0x0BF3dE8c5D3e8A2B34D2BEeB17ABfCeBaf363A59, chainSelector: 16015286601757825753});
    }

    function getFujiAvalancheConfig()
        public
        pure
        returns (NetworkConfig memory avalancheFujiNetworkConfig, RouterConfig memory avalancheRouterConfig)
    {
        avalancheFujiNetworkConfig = NetworkConfig({link: 0x0b9d5D9136855f6FEc3c0993feE6E9CE8a297846});

        avalancheRouterConfig =
            RouterConfig({address_: 0xF694E193200268f9a4868e4Aa017A0118C9a8177, chainSelector: 14767482510784806043});
    }

    function getMumbaiPolygonConfig()
        public
        pure
        returns (NetworkConfig memory polygonMumbaiNetworkConfig, RouterConfig memory polygonMumbaiRouterConfig)
    {
        polygonMumbaiNetworkConfig = NetworkConfig({link: 0x326C977E6efc84E512bB9C30f76E30c160eD06FB});

        polygonMumbaiRouterConfig =
            RouterConfig({address_: 0x1035CabC275068e0F4b745A29CEDf38E13aF41b1, chainSelector: 12532609583862916517});
    }

    function getBaseTestnetConfig()
        public
        pure
        returns (NetworkConfig memory baseTestnetNetworkConfig, RouterConfig memory baseTestnetRouterConfig)
    {
        baseTestnetNetworkConfig = NetworkConfig({link: 0xE4aB69C077896252FAFBD49EFD26B5D171A32410});

        baseTestnetRouterConfig =
            RouterConfig({address_: 0xD3b06cEbF099CE7DA4AcCf578aaebFDBd6e88a93, chainSelector: 10344971235874465080});
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
