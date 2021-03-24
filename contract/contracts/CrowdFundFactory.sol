pragma solidity ^0.8.2;

contract CrowdFundFactory {

    event NewListing(address owner, uint listingId, uint256 goal, uint32 endTime);

    struct Listing {
        uint32 endTime;
        uint256 goal;
        uint256 totalDonations;
        bool donationsCollected;
        address[] donorAddresses;
    }

    Listing[] public listings;

    mapping (uint => address) public listingToOwner;

    modifier onlyValidGoal(uint256 _goal) {
        require(
            _goal > 0,
            "Invalid _goal"
        );
        _;
    }

    modifier onlyValidLength(uint32 _lengthSeconds) {
        /* require(
            _lengthSeconds > 0,
            "Invalid _lengthSeconds"
        ); */
        require(
            _lengthSeconds <= 31536000,
            "Invalid _lengthSeconds"
        );
        _;
    }

    function createListing (uint256 _goal, uint32 _lengthSeconds)
        onlyValidGoal(_goal)
        onlyValidLength(_lengthSeconds)
    public {
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
        emit NewListing(msg.sender, id, _goal, uint32(block.timestamp + _lengthSeconds));
    }
}
