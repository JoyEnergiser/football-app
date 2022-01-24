class MatchResult {
  int? count;
  late Competition competition;
  late List<Matches> matches;

  MatchResult({this.count, required this.competition, required this.matches});

  MatchResult.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    competition = Competition.fromJson(json['competition']);
    if (json['matches'] != null) {
      matches = <Matches>[];
      json['matches'].forEach((v) {
        matches.add(Matches.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['count'] = count;
    data['competition'] = competition.toJson();
    data['matches'] = matches.map((v) => v.toJson()).toList();
    return data;
  }
}

class Winner {
  String? winner;
  int? awayTeamID;
  int? homeTeamID;
  Winner(this.winner, this.awayTeamID, this.homeTeamID);
}

class TeamDetails {
  String? name;
  String? crestUrl;
  String? website;
  String? address;
  TeamDetails(this.name, this.crestUrl, this.website, this.address);
}

class Competition {
  int? id;
  Area? area;
  String? name;
  String? code;
  String? plan;
  String? lastUpdated;

  Competition({this.id, this.area, this.name, this.code, this.plan, this.lastUpdated});

  Competition.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    area = json['area'] != null ? Area.fromJson(json['area']) : null;
    name = json['name'];
    code = json['code'];
    plan = json['plan'];
    lastUpdated = json['lastUpdated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    if (area != null) {
      data['area'] = area!.toJson();
    }
    data['name'] = name;
    data['code'] = code;
    data['plan'] = plan;
    data['lastUpdated'] = lastUpdated;
    return data;
  }
}

class Area {
  int? id;
  String? name;

  Area({this.id, this.name});

  Area.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class Matches {
  int? id;
  Season? season;
  String? utcDate;
  late String status;
  int? matchday;
  String? stage;
  Null? group;
  String? lastUpdated;
  Odds? odds;
  Score? score;
  Area? homeTeam;
  Area? awayTeam;
  List<Referees>? referees;

  Matches(
      {this.id,
      this.season,
      this.utcDate,
      required this.status,
      this.matchday,
      this.stage,
      this.group,
      this.lastUpdated,
      this.odds,
      this.score,
      this.homeTeam,
      this.awayTeam,
      this.referees});

  Matches.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    season = json['season'] != null ? Season.fromJson(json['season']) : null;
    utcDate = json['utcDate'];
    status = json['status'];
    matchday = json['matchday'];
    stage = json['stage'];
    group = json['group'];
    lastUpdated = json['lastUpdated'];
    odds = json['odds'] != null ? Odds.fromJson(json['odds']) : null;
    score = json['score'] != null ? Score.fromJson(json['score']) : null;
    homeTeam = json['homeTeam'] != null ? Area.fromJson(json['homeTeam']) : null;
    awayTeam = json['awayTeam'] != null ? Area.fromJson(json['awayTeam']) : null;
    if (json['referees'] != null) {
      referees = <Referees>[];
      json['referees'].forEach((v) {
        referees!.add(Referees.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    if (season != null) {
      data['season'] = season!.toJson();
    }
    data['utcDate'] = utcDate;
    data['status'] = status;
    data['matchday'] = matchday;
    data['stage'] = stage;
    data['group'] = group;
    data['lastUpdated'] = lastUpdated;
    if (odds != null) {
      data['odds'] = odds!.toJson();
    }
    if (score != null) {
      data['score'] = score!.toJson();
    }
    if (homeTeam != null) {
      data['homeTeam'] = homeTeam!.toJson();
    }
    if (awayTeam != null) {
      data['awayTeam'] = awayTeam!.toJson();
    }
    if (referees != null) {
      data['referees'] = referees!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Season {
  int? id;
  String? startDate;
  String? endDate;
  int? currentMatchday;

  Season({id, startDate, endDate, currentMatchday});

  Season.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    currentMatchday = json['currentMatchday'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['currentMatchday'] = currentMatchday;
    return data;
  }
}

class Odds {
  String? msg;

  Odds({this.msg});

  Odds.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['msg'] = msg;
    return data;
  }
}

class Score {
  String? winner;
  String? duration;
  FullTime? fullTime;
  FullTime? halfTime;
  ExtraTime? extraTime;
  ExtraTime? penalties;

  Score({this.winner, this.duration, this.fullTime, this.halfTime, this.extraTime, this.penalties});

  Score.fromJson(Map<String, dynamic> json) {
    winner = json['winner'];
    duration = json['duration'];
    fullTime = json['fullTime'] != null ? FullTime.fromJson(json['fullTime']) : null;
    halfTime = json['halfTime'] != null ? FullTime.fromJson(json['halfTime']) : null;
    extraTime = json['extraTime'] != null ? ExtraTime.fromJson(json['extraTime']) : null;
    penalties = json['penalties'] != null ? ExtraTime.fromJson(json['penalties']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['winner'] = winner;
    data['duration'] = duration;
    if (fullTime != null) {
      data['fullTime'] = fullTime!.toJson();
    }
    if (halfTime != null) {
      data['halfTime'] = halfTime!.toJson();
    }
    if (extraTime != null) {
      data['extraTime'] = extraTime!.toJson();
    }
    if (penalties != null) {
      data['penalties'] = penalties!.toJson();
    }
    return data;
  }
}

class FullTime {
  int? homeTeam;
  int? awayTeam;

  FullTime({this.homeTeam, this.awayTeam});

  FullTime.fromJson(Map<String, dynamic> json) {
    homeTeam = json['homeTeam'];
    awayTeam = json['awayTeam'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['homeTeam'] = homeTeam;
    data['awayTeam'] = awayTeam;
    return data;
  }
}

class ExtraTime {
  Null? homeTeam;
  Null? awayTeam;

  ExtraTime({this.homeTeam, this.awayTeam});

  ExtraTime.fromJson(Map<String, dynamic> json) {
    homeTeam = json['homeTeam'];
    awayTeam = json['awayTeam'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['homeTeam'] = homeTeam;
    data['awayTeam'] = awayTeam;
    return data;
  }
}

class Referees {
  int? id;
  String? name;
  String? role;
  String? nationality;

  Referees({this.id, this.name, this.role, this.nationality});

  Referees.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    role = json['role'];
    nationality = json['nationality'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['role'] = role;
    data['nationality'] = nationality;
    return data;
  }
}

class Team {
  int? id;
  Area? area;
  String? name;
  String? shortName;
  String? tla;
  String? crestUrl;
  String? address;
  String? phone;
  String? website;
  String? email;
  int? founded;
  String? clubColors;
  String? venue;
  List<Squad>? squad;
  String? lastUpdated;

  Team(
      {this.id,
      this.area,
      this.name,
      this.shortName,
      this.tla,
      this.crestUrl,
      this.address,
      this.phone,
      this.website,
      this.email,
      this.founded,
      this.clubColors,
      this.venue,
      this.squad,
      this.lastUpdated});

  Team.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    area = json['area'] != null ? Area.fromJson(json['area']) : null;
    name = json['name'];
    shortName = json['shortName'];
    tla = json['tla'];
    crestUrl = json['crestUrl'];
    address = json['address'];
    phone = json['phone'];
    website = json['website'];
    email = json['email'];
    founded = json['founded'];
    clubColors = json['clubColors'];
    venue = json['venue'];
    if (json['squad'] != null) {
      squad = <Squad>[];
      json['squad'].forEach((v) {
        squad!.add(Squad.fromJson(v));
      });
    }
    lastUpdated = json['lastUpdated'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    if (area != null) {
      data['area'] = area!.toJson();
    }
    data['name'] = name;
    data['shortName'] = shortName;
    data['tla'] = tla;
    data['crestUrl'] = crestUrl;
    data['address'] = address;
    data['phone'] = phone;
    data['website'] = website;
    data['email'] = email;
    data['founded'] = founded;
    data['clubColors'] = clubColors;
    data['venue'] = venue;
    if (squad != null) {
      data['squad'] = squad!.map((v) => v.toJson()).toList();
    }
    data['lastUpdated'] = lastUpdated;
    return data;
  }
}

class Squad {
  int? id;
  String? name;
  String? position;
  String? dateOfBirth;
  String? countryOfBirth;
  String? nationality;
  String? role;

  Squad({this.id, this.name, this.position, this.dateOfBirth, this.countryOfBirth, this.nationality, this.role});

  Squad.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    position = json['position'];
    dateOfBirth = json['dateOfBirth'];
    countryOfBirth = json['countryOfBirth'];
    nationality = json['nationality'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['position'] = position;
    data['dateOfBirth'] = dateOfBirth;
    data['countryOfBirth'] = countryOfBirth;
    data['nationality'] = nationality;
    data['role'] = role;
    return data;
  }
}
