import 'package:flutter/material.dart';
import 'package:weather_jan/constants/size_colors.dart';
import '../../constants/list_city.dart';

class CityScreen extends StatefulWidget {
  const CityScreen({super.key});

  @override
  State<CityScreen> createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  late String cityName;
  late String cityString;

  // Этот список содержит данные для представления списка
  List<Map<String, dynamic>> _foundCity = [];
  @override
  void initState() {
    // вначале показаны все города
    _foundCity = allCity;
    super.initState();
  }

  // Эта функция вызывается всякий раз, когда изменяется текстовое поле
  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      // если поле поиска пусто или содержит только пробелы, мы отобразим всех пользователей
      results = allCity;
    } else {
      results = allCity
          .where((city) =>
              //contains - содержит ли city["name] - enteredKeyword
              city["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // мы используем метод toLowerCase(), чтобы сделать его нечувствительным к регистру
    }

    // Обновить пользовательский интерфейс
    setState(() {
      _foundCity = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Поиск города'),
        backgroundColor: colorLightBlue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            // Текстовое поле
            TextField(
              // Обратный вызов всякий раз, когда текст изменяется
              onChanged: (value) => _runFilter(value),
              // onChanged: (value) => cityString = value,
              onSubmitted: (value) {
                cityName = value;
                Navigator.pop(context, cityName);
              },
              decoration: const InputDecoration(
                labelText: 'Поиск',
                suffixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              // Проверяем - является ли строка пустой
              child: _foundCity.isNotEmpty
                  ? ListView.builder(
                      itemCount: _foundCity.length,
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          cityName = _foundCity[index]["name"].toString();
                          // print(cityName);
                          Navigator.pop(context, cityName);
                        },
                        child: Card(
                          key: ValueKey(_foundCity[index]["id"]),
                          color: colorLightBlue,
                          elevation: 4,
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: ListTile(
                            title: Text(
                              _foundCity[index]['name'],
                              style:
                                  TextStyle(color: colorText, fontSize: sizeM),
                            ),
                          ),
                        ),
                      ),
                    )
                  : Text(
                      "База данных не содержит запрашиваемого города. Но вы можете ввести полное название города и нажать Enter ;)",
                      style: TextStyle(fontSize: sizeM),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
