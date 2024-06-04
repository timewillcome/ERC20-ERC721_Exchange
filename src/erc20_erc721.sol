// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {IERC20} from "../lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import {IERC721} from "../lib/openzeppelin-contracts/contracts/token/ERC721/IERC721.sol";

/// @author Alp (Yusuf) Çilo
/// @title A contract that can set balance for any ERC721 token and transfer for given ERC20 token.
/// @notice twitter.com/alptimewillcome
/// @notice have a good day
contract ERC20_ERC721 {
    // no re entracy at these both mappings needed do it in the same function but before transaction

    // change nft owner after transfer completed
    mapping(uint256 _nftId => address _nftOwner) public erc721Owner;
    // change after transfer
    mapping(address _erc721Owner => mapping(uint256 _erc721Id => uint256 _erc20Price))
        public priceOfNFTs;

    /// @notice First, you need to approve this contract from your erc721 contract.
    // test requirements given at IERC721 in test
    function setBalance(
        address _erc721Contract,
        uint256 _tokenId,
        uint256 _tokenPrice
    ) public {
        IERC721 IERC721Contract = IERC721(_erc721Contract);
        require(IERC721Contract.ownerOf(_tokenId) == erc721Owner[_tokenId]);
        // checks if this contract
        require(IERC721Contract.getApproved(_tokenId) == address(this));
        priceOfNFTs[msg.sender][_tokenId] = _tokenPrice;
    }

    /// @notice buyAny nft that has been approved to this contract and set balance.
    /// @notice could've been called the other safeTransferFrom without setting data but in that function it calls the other function
    /// @notice that sets data its more work and I believe and will try at REMIX its more gas efficiency
    function buyNFT(
        address _erc721Contract,
        address _erc20Contract,
        uint256 _tokenId
    ) public {
        IERC721 IERC721Contract = IERC721(_erc721Contract);
        IERC20 IERC20Contract = IERC20(_erc20Contract);
        require(IERC721Contract.ownerOf(_tokenId) == erc721Owner[_tokenId]);
        IERC721Contract.safeTransferFrom(
            address(this),
            msg.sender,
            _tokenId,
            ""
        );
        IERC20Contract.transferFrom(
            msg.sender,
            IERC721Contract.ownerOf(_tokenId),
            priceOfNFTs[erc721Owner[_tokenId]][_tokenId]
        );
    }
}
