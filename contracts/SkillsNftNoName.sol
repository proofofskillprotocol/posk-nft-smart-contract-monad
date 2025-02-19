// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract ExternalMetadataNFT is ERC721URIStorage, Ownable {
    uint256 public tokenCounter;

    constructor() ERC721("SkillsNFT", "SNFT") Ownable(msg.sender) {
        tokenCounter = 0;
    }

    /**
     * @notice Mints a new NFT with tokenURI constructed using the provided username.
     * @param recipient The address that will receive the NFT.
     * @param username The username to be appended to the metadata API endpoint.
     * Note: The username should be URL-encoded if necessary.
     * @return tokenId The ID of the minted NFT.
     */
    function mintNFT(address recipient, string memory username)
        public
        onlyOwner
        returns (uint256)
    {
        uint256 tokenId = tokenCounter;
        _safeMint(recipient, tokenId);

        // Construct tokenURI by concatenating the base URL with the username.
        string memory baseURI = "https://api-dev.proofofskill.org/v1.0.0/api/public/nft/metadata?name=";
        string memory tokenURI = string(abi.encodePacked(baseURI, username));

        _setTokenURI(tokenId, tokenURI);

        tokenCounter++;
        return tokenId;
    }
}
