pragma solidity ^0.5.6;

import "./klaytn-contracts/token/KIP17/KIP17Full.sol";
import "./klaytn-contracts/token/KIP17/KIP17Mintable.sol";
import "./klaytn-contracts/token/KIP17/KIP17Burnable.sol";
import "./klaytn-contracts/token/KIP17/KIP17Pausable.sol";
import "./klaytn-contracts/ownership/Ownable.sol";
import "./libraries/EncodeLibrary.sol";

contract SimsShithandNFT is Ownable, KIP17Full("Sim's Shithand NFT", "SIMNFT"), KIP17Mintable, KIP17Burnable, KIP17Pausable {

    string public externalURL = "https://simyoungjae.com/";
    function setExternalURL(string calldata _externalURL) onlyOwner external {
        externalURL = _externalURL;
    }

    mapping(uint256 => string) public names;
    function setName(uint256 tokenId, string calldata name) onlyOwner external {
        names[tokenId] = name;
    }

    mapping(uint256 => string) public descriptions;
    function setDescription(uint256 tokenId, string calldata description) onlyOwner external {
        descriptions[tokenId] = description;
    }

    mapping(uint256 => string) public images;
    function setImage(uint256 tokenId, string calldata url) onlyOwner external {
        images[tokenId] = url;
    }

    function tokenURI(uint256 tokenId) public view returns (string memory) {
        require(_exists(tokenId), "KIP17Metadata: URI query for nonexistent token");
        return string(
            abi.encodePacked(
                "data:application/json;base64,",
                EncodeLibrary.encode(
                    bytes(
                        string(
                            abi.encodePacked(
                                '{"name": "', 
                                names[tokenId],
                                '", "description": "',
                                descriptions[tokenId],
                                '", "external_url": "',
                                externalURL,
                                '", "image": "',
                                images[tokenId],
                                '"}'
                            )
                        )
                    )
                )
            )
        );
    }
}
