import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:getflutter/colors/gf_color.dart';
import 'package:getflutter/components/card/gf_card.dart';
import 'package:getflutter/components/carousel/gf_items_carousel.dart';
import 'package:provider/provider.dart';

import '../data/country_api_service.dart';

class CountryPage extends StatelessWidget {
  final Map<String, dynamic> country;
  CountryPage({this.country});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Provider.of<CountryApiService>(context)
            .getCountry(country['country']),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError)
              return _buildError(snapshot.error.toString());

            final Map<String, dynamic> country =
                json.decode(snapshot.data.bodyString);
            return _buildBody(context, country);
          }
          return _buildLoader();
        },
      ),
    );
  }

  Widget _buildLoader() => Center(child: CircularProgressIndicator());

  Widget _buildError(String message) => Center(child: Text(message));

  _buildBody(BuildContext context, Map<String, dynamic> country) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: <Widget>[
        Image.asset('assets/images/line-background.jpg'),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                country['country'],
                style: TextStyle(fontSize: 40),
              ),
            ),
            Center(
              child: Image.asset(
                'assets/images/medical-research.png',
                fit: BoxFit.fitWidth,
              ),
            ),
            GFItemsCarousel(
              itemHeight: screenHeight / 6,
              rowCount: 3,
              children: <Widget>[
                CoronaCase(
                  title: 'Cases',
                  data: country['cases'],
                ),
                CoronaCase(
                  title: 'Recovered',
                  data: country['recovered'],
                ),
                CoronaCase(
                  title: 'Deaths',
                  data: country['deaths'],
                ),
                CoronaCase(
                  title: 'Critical',
                  data: country['critical'],
                ),
                CoronaCase(
                  title: 'Active',
                  data: country['active'],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class CoronaCase extends StatelessWidget {
  final String title;
  final int data;
  CoronaCase({this.title, this.data});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return GFCard(
      margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
      borderRadius: const BorderRadius.all(Radius.circular(4)),
      gradient: LinearGradient(
        begin: FractionalOffset.topLeft,
        end: FractionalOffset.bottomRight,
        colors: [
          const Color(0xFF0175C2),
          const Color(0xFF0a0e21),
        ],
      ),
      content: Center(
        heightFactor: screenHeight / 400,
        child: Column(
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                color: GFColors.WHITE,
              ),
            ),
            Text(
              '${data.toString()} people',
              style: TextStyle(
                fontSize: 10,
                color: GFColors.LIGHT,
              ),
            ),
            Icon(
              Icons.show_chart,
              color: GFColors.LIGHT,
            ),
          ],
        ),
      ),
    );
  }
}
