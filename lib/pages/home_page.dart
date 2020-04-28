import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:number_display/number_display.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';

import '../data/all_api_service.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('COVID-19'),
      ),
      body: FutureBuilder<Response>(
        future: Provider.of<AllApiService>(context).getAll(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final data = json.decode(snapshot.data.bodyString);
            return _buildBody(context, data);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, Map<String, dynamic> data) {
    Map<String, double> dataMap = Map();
    // dataMap.putIfAbsent("Total Cases", () => data['cases'].toDouble());
    dataMap.putIfAbsent("Total Deaths", () => data['deaths'].toDouble());
    dataMap.putIfAbsent("Active Cases", () => data['active'].toDouble());
    // dataMap.putIfAbsent("Critical", () => data['critical'].toDouble());
    dataMap.putIfAbsent("Total Recovered", () => data['recovered'].toDouble());

    List<Color> colorList = [
      Color(0xFFf1c40f), // Yellow
      Color(0xFF2ecc71), // Green
      Color(0xFFF51C4E), // Pink
      // Color(0xFFe74c3c), // Red
      // Color(0xFF3498db), // Blue
      // Color(0xFFe67e22), // Orange
    ];

    final numberDisplay = createDisplay(length: 12, decimal: 3, separator: '.');
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Column(
            children: <Widget>[
              Center(
                child: Text(
                  'Coronavirus Cases',
                  style: TextStyle(fontSize: 24),
                ),
              ),
              Center(
                child: Text(
                  'Currently Infected Patients',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.red,
                  ),
                ),
              ),
              SizedBox(height: 50),
              Row(
                children: <Widget>[
                  Spacer(),
                  Container(
                    padding: EdgeInsets.only(right: 40),
                    child: Text(
                      'Total Cases: ${numberDisplay(data['cases'])}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              Center(
                child: PieChart(
                  dataMap: dataMap,
                  chartType: ChartType.ring,
                  showChartValuesOutside: true,
                  colorList: colorList,
                  legendPosition: LegendPosition.right,
                  legendStyle: TextStyle(fontWeight: FontWeight.normal),
                  chartValueStyle: defaultChartValueStyle.copyWith(
                    color: Colors.white70,
                  ),
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          child: Container(
            color: Theme.of(context).accentColor,
            margin: EdgeInsets.only(top: 10),
            width: double.infinity,
            height: 50,
            child: Center(
              child: Text(
                'View By Countries',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
          },
        ),
      ],
    );
  }
}
