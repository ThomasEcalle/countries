import 'dart:collection';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:first_test/question.dart';

import 'country.dart';

class Api {
  static Future<List<Question>> getAll() async {
    try {
      final Response response =
          await Dio().get("https://restcountries.eu/rest/v2/all?fields=name;capital;");

      final List<Country> c =
          (response.data as List).map((element) => Country.fromJson(element)).toList();

      final List<String> capitals =
          c.map((country) => country.capital).toList().where((cap) => cap.isNotEmpty).toList();

      c.shuffle();
      capitals.shuffle();

      final Queue<Country> countries = Queue();

      countries.addAll(c.where((country) => country.capital.isNotEmpty));

      List<Question> questions = [];
      for (int questionIndex = 0; questionIndex < 20; questionIndex++) {
        final Country country = countries.removeFirst();
        final List<String> generatedPossibilities = [];
        generatedPossibilities.add(country.capital);

        for (int i = 0; i < 3; i++) {
          final String capital = capitals[Random().nextInt(capitals.length - 1)];
          generatedPossibilities.add(capital);
        }

        generatedPossibilities.shuffle();

        questions.add(Question(
          countryName: country.name,
          response: country.capital,
          possibilities: generatedPossibilities,
        ));
      }

      return questions;
    } catch (e) {
      print("error $e");
      throw (e);
    }
  }
}
