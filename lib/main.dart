import 'package:first_test/question.dart';
import 'package:first_test/quiz.dart';
import 'package:flutter/material.dart';

import 'api.dart';
import 'country.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: TextTheme(
          title: TextStyle(
            color: Colors.white,
            fontSize: 35,
            fontWeight: FontWeight.bold,
          ),
          display1: TextStyle(
            fontSize: 20,
            color: Colors.black54,
            fontWeight: FontWeight.bold,
          ),
          display2: TextStyle(
            fontSize: 16,
            color: Colors.black54,
          ),
        ),
      ),
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          FutureBuilder(
            future: Api.getAll(),
            builder: (BuildContext context, AsyncSnapshot<List<Question>> snapshot) {
              if (snapshot.hasData) {
                final List<Question> questions = snapshot.data;
                return Expanded(
                  child: Quiz(questions: questions),
                );
              } else {
                return Container(
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class CountryItem extends StatefulWidget {
  final Country country;

  const CountryItem({
    Key key,
    this.country,
  }) : super(key: key);

  @override
  _CountryItemState createState() => _CountryItemState();
}

class _CountryItemState extends State<CountryItem> {
  bool hover = false;

  Country get country => widget.country;

  onHover(bool hover) {
    setState(() {
      this.hover = hover;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Center(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: hover ? 5 : 2,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            height: 180,
            width: 180,
            child: Material(
              type: MaterialType.transparency,
              child: InkWell(
                borderRadius: BorderRadius.circular(15),
                onHover: onHover,
                hoverColor: Colors.transparent,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => Page2(
                        country: country,
                      ),
                    ),
                  );
                },
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "title ${country.name}",
                        style: Theme.of(context).textTheme.display1,
                      ),
                      Text(
                        "capitale ${country.capital}",
                        style: Theme.of(context).textTheme.display1,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Page2 extends StatelessWidget {
  final Country country;

  const Page2({
    Key key,
    this.country,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightBlue,
      child: Center(
        child: Column(
          children: <Widget>[
            Text("name = ${country.name}"),
            Text("capital = ${country.capital}"),
          ],
        ),
      ),
    );
  }
}
