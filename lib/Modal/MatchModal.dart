class MatchModal {
  final String matchId,
      status,
      league,
      home_name,
      home_flag,
      time,
      away_name,
      away_flag;

  MatchModal(
      {required this.matchId,
      required this.status,
      required this.league,
      required this.home_name,
      required this.home_flag,
      required this.time,
      required this.away_name,
      required this.away_flag});

  factory MatchModal.from(dynamic data) {
    return MatchModal(
        matchId: data['matchId'],
        status: data['status'],
        league: data['league'],
        home_name: data['home_name'],
        home_flag: data['home_flag'],
        time: data['time'],
        away_name: data['away_name'],
        away_flag: data['away_flag']);
  }
}

// matchId:"1"
// status:"Live"
// league:"England Premier League"
// home_name:" Manchester City"
// home_flag:"https://1.livesoccer.sx/teams/manchester-city.png"
// time:"07:00 PM"
// away_name:"Liverpool "
// away_flag:"https://1.livesoccer.sx/teams/liverpool.png"