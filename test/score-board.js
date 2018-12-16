var msInstance;

SportScoreBoard.deployed().then((inst)=>{ msInstance = inst; console.log(inst); });

var createdAt = Date.now();
var matchID;

msInstance.createMatch(web3.fromAscii("Benfica"), web3.fromAscii("Chelsea"), web3.fromAscii(createdAt));
msInstance.createMatch("Arsenal", "R.Madrid", 3, 0, "Football", "Champions League", createdAt).then((res) => { console.log(res);});

msInstance.getMatch(web3.fromAscii(matchID)).then(function(res){ console.log(res[0].toLocaleString() + " vs " + res[1].toLocaleString());});
msInstance.getMatch(matchID).then(function(res){ console.log(res);});

msInstance.getAllMatches().then(function(res){ matchID=res[0]; console.log(res);});

// match scores
msInstance.setMatchScore(web3.fromAscii(matchID), 3, 0);
msInstance.setMatchScore(matchID, 1, 0);

msInstance.getMatchScore(web3.fromAscii(matchID)).then(function(res){ console.log(res[0].toLocaleString() + " vs " + res[1].toLocaleString());});
msInstance.getMatchScore(matchID).then(function(res){ console.log(res[0] + " vs " + res[1]);});


// sport type
msInstance.setSportType(matchID, "Football");

msInstance.getSportType(matchID).then(function(res){ console.log(res);});


// tournament name
msInstance.setTournament(matchID, "Champions League");

msInstance.getTournament(matchID).then(function(res){ console.log(res);});