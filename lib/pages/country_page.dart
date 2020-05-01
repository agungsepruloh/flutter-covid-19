import 'dart:convert';

import 'package:flutter/material.dart';
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
            final Map<String, dynamic> country =
                json.decode(snapshot.data.bodyString);
            return _buildBody(context, country);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  _buildBody(BuildContext context, Map<String, dynamic> country) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          country['country'],
          style: TextStyle(fontSize: 30),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8, left: 20, top: 20),
          child: Row(
            children: <Widget>[
              Image.asset(
                'assets/images/doctor-woman-400px.png',
                height: MediaQuery.of(context).size.height / 2,
                scale: 0.1,
              ),
              Spacer(),
              Expanded(
                child: Column(
                  children: <Widget>[
                    CoronaCase(
                      state: 'Cases',
                      total: country['cases'],
                    ),
                    CoronaCase(
                      state: 'Recovered',
                      total: country['recovered'],
                    ),
                    CoronaCase(
                      state: 'Deaths',
                      total: country['deaths'],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class CoronaCase extends StatelessWidget {
  final String state;
  final int total;
  CoronaCase({this.state, this.total});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(
            state,
            style: TextStyle(fontSize: 18),
          ),
          Text(
            '$total',
            style: TextStyle(color: Colors.white70),
          ),
          Divider(color: Colors.white),
        ],
      ),
    );
  }
}
