// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract QualityContract {
    mapping(address => bool) public stakeholders;
    uint256 public qualityScore;

    modifier onlyStakeholder() {
        require(stakeholders[msg.sender], "Only stakeholder can execute this");
        _;
    }

    // Input has to be list, comma seperated and string formatted addreses ["addr", "addr"]
    constructor(address[] memory initialStakeholders) {
        for (uint256 i = 0; i < initialStakeholders.length; i++) {
            stakeholders[initialStakeholders[i]] = true;
        }
        qualityScore = 0;
    }

    // Only stake holders can execute this, this does not include the owner
    function updateQualityScore(uint256 newScore) external onlyStakeholder {
        qualityScore = newScore;
    }

    // Only stake holders can execute this, this does not include the owner.
    function addStakeholder(address newStakeholder) external onlyStakeholder {
        stakeholders[newStakeholder] = true;
    }
}
