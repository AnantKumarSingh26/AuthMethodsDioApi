import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class CountriesPage extends StatefulWidget {
  const CountriesPage({super.key});

  @override
  State<CountriesPage> createState() => _CountriesPageState();
}

class _CountriesPageState extends State<CountriesPage> {
  List countries = [];
  bool loading = true;
  @override
  void initState() {
    super.initState();
    fetchCountries();
  }

  Future<void> fetchCountries() async {
    try {
      var dio = Dio();
      var response = await dio.get(
        "https://countriesnow.space/api/v0.1/countries/population",
      );

      setState(() {
        countries = response.data["data"];
        loading=false;
      });
    } catch (e) {
      print("Error: $e");
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Countries')),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: countries.length,
              itemBuilder: (context, index) {
                var country = countries[index];
                return ListTile(
                  title: Text(country["country"]),
                  subtitle: Text(
                    "Code: ${country["code"] ?? "-"} | ISO3: ${country["iso3"] ?? "-"}",
                  ),
                );
              },
            ),
    );
  }
}
