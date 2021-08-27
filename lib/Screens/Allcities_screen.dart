import 'package:cities_app/Screens/city_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Allcities extends StatefulWidget {
  @override
  _AllcitiesState createState() => _AllcitiesState();
}

class _AllcitiesState extends State<Allcities> {
  List cities = [];
  List filteredCities = [];
  bool isSearching = false;

  getCity() async {
    var response = await Dio().get('https://restcountries.eu/rest/v2/all');
    return response.data;
  }

  @override
  void initState() {
    getCity().then((data) {
      setState(() {
        cities = filteredCities = data;
      });
    });
    super.initState();
  }

  void _filterCountries(value) {
    setState(() {
      filteredCities = cities
          .where((country) =>
              country['name'].toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: !isSearching
            ? Text('All Countries')
            : TextField(
                onChanged: (value) {
                  _filterCountries(value);
                },
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    hintText: "Search Country Here",
                    hintStyle: TextStyle(color: Colors.white)),
              ),
        actions: <Widget>[
          isSearching
              ? IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: () {
                    setState(() {
                      this.isSearching = false;
                      filteredCities = cities;
                    });
                  },
                )
              : IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      this.isSearching = true;
                    });
                  },
                )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: filteredCities.length > 0
            ? ListView.builder(
                itemCount: filteredCities.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(City.routeName,
                          arguments: filteredCities[index]);
                    },
                    child: Card(
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 8),
                        child: Text(
                          filteredCities[index]['name'],
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  );
                })
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
