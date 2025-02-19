// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Base64.sol";

contract SkillsNFT is ERC721URIStorage, Ownable {
    uint256 public tokenCounter;

    // Pass msg.sender as the initial owner to the Ownable constructor.
    constructor() ERC721("SkillsNFT", "SNFT") Ownable(msg.sender) {
        tokenCounter = 0;
    }

    /**
     * @notice Mints a new NFT with dynamic metadata using the provided name and image URL, then transfers it to `recipient`.
     * @param recipient The EVM wallet address that will receive the NFT.
     * @param imageUrl The URL of the image to be used in the NFT metadata.
     * @param nftName The name to be used in the NFT metadata.
     * @return tokenId The ID of the minted NFT.
     */
    function mintNFT(
        address recipient,
        string memory imageUrl,
        string memory nftName
    ) public onlyOwner returns (uint256) {
        uint256 tokenId = tokenCounter;
        _safeMint(recipient, tokenId);

        // Construct the JSON metadata with dynamic name and image URL.
        string memory json = Base64.encode(
            bytes(
                string(
                    abi.encodePacked(
                        '{"name": "', nftName, '", ',
                        '"description": "Proof Of your Proof-of-Skill", ',
                        '"image": "', imageUrl, '"}'
                    )
                )
            )
        );

        // Create the final token URI by prepending the data URI scheme.
        string memory finalTokenURI = string(
            abi.encodePacked("data:application/json;base64,", json)
        );

        // Instead of embedding JSON on-chain, we directly set the token URI
        // to a hosted HTTPS link for the metadata.
        _setTokenURI(tokenId, imageUrl);

        // Set the token URI for the minted NFT.
        _setTokenURI(tokenId, finalTokenURI);

        tokenCounter++;
        return tokenId;
    }
}
