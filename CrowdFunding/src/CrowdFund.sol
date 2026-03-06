// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract CrowdFund {
    /* =============================================================
                            STEP 1
       Create the Campaign struct.
       It must store:
       - owner (address)
       - goal (uint256)
       - pledged amount (uint256)
       - start time (uint256)
       - end time (uint256)
       - claimed status (bool)
    ============================================================= */

    // TODO: Define struct here
    struct Campaign {
        address owner;
        uint256 goal;
        uint256 pledged;
        uint256 startAt;
        uint256 endAt;
        bool claimed;
    }

    /* =============================================================
                            STEP 2
       Create state variables:
       - campaignCount (uint256)
       - mapping from campaignId to Campaign
       - nested mapping to track how much each address pledged
    ============================================================= */

    // TODO: Declare campaignCount
    uint256 public campaignCount;

    // TODO: Declare campaigns mapping
    mapping(uint256 => Campaign) public campaigns;

    // TODO: Declare pledgedAmount nested mapping
    mapping(uint256 => mapping(address => uint256)) public pledgedAmount;

    /* =============================================================
                            STEP 3
       Create the create() function.
       It should:
       - Accept goal and duration
       - Increment campaignCount
       - Create a new Campaign struct
       - Set owner to msg.sender
       - Set pledged to 0
       - Set startAt to current block.timestamp
       - Set endAt to block.timestamp + duration
       - Set claimed to false
    ============================================================= */

    // TODO: Implement create()
    function create(uint256 _goal, uint256 _duration) external {
        require(_goal > 0, "Goal must be greater than 0");
        require(_duration > 0, "Duration must be grater than 0");

        campaignCount++;
        campaigns[campaignCount] = Campaign({
            owner: msg.sender,
            goal: _goal,
            pledged: 0,
            startAt: block.timestamp,
            endAt: block.timestamp + _duration,
            claimed: false
        });
    }

    /* =============================================================
                            STEP 4
       Create the pledge() function.
       It should:
       - Be payable
       - Take campaign ID
       - Check campaign has not ended
       - Increase total pledged
       - Increase user’s pledged amount
    ============================================================= */

    // TODO: Implement pledge()
    function pledge(uint256 _campaignId) external payable {
        Campaign storage campaign = campaigns[_campaignId];
        require(block.timestamp < campaign.endAt, "Campaign has ended");
        require(msg.value > 0, "Pledge amount must be greater than 0");

        campaign.pledged += msg.value;
        pledgedAmount[_campaignId][msg.sender] += msg.value;
    }

    /* =============================================================
                            STEP 5
       Create the claim() function.
       It should:
       - Allow only campaign owner
       - Require campaign ended
       - Require goal reached
       - Require not already claimed
       - Mark claimed = true
       - Transfer total pledged to owner
    ============================================================= */

    // TODO: Implement claim()
    function claim(uint256 _campaignId) external {
        Campaign storage campaign = campaigns[_campaignId];
        require(msg.sender == campaign.owner, "only owner can claim");
        require(block.timestamp >= campaign.endAt, "Campaign has not ended");
        require(campaign.pledged >= campaign.goal, "Goal not reached");
        require(!campaign.claimed, "Already claimed");
        campaign.claimed = true;
        payable(campaign.owner).transfer(campaign.pledged);

    /* =============================================================
                            STEP 6
       Create the refund() function.
       It should:
       - Require campaign ended
       - Require goal NOT reached
       - Get user pledged amount
       - Set user pledged amount to 0
       - Transfer ETH back to user
    ============================================================= */

    // TODO: Implement refund()
     
}
