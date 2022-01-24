import 'package:bt_football/model/matchModel.dart';
import 'package:bt_football/widget/crestWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'provider/matchProvider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => MatchProvider()),
        ],
        child: MaterialApp(
          title: 'Football app',
          theme: ThemeData(
            primarySwatch: Colors.blueGrey,
          ),
          home: const MyHomePage(title: 'PL most wins in 30 days'),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<TeamDetails> matchProvider;

  @override
  void initState() {
    matchProvider = Provider.of<MatchProvider>(context, listen: false).mostMatchesWon();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            FutureBuilder(
              future: matchProvider,
              initialData: 'None',
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) {
                  // final error = snapshot.error;
                  return const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Text('Data could not be retrieved', style: TextStyle(color: Colors.redAccent)));
                } else {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15), child: Center(child: CircularProgressIndicator()));
                    default:
                      return InkWell(
                          onTap: () {
                            launch(snapshot.data.website).then((value) => null).catchError((error) {
                              // print(error.toString());
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('website could not be opened.')));
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20, right: 10),
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(vertical: 0),
                              leading: CrestWidget(imageurl: snapshot.data.crestUrl),
                              title: Text(
                                snapshot.data.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              subtitle: RichText(
                                text: TextSpan(
                                  style: Theme.of(context).textTheme.caption,
                                  children: <TextSpan>[
                                    TextSpan(text: snapshot.data.address),
                                  ],
                                ),
                              ),
                            ),
                          ));
                  }
                }
              },
            ),
            Center(
              child: IconButton(
                icon: Icon(Icons.refresh_outlined, color: Theme.of(context).hintColor),
                onPressed: () {
                  setState(() {
                    matchProvider = Provider.of<MatchProvider>(context, listen: false).mostMatchesWon();
                  });
                },
              ),
            )
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
