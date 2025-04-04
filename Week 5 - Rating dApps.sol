pragma solidity ^0.5;

contract Rating {

    address owner;
    string[] users;
    mapping(string => User_Details) rating;

    constructor() public{
        owner = msg.sender;
    }


    // These modifiers can be applied to function to ensure certain conditions
    modifier onlyOwner(){
        require (msg.sender == owner);
        _;
    }

    // Ensures user exists
    modifier isInitiated(string memory _username){
        require(rating[_username].isInitited > 0);
        _;
    }

    // Ensures both the rater and rated user exists
    modifier bothInitiated(string memory _ratingFrom , string memory _ratingto) {
        require(rating[_ratingFrom].isInitited > 0 && rating[_ratingto].isInitited > 0);
        _;
    }

    struct User_Details{
        uint rating_total;
        uint times_voted;
        uint isInitited;
    }

    struct Rate_User {
        uint unique_id;
        uint rating;
    }

    event RatingActivity(
        string indexed rating_from,
        string indexed rating_to,
        uint rating
    );

    // Only the contract owner can add users
    function addUser(string memory _username) public onlyOwner {
        users.push(_username);
        rating[_username].rating_total = 0;
        rating[_username].isInitited = 1;
        rating[_username].times_voted = 0;
    }

    // Gets how many users
    function getUserSize() public view returns(uint) {
        return users.length;
    }

    function getUserRating(string memory _username) public isInitiated(_username) view returns(uint) {
        return rating[_username].rating_total;
    }

    function getUserTimesVoted(string memory _username) public isInitiated(_username) view returns(uint) {
        return rating[_username].times_voted;
    }

    // Any wallet address can add a rating.
    function addRating(string memory _ratingFrom , string memory _userRated , uint256 data) bothInitiated(_ratingFrom , _userRated) public {
        rating[_userRated].rating_total += data;
        rating[_userRated].times_voted++;
        emit RatingActivity(_ratingFrom , _userRated , data);
    }

    function getIntegerRating(string memory _userRated) public view returns (uint256) {
        uint total = rating[_userRated].rating_total;
        uint rate_count = rating[_userRated].times_voted;
        uint int_rating = div(total , rate_count); // Gets average rating
        return int_rating;
    }

    // Outputs two varialbes, the inputted users total rating and then the amount of times the user has been rated.
    function getRatingParameters(string memory _userRated) public view returns (uint , uint) {
        return (rating[_userRated].rating_total , rating[_userRated].times_voted);
    }

    // Divide function which is used to determine the average rating.
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b > 0);
        uint256 c = a / b;
        // assert(a == b * c + a % b);
        return c;
    }

}
