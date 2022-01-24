import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import '../model/matchModel.dart';

class MatchProvider with ChangeNotifier {
  Future<TeamDetails> mostMatchesWon() async {
    late List<Winner> winList = [];
    List<int?> teamwins = [];

    //  get all matches for this competition in the listed time period
    MatchResult allMatches = await getMatches();
    //get only matches that have finished since we want to most wins over a period
    allMatches.matches.retainWhere((finishData) => finishData.status.contains('FINISHED'));

    // Put the list of finished matches in a seperate object because of how it lists away and home teams with the winner
    for (var i = 0; i < allMatches.matches.length; i++) {
      // print(i);
      Winner tempWin = (Winner(
        allMatches.matches[i].score?.winner,
        allMatches.matches[i].awayTeam?.id,
        allMatches.matches[i].homeTeam?.id,
      ));

      winList.add(tempWin);
    }
    //Get just the winning games into a list
    for (var i = 0; i < winList.length; i++) {
      if (winList[i].winner == 'AWAY_TEAM') {
        teamwins.add(winList[i].awayTeamID);
      }
      if (winList[i].winner == 'HOME_TEAM') {
        teamwins.add(winList[i].homeTeamID);
      }
    }
    //Get the teamid with the highest wins
    //todo if 2 teams have the same amount of wins it will pickup the team last on the list with the equal highest games won, no other factors at this stage.The spec only specified " display a football team which won most matches in last 30 days"

    Map<int, int> winsTeamscount = {};
    teamwins.forEach((i) => winsTeamscount[i ?? 1] = (winsTeamscount[i] ?? 0) + 1);
    var thevalue = 0;
    var thekey;

    winsTeamscount.forEach((k, v) {
      if (v > thevalue) {
        thevalue = v;
        thekey = k;
      }
    });

    var teamD = getTeam(thekey);

    return teamD;
  }

  //function is static to allow tests to execute this
  static Future<MatchResult> getMatches() async {
    Future<MatchResult> matchApiCall(String fromDate, String toDate) async {
      //2021 = premier league , 2019 = Italian
      var url = 'http://api.football-data.org/v2/competitions/2021/matches?dateFrom=' + fromDate + '&dateTo=' + toDate;
      var header = {'Content-type': 'application/json', 'X-Auth-Token': '85c1c0b70b8c4524a5e8bb4fdd37f810'};
      var response = await get(Uri.parse(url), headers: header);
      var resultObj = MatchResult.fromJson((json.decode(response.body)));
      return resultObj;
    }

    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    // throw SocketException('No Internet');
    //from date will be 1 month from current date
    final String formattedFromDate = formatter.format(DateTime(now.year, now.month - 1, now.day));
    //current date right now
    final String formattedCurrentDate = formatter.format(now);
    var resultObject = await matchApiCall(formattedFromDate, formattedCurrentDate);
    //Find the last day date of the season, this info seems to come with the this result as well
    DateTime endDate = DateTime.parse(resultObject.matches[0].season?.endDate ?? formattedCurrentDate);
    var diffDt = now.difference(endDate);

    //If competition is finished
    //If difference of end of season date and current date is positive,  it will use end of season date - 30 days, and this gets a new result set of matches for those dates
    if (diffDt.inDays > 0) {
      //from date will be 1 month less from the season end date
      final String formattedFromDate = formatter.format(DateTime(endDate.year, endDate.month - 1, endDate.day));
      // to date  will be the season end date
      final String formattedCurrentDate = formatter.format(endDate);
      resultObject = await matchApiCall(formattedFromDate, formattedCurrentDate);
    }
    return resultObject;
  }

  //function is static to allow tests to execute this
  static Future<TeamDetails> getTeam(int teamID) async {
    var url = 'http://api.football-data.org/v2/teams/' + teamID.toString();
    var header = {'Content-type': 'application/json', 'X-Auth-Token': '85c1c0b70b8c4524a5e8bb4fdd37f810'};
    var response = await get(Uri.parse(url), headers: header);
    var resultObject = Team.fromJson((json.decode(response.body)));
    //throw SocketException('No Internet')''
    TeamDetails teamD = TeamDetails(
      resultObject.name,
      resultObject.crestUrl,
      resultObject.website,
      resultObject.address,
    );
    return teamD;
  }
}
