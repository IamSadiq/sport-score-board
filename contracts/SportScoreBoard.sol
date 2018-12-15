/*****************************************************************************
********************* ETHEREUM SOLIDTY SMART CONTRACT ************************
************************** SPORTS SCORE BOARD DAPP ****************************
*************************** BY: ABUBAKAR ADAMU *******************************
******************************************************************************/

pragma solidity ^0.4.24;
// pragma solidity >=0.4.24 <0.6.0;
// pragma experimental ABIEncoderV2;

contract SportScoreBoard {

    struct Match {
        bytes32 matchId;
        string teamA;
        string teamB;
        string createdAt;
    }

    bytes32[] matchIDs;
    // Match[] Matches;

    mapping (bytes32=>Match) whichMatch;
    mapping (bytes32=>bool) matchExists;
    mapping(bytes32=>string) Sport;
    mapping(bytes32=>string) Tournament;

    mapping(bytes32=>uint) teamA_score;
    mapping(bytes32=>uint) teamB_score;
    
    event CreatedNewMatch(string team_a, string team_b, uint ascore, uint bscore, string sport, string tournament, string createdAt, bytes32 id);
    event AddedMatchScore(string team_a, string team_b, uint a_score, uint b_score, bytes32 id);
    event AddedSportType(string team_a, string team_b, string sport, bytes32 id);
    event AddedMatchTournament(string team_a, string team_b, string tournament, bytes32 id);


    function createMatch(string _teamA, string _teamB, uint _ascore, uint _bscore, string _sport, string _tournament, string _createdAt) public {
        bytes32 _id = keccak256(abi.encodePacked(_createdAt));
        if(!matchExists[_id]){
            matchIDs.push(_id);
            whichMatch[_id] = Match({matchId: _id, teamA: _teamA, teamB: _teamB, createdAt: _createdAt});

            if(_ascore >= 0 && _bscore >= 0){
                teamA_score[_id] = _ascore;
                teamB_score[_id] = _bscore;
            }
            else{
                teamA_score[_id] = 0;
                teamB_score[_id] = 0;
            }

            Sport[_id] = _sport;
            Tournament[_id] = _tournament;

            matchExists[_id] = true;
            emit CreatedNewMatch(_teamA, _teamB, teamA_score[_id], teamB_score[_id], _sport, _tournament, _createdAt, _id);
        }
    }

    function getMatch(bytes32 _id) public view returns (string, string, uint, uint, string, string){
        if(matchExists[_id]) 
            return (whichMatch[_id].teamA, whichMatch[_id].teamB, teamA_score[_id], teamB_score[_id], Sport[_id], Tournament[_id]);
    }

    function getAllMatches() public view returns (bytes32[]){
        return matchIDs;
    }

    function setMatchScore(bytes32 _id, uint _aScore, uint _bScore) public {
        if(matchExists[_id] && (_aScore >= 0 && _bScore >= 0)){
            teamA_score[_id] = _aScore;
            teamB_score[_id] = _bScore;
            
            emit AddedMatchScore(whichMatch[_id].teamA, whichMatch[_id].teamB, _aScore, _bScore, _id);
        }
    }

    function getMatchScore(bytes32 _id) public view returns (uint, uint) {
        if(matchExists[_id]) return (teamA_score[_id], teamB_score[_id]);
    }    

    function setSportType(bytes32 _id, string _sport) public {
        if(matchExists[_id]) Sport[_id] = _sport;
        emit AddedSportType(whichMatch[_id].teamA, whichMatch[_id].teamB, _sport, _id);
    }
    
    function getSportType(bytes32 id) public view returns (string) {
        return Sport[id];
    }

    function setTournament(bytes32 _id, string _tournament) public {
        if(matchExists[_id]) Tournament[_id] = _tournament;
        emit AddedMatchTournament(whichMatch[_id].teamA, whichMatch[_id].teamB, _tournament, _id);
    }

    function getTournament(bytes32 _id) public view returns (string) {
        return Tournament[_id];
    }
}