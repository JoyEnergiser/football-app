import 'dart:io';

import 'package:bt_football/provider/matchProvider.dart';
import 'package:bt_football/widget/crestWidget.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUpAll(() {
    //this is to allow http connections when testing.Not strictly correct but will suffice for this demo
    HttpOverrides.global = null;
  });
  test("API Tests", () async {
    var match = await MatchProvider.getMatches();
    expect(match.competition.name, 'Premier League');
    var team = await MatchProvider.getTeam(64);
    expect(team.name, 'Liverpool FC');
  });

  testWidgets('crest image test', (WidgetTester tester) async {
    //standard pictures
    await tester.pumpWidget(CrestWidget(
      imageurl: 'https://cdn.pixabay.com/photo/2014/06/03/19/38/road-sign-361514_960_720.png',
    ));
    //svg
    await tester.pumpWidget(CrestWidget(
      imageurl: 'https://upload.wikimedia.org/wikipedia/commons/b/bd/Test.svg',
    ));
    // Test code goes here.
  });
}
