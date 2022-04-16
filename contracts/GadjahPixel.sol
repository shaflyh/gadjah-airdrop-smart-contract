//SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract GadjahPixel is ERC721, Ownable {
    using Strings for uint256;
    using Counters for Counters.Counter;

    Counters.Counter private supply;

    string public baseURI = "";
    string public baseExtension = ".json";
    uint256 public maxSupply = 4828;
    bool public paused = false;
    address public contractAddress; // Gadjah Society Contract Address

    mapping(address => uint256) public addressMintBalance;

    constructor() ERC721("Gadjah Pixel", "GDJHX") {
        // 0x88e7Bd25F1b7315a48Fcfa07d982DE05BE097FA3
        setContractAddress(0x60C0CFbA6F79142aDAbA3130c915D33d82fea86D);
    }

    // Public function //

    function mint(uint256 _tokenId) public payable {
        require(!paused, "The contract is paused!");
        require(contractAddress != address(0), "Contract address not set yet");
        require(
            IERC721(contractAddress).ownerOf(_tokenId) == msg.sender,
            "You do not own the Gadjah Society token"
        );
        _safeMint(msg.sender, _tokenId);
    }

    function totalSupply() public view returns (uint256) {
        return supply.current();
    }

    function walletOfOwner(address _owner)
        public
        view
        returns (uint256[] memory)
    {
        uint256 ownerTokenCount = balanceOf(_owner);
        uint256[] memory ownedTokenIds = new uint256[](ownerTokenCount);
        uint256 currentTokenId = 1;
        uint256 ownedTokenIndex = 0;

        while (
            ownedTokenIndex < ownerTokenCount && currentTokenId <= maxSupply
        ) {
            address currentTokenOwner = ownerOf(currentTokenId);

            if (currentTokenOwner == _owner) {
                ownedTokenIds[ownedTokenIndex] = currentTokenId;
                ownedTokenIndex++;
            }
            currentTokenId++;
        }
        return ownedTokenIds;
    }

    function tokenURI(uint256 tokenId)
        public
        view
        virtual
        override
        returns (string memory)
    {
        require(
            _exists(tokenId),
            "ERC721Metadata: URI query for nonexistent token"
        );

        string memory currentBaseURI = _baseURI();
        return
            bytes(currentBaseURI).length > 0
                ? string(
                    abi.encodePacked(
                        currentBaseURI,
                        tokenId.toString(),
                        baseExtension
                    )
                )
                : "";
    }

    // Only owner //

    function setContractAddress(address _contractAddress) public onlyOwner {
        contractAddress = _contractAddress;
    }

    function setBaseURI(string memory _newBaseURI) public onlyOwner {
        baseURI = _newBaseURI;
    }

    function setBaseExtension(string memory _baseExtension) public onlyOwner {
        baseExtension = _baseExtension;
    }

    function setPause(bool _state) public onlyOwner {
        paused = _state;
    }

    function withdraw() public onlyOwner {
        // Put remain balance to owner address
        (bool os, ) = payable(owner()).call{value: address(this).balance}("");
        require(os);
    }

    // Internal //

    function _baseURI() internal view virtual override returns (string memory) {
        return baseURI;
    }
}
