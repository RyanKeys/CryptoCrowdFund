pragma solidity ^0.8.2;

import "./CrowdFundFactory.sol";

contract CrowdFund is CrowdFundFactory {

    mapping(string => uint256) donorIdToDonations;

    event NewDonation(uint listingId, uint256 donation, address donor);
    event AnnounceResults(uint listingId, uint256 totalDonations);

    modifier onlyNotOwnerOfListing(uint _listingId) {
        require(
            msg.sender != listingToOwner[_listingId],
            "This is your listing."
        );
        _;
    }

    modifier onlyFinishedListing(uint _listingId) {
        require(
            block.timestamp >= listings[_listingId].endTime,
            "This listing is still active."
        );
        _;
    }

    modifier onlyNotFinishedListing(uint _listingId) {
        require(
            block.timestamp < listings[_listingId].endTime,
            "This listing is finished."
        );
        _;
    }

    modifier onlyDonationsNotCollected(uint _listingId) {
        require(
            !listings[_listingId].donationsCollected,
            "Donations have already been collected."
        );
        _;
    }

    function submitDonation(uint _listingId)
        payable
        onlyNotOwnerOfListing(_listingId)
        onlyNotFinishedListing(_listingId)
    public {
        require(msg.value > 0, "Invalid donation amount.");
        string memory donationId = string(abi.encodePacked(abi.encodePacked(_listingId), abi.encodePacked(msg.sender)));

        if (donorIdToDonations[donationId] > 0) {
            donorIdToDonations[donationId] = donorIdToDonations[donationId] + msg.value;
        } else {
            donorIdToDonations[donationId] = msg.value;
            listings[_listingId].donorAddresses.push(msg.sender);
        }

        listings[_listingId].totalDonations = listings[_listingId].totalDonations + msg.value;
        emit NewDonation(_listingId, msg.value, msg.sender);
    }

    function listingEnd(uint _listingId)
        onlyFinishedListing(_listingId)
        onlyDonationsNotCollected(_listingId)
    public {
        listings[_listingId].donationsCollected = true;

        if (listings[_listingId].totalDonations >= listings[_listingId].goal) {
            emit AnnounceResults(_listingId, listings[_listingId].totalDonations);
            payable(listingToOwner[_listingId]).transfer(
                listings[_listingId].totalDonations
            );
        } else {
            emit AnnounceResults(_listingId, 0);
            for (uint i=0; i<listings[_listingId].donorAddresses.length; i++) {
            string memory donationId = string(abi.encodePacked(abi.encodePacked(_listingId), abi.encodePacked(msg.sender)));

                payable(listings[_listingId].donorAddresses[i]).transfer(
                    donorIdToDonations[donationId]
                );
            }
        }
    }
}
