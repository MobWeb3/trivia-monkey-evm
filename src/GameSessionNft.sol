// Layout of Contract:
// version
// imports
// errors
// interfaces, libraries, contracts
// Type declarations
// State variables
// Events
// Modifiers
// Functions

// Layout of Functions:
// constructor
// receive function (if exists)
// fallback function (if exists)
// external
// public
// internal
// private
// view & pure functions

// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract GameSessionNft is ERC721, Ownable {
    // error ERC721Metadata__URI_QueryFor_NonExistentToken();
    // error GameSessionNft__TokenUriNotFound();

    enum NFTState {
        ACTIVE,
        COMPLETE
    }

    uint256 private s_tokenCounter;
    mapping(uint256 tokenId => string tokenUri) private s_tokenIdToUri;
    mapping(uint256 => NFTState) private s_tokenIdToState;

    event CreatedNFT(uint256 indexed tokenId);

    constructor() ERC721("MonkeyTrivia NFT", "MTSession") Ownable(msg.sender) {
        s_tokenCounter = 0;
    }

    function mintNft(string memory tokenUri) private {
        s_tokenIdToUri[s_tokenCounter] = tokenUri;
        _safeMint(msg.sender, s_tokenCounter);
    }

    function mintNftActive(string memory tokenUri) external {
        mintNft(tokenUri);
        s_tokenIdToState[s_tokenCounter] = NFTState.ACTIVE;
        s_tokenCounter = s_tokenCounter + 1;
    }

    function mintNftComplete(string memory tokenUri) external {
        mintNft(tokenUri);
        s_tokenIdToState[s_tokenCounter] = NFTState.COMPLETE;
        s_tokenCounter = s_tokenCounter + 1;
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override
        returns (string memory)
    {
        return s_tokenIdToUri[tokenId];
    }

    function getTokenCounter() public view returns (uint256) {
        return s_tokenCounter;
    }

    function getTokenIdToState(uint256 tokenId)
        public
        view
        returns (NFTState)
    {
        return s_tokenIdToState[tokenId];
    }
}
