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
     * @notice Mints a new NFT with the externally hosted metadata URL.
     * @param recipient The address that will receive the NFT.
     * @param tokenURI The HTTPS URL pointing to your metadata JSON file.
     * @return tokenId The ID of the minted NFT.
     */
    function mintNFT(address recipient, string memory tokenURI)
        public
        onlyOwner
        returns (uint256)
    {
        uint256 tokenId = tokenCounter;
        _safeMint(recipient, tokenId);
        _setTokenURI(tokenId, tokenURI);
        tokenCounter++;
        return tokenId;
    }
}
