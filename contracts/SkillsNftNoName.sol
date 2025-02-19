// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract SkillsNFT is ERC721URIStorage, Ownable {
    uint256 public tokenCounter;

    // Pass msg.sender as the initial owner to the Ownable constructor.
    constructor() ERC721("SkillsNFT", "SNFT") Ownable(msg.sender) {
        tokenCounter = 0;
    }

    /**
     * @notice Mints a new NFT and sets the token URI to an HTTPS link pointing to hosted metadata.
     * @param recipient The EVM wallet address that will receive the NFT.
     * @param tokenURI The HTTPS URL of the metadata JSON file (e.g., "https://example.com/metadata/1.json").
     * @return tokenId The ID of the minted NFT.
     */
    function mintNFT(
        address recipient,
        string memory tokenURI
    ) public onlyOwner returns (uint256) {
        uint256 tokenId = tokenCounter;
        _safeMint(recipient, tokenId);

        // Instead of embedding JSON on-chain, we directly set the token URI
        // to a hosted HTTPS link for the metadata.
        _setTokenURI(tokenId, tokenURI);

        tokenCounter++;
        return tokenId;
    }
}
