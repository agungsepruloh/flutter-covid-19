import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import 'package:provider/provider.dart';

import '../data/country_api_service.dart';

class CountriesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Response>(
        future: Provider.of<CountryApiService>(context).getCountries(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError)
              return _buildError(snapshot.error.toString());
            final List countries = json.decode(snapshot.data.bodyString);
            return _buildListCountry(context, countries);
          }
          return _buildLoader();
        },
      ),
    );
  }

  Widget _buildLoader() => Center(child: CircularProgressIndicator());

  Widget _buildError(String message) => Center(child: Text(message));

  Widget _buildListCountry(BuildContext context, List countries) {
    countries = countries.reversed.toList();
    return ListView.builder(
      itemCount: countries.length,
      itemBuilder: (context, index) {
        return _buildFlag(context, countries[index]);
      },
    );
  }

  Widget _buildFlag(BuildContext context, Map<String, dynamic> country) {
    // String countryName = country['country'].length > 16
    //     ? country['country'].substring(0, 15) + '...'
    //     : country['country'];
    // CountryApiService countryApiService =
    //     Provider.of<CountryApiService>(context);

    return GFListTile(
      title: Text(country['country']),
      color: Color(0xFF0a0e21),
      margin: EdgeInsets.all(2),
      padding: EdgeInsets.all(6),
      subTitle: Text(
        '${country['cases']} cases',
        style: TextStyle(color: Colors.white70),
      ),
      avatar: GFAvatar(
        backgroundImage: NetworkImage('${country['countryInfo']['flag']}'),
        shape: GFAvatarShape.standard,
      ),
    );
  }
}
