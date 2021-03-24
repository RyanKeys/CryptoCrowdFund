pragma solidity ^0.8.2;

contract CrowdFundFactory {

    event NewListing(address owner, uint listingId);

    struct Listing {
        uint32 endTime;
        uint256 goal;
        uint256 totalDonations;
        bool donationsCollected;
        address[] donorAddresses;
    }

    Listing[] public listings;

    mapping (uint => address) public listingToOwner;

    function createListing (
        uint256 _goal,
        uint256 _lengthSeconds
    ) public {
        listings.push(
            Listing(
                uint32(block.timestamp + _lengthSeconds),
                _goal,
                0,
                false,
                new address[](0)
            )
        );
        uint id = listings.length - 1;
        listingToOwner[id] = msg.sender;
        emit NewListing(msg.sender, id);
    }
}
