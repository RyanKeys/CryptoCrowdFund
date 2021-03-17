pragma solidity ^0.8.2;

contract CrowdFund {

    address payable public owner;
    uint256 public endTime;
    uint256 public goal;
    uint256 public totalDonations;
    bool public donationsCollected;
    mapping(address => uint256) public donorToDonation;
    address[] public donorAddressIndex;

    event NewDonation(address donor, uint256 donation);
    event AnnounceResults(uint256 totalDonations);

    constructor(
        uint256 _goal,
        uint256 _lengthDays,
        uint256 _lengthHours,
        uint256 _lengthMinutes,
        address payable _owner
    ) public {
        goal = _goal;
        endTime = block.timestamp +
                    (_lengthHours * 3600) +
                    (_lengthDays * 86400) +
                    (_lengthMinutes * 60);
        owner = _owner;
    }

    modifier isFinished {
        require(block.timestamp >= endTime, "This listing is still active.");
        _;
    }

    modifier isNotFinished {
        require(block.timestamp < endTime, "This listing is finished.");
        _;
    }

    modifier isNotOwner {
        require(msg.sender != owner, "This is your listing.");
        _;
    }

    modifier donationsNotCollected {
        require(!donationsCollected, "Donations have already been collected.");
        _;
    }

    function listingEnd()
        isFinished
        donationsNotCollected
        public
    {
        donationsCollected = true;

        if (totalDonations >= goal) {
            emit AnnounceResults(totalDonations);
            selfdestruct(owner);
        } else {
            emit AnnounceResults(0);
            for (uint i=0; i<donorAddressIndex.length; i++) {
                payable(donorAddressIndex[i]).transfer(
                    donorToDonation[donorAddressIndex[i]]
                );
            }
        }
    }

    function submitDonation()
        payable
        isNotOwner
        isNotFinished
        public
    {
        require(msg.value > 0, "Invalid donation amount.");

        if (donorToDonation[msg.sender] > 0) {
            donorToDonation[msg.sender] = donorToDonation[msg.sender] +
                                            msg.value;
        } else {
            donorToDonation[msg.sender] = msg.value;
            donorAddressIndex.push(msg.sender);
        }

        totalDonations = totalDonations + msg.value;
        emit NewDonation(msg.sender, msg.value);
    }
}
