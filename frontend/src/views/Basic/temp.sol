// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/utils/Context.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Address.sol";
import "hardhat/console.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract LotteryContract is Ownable, ReentrancyGuard{
    using Address for address;
    using SafeERC20 for IERC20;
    using Counters for Counters.Counter;
    Counters.Counter private totalPlayer;
    Counters.Counter private lotteryListCount;

    IERC20 public betToken;
    uint[] public tier;
    struct User{
        // string  name;
        address addr;
        uint index;
        bool registered;
        
    }
    struct Player{
        address addr;
        uint playerListIndex;
        bool betted;
        uint betIndex;
        uint8 option1;
        uint8 option2;
        uint8 option3;
        uint score;
        bool win;
    }
    struct Lottery{
        uint index;
        uint betIndex1;
        uint betIndex2;
        Player player1;
        Player player2;
        uint8 win;          // 0: love, 1:player1, 2:player2
        uint award;
        uint fee;
    }
    mapping(address=>User) userMap;
    mapping(address=>Player) playerAddrMap;
    User[] public userList;
    uint userIdx;
    Player[] public playerList;
    mapping(uint=>Player[]) playersByBetMap;
    mapping(address=>address ) playerPair;
    address[] restPlayerAddrList;
    Player onlyOnePlayer;
    Lottery[] lotteryList;
    mapping(address=>Lottery) lotteryMap;
    // mapping(uint=>address) playerListIdxMap;
    constructor(){
        uint i=5;
        uint j=2;
        console.log(i/j);
        // userIdx = 0;
        // // totalPlayer = 0;
        // for (uint8 i=0; i<10; i++){
        //     playerIdx[i] = 0;
        //     lotteryIdx[i] = 0;
        // }
        // // state = "FINISHED";
    }
    modifier unregistered {
        require(userMap[msg.sender].registered==false,"User already registered!");
        _;
    }
    modifier isRegistered{
        require(userMap[msg.sender].registered,"User not registered!");
        _;
    }
    modifier isBetted{
        require(playerAddrMap[msg.sender].betted, "Player has not betted");
        _;
    }
    function registerUser() public unregistered{
                                                                        ////name length condtion maybe required?
        userMap[msg.sender]=User(msg.sender,userIdx, true);
        userList.push(userMap[msg.sender]);
        userIdx++;
    }

    function getUserList() public view returns(User[] memory){
        return userList;
    }

     function setTier(uint[] memory _tier) external onlyOwner {
        for (uint i=0; i<_tier.length; i++){
            tier.push(_tier[i]);
        }
    }
    function getTier() external view returns (uint[] memory){
        return tier;
    }
    function setBetToken(IERC20 _token) external onlyOwner {
        require(Address.isContract(address(_token)), "Invalid token");
        betToken = _token;
    }

    function betAndEnterGame(uint _betIdx) external nonReentrant isRegistered{
        require(playerAddrMap[msg.sender].betted ==false, "Already betted!");
        require(_betIdx<10&&_betIdx>=0, "Choose correct Bet index.");
        
        uint idx = playerList.length;
        Player memory newPlayer = Player(msg.sender,idx,true,_betIdx, 0,0,0,0,false);
        playerAddrMap[msg.sender] = newPlayer;
        playerList.push(newPlayer);
        // playerListIdxMap[idx] = msg.sender;
        
    }

    function onDecision(uint8 _o1, uint8 _o2, uint8 _o3) external isRegistered isBetted{
        playerAddrMap[msg.sender].option1 = _o1;
        playerAddrMap[msg.sender].option2 = _o2;
        playerAddrMap[msg.sender].option3 = _o3;
        playerAddrMap[msg.sender].score = calcScore(_o1,_o2,_o3);
        uint playerListIdx = playerAddrMap[msg.sender].playerListIndex;
        playerList[playerListIdx] = playerAddrMap[msg.sender];
        
    }

    function calcScore(uint8 _o1, uint8 _o2, uint8 _o3) private pure returns(uint){
        return _o1+_o2+_o3;
    }

    function getPlayers() external view returns (Player[] memory){
        return playerList;
    }

    function createLottery() external {
        for (uint i=0; i < playerList.length; i++){
            uint betIdx = playerList[i].betIndex;
            playersByBetMap[betIdx].push(playerList[i]);
        }
        for (uint betIdx=0; betIdx< 10; betIdx++){
            for (uint j=0; j<playersByBetMap[betIdx].length;j++){
                if (playersByBetMap[betIdx].length%2==0){
                    if(j % 2==0){
                        address  player1Addr = playersByBetMap[betIdx][j].addr;
                        address  player2Addr = playersByBetMap[betIdx][j+1].addr;
                        setLottery(player1Addr, player2Addr, betIdx, betIdx);
                    }
                }else{
                    if(j%2==0 && j!=playersByBetMap[betIdx].length-1){
                        address  player1Addr = playersByBetMap[betIdx][j].addr;
                        address  player2Addr = playersByBetMap[betIdx][j+1].addr;
                        setLottery(player1Addr, player2Addr, betIdx, betIdx);
                    }else if(j==playersByBetMap[betIdx].length-1){
                        uint lastIdx = playersByBetMap[betIdx].length-1;
                        address  lastAddr = playersByBetMap[betIdx][lastIdx].addr;
                        restPlayerAddrList.push(lastAddr);
                    }
                }
               
            }
        }
        for (uint i=0; i<restPlayerAddrList.length;i++){

            console.log(restPlayerAddrList[i]);
        }
        if (restPlayerAddrList.length>0){
            console.log(restPlayerAddrList.length);
            for (uint i =restPlayerAddrList.length-1;i>0 ;i--){
                if (i%2==0){
                    address player1Addr = restPlayerAddrList[i];
                    address player2Addr = restPlayerAddrList[i-1];
                    uint betIndex1 = playerAddrMap[player1Addr].betIndex;
                    uint betIndex2 = playerAddrMap[player2Addr].betIndex;
                    setLottery(player1Addr, player2Addr, betIndex1, betIndex2);
                }
            }
            if (restPlayerAddrList.length %2 ==1){
                address player0Addr = restPlayerAddrList[0];
                uint betIndex0 = playerAddrMap[player0Addr].betIndex;
                setLottery(player0Addr, player0Addr, betIndex0, betIndex0);
            }
        }
       
    }    

    function getAward(address _p1, address _p2) private pure returns(uint){
        return 100;
    }

    function getFee(address _p1, address _p2) private pure returns(uint){
        return 20;
    }

    function setLottery(address _p1, address _p2, uint _i1, uint _i2) private{
        playerPair[_p1] = playerPair[_p2];
        console.log(_p1,' :  ',_p2);
        Player memory player1 = playerAddrMap[_p1];
        Player memory player2 = playerAddrMap[_p2];
        uint score1 = player1.score;
        uint score2 = player2.score;
        uint8 win = score1>score2?1:(score1<score2?2:0);
        uint award = getAward(_p1, _p2);
        uint fee = getFee(_p1, _p2);
        Lottery memory newLottery = Lottery(lotteryListCount.current(), _i1, _i2, player1, player2,win, award, fee);
        lotteryList.push(newLottery);
        lotteryMap[_p1] = newLottery;
        lotteryMap[_p2] = newLottery;
        lotteryListCount.increment();
    }
    // function getPlayers1(uint index) external view returns (Player[] memory){
    //     return playersByBetMap[index];
    // }
    function getMyLottery(address me) external view returns(Lottery memory){
        return lotteryMap[me];
    }
}