// SPDX-License-Identifier: MIT
    pragma solidity ^0.8.13;

    import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
    import "@openzeppelin/contracts/access/Ownable.sol";
    import "@openzeppelin/contracts/utils/Strings.sol";
    import "@openzeppelin/contracts/utils/Counters.sol";
    import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

    contract MetaNFTToken is ERC721Enumerable, Ownable {
        using Strings for uint256;

        string _baseTokenURI;

        uint256 public maxTokenIds = 6;

        uint256 public tokenIds;

        using Counters for Counters.Counter;

        Counters.Counter private _tokenIdCounter;

        constructor (string memory baseURI) ERC721("MetaNFTToken", "MTA") {
            
            _baseTokenURI = baseURI;
        }

        function mintToken() public payable {
            require(tokenIds < maxTokenIds, "Sold out");
            tokenIds += 1;
            tokenIds = _tokenIdCounter.current();
            _tokenIdCounter.increment();
            _safeMint(msg.sender, tokenIds);
        }

        function _baseURI() internal view virtual override returns (string memory) {
            return _baseTokenURI;
        }

        function setBaseTokenURI(string memory baseURI) public {
        _baseTokenURI = baseURI;
        }

        function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
            require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");

            string memory baseURI = _baseURI();
   
            return bytes(baseURI).length > 0 ? string(abi.encodePacked(baseURI, tokenId.toString(), ".json")) : "";
        }

        receive() external payable {}
        fallback() external payable {}
    }
