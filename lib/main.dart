// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(CurrencyConverter());

class CurrencyConverter extends StatefulWidget {
  const CurrencyConverter({super.key});

  @override
  _CurrencyConverterState createState() => _CurrencyConverterState();
}

class _CurrencyConverterState extends State<CurrencyConverter> {
  double result = 0;
  final TextEditingController textEditingController = TextEditingController();

  void convert() async {
    try {
      final input = double.tryParse(textEditingController.text);
      if (input == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please enter a valid number")),
        );
        return;
      }

      final response = await http.get(
        Uri.parse("https://api.exchangerate-api.com/v4/latest/USD"),
      );

      if (response.statusCode != 200) {
        throw Exception("Failed to fetch exchange rate");
      }

      final data = jsonDecode(response.body);
      final rate = data["rates"]["INR"];

      setState(() {
        result = rate * input;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(title: Text("Currency Converter")),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: textEditingController,
                decoration: InputDecoration(
                  labelText: "Enter amount in USD",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: convert,
                child: Text("Convert to INR"),
              ),
              SizedBox(height: 20),
              Text(
                "₹ ${result.toStringAsFixed(2)}",
                style: TextStyle(fontSize: 30),
              )
            ],
          ),
        ),
      ),
    );
  }
}
