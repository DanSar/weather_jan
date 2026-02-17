import 'package:flutter/material.dart';
import 'package:weather_jan/constants/size_colors.dart';
import 'package:weather_jan/screens/location_screen.dart';
import '../../models/modelsAir/models_air.dart';

class ScreenIndexAir extends StatefulWidget {
  final AirPollution? locationAir;
  const ScreenIndexAir({super.key, this.locationAir});

  @override
  State<ScreenIndexAir> createState() => _ScreenIndexAirState();
}

class _ScreenIndexAirState extends State<ScreenIndexAir> {
  late Future<AirPollution?> airObject;

  // Константы для стилей и отступов
  static const _spacingMedium = 40.0;
  static const _spacingSmall = 12.0;
  static const _textStyleDefault = TextStyle(color: Colors.black);
  static const _textStyleSecondary = TextStyle(color: Colors.black54);

  // Структура данных для газов
  static const _gasesGroup1 = [
    _GasInfo(label: 'CO', key: 'co'),
    _GasInfo(label: 'NO', key: 'no'),
    _GasInfo(label: 'NO2', key: 'no2'),
    _GasInfo(label: 'O3', key: 'o3'),
  ];

  static const _gasesGroup2 = [
    _GasInfo(label: 'SO2', key: 'so2'),
    _GasInfo(label: 'PM25', key: 'pm2_5'),
    _GasInfo(label: 'PM10', key: 'pm10'),
    _GasInfo(label: 'NH3', key: 'nh3'),
  ];

  // Данные для определения качества воздуха
  static final _airQualityData = [
    _AirQuality(aqi: 5, color: Colors.red, name: 'Очень плохое'),
    _AirQuality(aqi: 4, color: Colors.orange, name: 'Плохое'),
    _AirQuality(aqi: 3, color: Colors.orange.shade200, name: 'Умеренное'),
    _AirQuality(aqi: 2, color: Colors.green.shade200, name: 'Хорошее'),
    _AirQuality(aqi: 1, color: Colors.green, name: 'Отличное'),
  ];

  @override
  void initState() {
    super.initState();
    airObject = Future.value(widget.locationAir);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: _buildAppBar(),
        body: FutureBuilder<AirPollution?>(
          future: airObject,
          builder: _buildFutureBuilder,
        ),
      ),
    );
  }

  // Выделенный метод для AppBar
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: colorText,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LocationScreen(),
            ),
          );
        },
      ),
    );
  }

  // Основной строитель FutureBuilder
  Widget _buildFutureBuilder(
    BuildContext context,
    AsyncSnapshot<AirPollution?> snapshot,
  ) {
    if (snapshot.hasError) {
      return _buildErrorState();
    }

    if (!snapshot.hasData) {
      return const Center(child: CircularProgressIndicator());
    }

    return _buildContent(snapshot.data);
  }

  // Состояние ошибки
  Widget _buildErrorState() {
    return Center(
      child: Text(
        'Ошибка загрузки данных',
        style: TextStyle(color: Colors.red, fontSize: sizeM),
      ),
    );
  }

  // Основное содержимое
  Widget _buildContent(AirPollution? pollutionData) {
    final aqi = pollutionData?.list?.firstOrNull?.main?.aqi;
    final components = pollutionData?.list?.firstOrNull?.components;
    final sizeAir = MediaQuery.of(context).size.height / 8.5;

    // Получаем информацию о качестве воздуха
    final qualityInfo = _getAirQualityInfo(aqi);

    return Padding(
      padding: const EdgeInsets.all(_spacingSmall),
      child: Column(
        children: [
          _buildHeader(),
          const SizedBox(height: _spacingMedium),
          _buildAqiDisplay(aqi, qualityInfo, sizeAir),
          const SizedBox(height: _spacingMedium),
          _buildGasesGrid(components),
          const SizedBox(height: _spacingMedium),
          const Divider(color: Colors.black),
          _buildInfoButton(),
          const Text(
            'Open Weather',
            style: _textStyleSecondary,
          ),
        ],
      ),
    );
  }

  // Заголовок
  Widget _buildHeader() {
    return Text(
      "Индекс качества воздуха (по шкале 1-5)",
      style: TextStyle(fontSize: sizeL),
    );
  }

  // Отображение AQI
  Widget _buildAqiDisplay(int? aqi, _AirQuality quality, double sizeAir) {
    return Padding(
      padding: const EdgeInsets.all(_spacingSmall),
      child: Row(
        children: [
          Text(
            aqi?.toString() ?? '-',
            style: TextStyle(fontSize: sizeAir, color: quality.color),
          ),
          const SizedBox(width: _spacingSmall),
          _buildQualityLabel(quality.name, quality.color, sizeAir),
        ],
      ),
    );
  }

  // Лейбл качества воздуха
  Widget _buildQualityLabel(String name, Color color, double containerHeight) {
    return SizedBox(
      height: containerHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            name,
            style: TextStyle(color: color, fontSize: sizeM),
          ),
          const SizedBox(height: _spacingSmall),
        ],
      ),
    );
  }

  // Сетка газов
  Widget _buildGasesGrid(Components? components) {
    return Column(
      children: [
        _buildGasRow(_gasesGroup1, components),
        const SizedBox(height: _spacingMedium),
        _buildGasRow(_gasesGroup2, components),
      ],
    );
  }

  // Строка с газами
  Widget _buildGasRow(List<_GasInfo> gases, Components? components) {
    return Row(
      children: gases
          .map((gas) => _buildGasItem(
                _getGasValue(components, gas.key),
                gas.label,
              ))
          .toList(),
    );
  }

  // Элемент с газом
  Widget _buildGasItem(String value, String label) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(fontSize: sizeM),
          ),
          Text(label),
        ],
      ),
    );
  }

  // Кнопка информации
  Widget _buildInfoButton() {
    return TextButton(
      onPressed: _showInfoDialog,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Подробнее о качестве воздуха',
            style: _textStyleDefault,
          ),
          Icon(Icons.arrow_right_sharp, color: Colors.black),
        ],
      ),
    );
  }

  // Диалог с информацией
  void _showInfoDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: const Text(
          'Индекс качества воздуха (по шкале 1-5), '
          'где 1 - отличное качество воздуха, а 5 - ужасное.\n\n'
          'Помимо базового индекса, API возвращает данные о газах:\n'
          '• CO - монооксид углерода\n'
          '• NO - монооксид азота\n'
          '• NO2 - диоксид азота\n'
          '• O3 - озон\n'
          '• SO2 - диоксид серы\n'
          '• NH3 - аммиак\n'
          '• PM2.5 и PM10 - твердые частицы',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  // Вспомогательные методы
  _AirQuality _getAirQualityInfo(int? aqi) {
    return _airQualityData.firstWhere(
      (quality) => quality.aqi == aqi,
      orElse: () => const _AirQuality(
        aqi: 0,
        color: Colors.grey,
        name: 'Нет данных',
      ),
    );
  }

  String _getGasValue(Components? components, String key) {
    if (components == null) return '-';

    switch (key) {
      case 'co':
        return components.co?.toString() ?? '-';
      case 'no':
        return components.no?.toString() ?? '-';
      case 'no2':
        return components.no2?.toString() ?? '-';
      case 'o3':
        return components.o3?.toString() ?? '-';
      case 'so2':
        return components.so2?.toString() ?? '-';
      case 'pm2_5':
        return components.pm2_5?.toString() ?? '-';
      case 'pm10':
        return components.pm10?.toString() ?? '-';
      case 'nh3':
        return components.nh3?.toString() ?? '-';
      default:
        return '-';
    }
  }
}

// Вспомогательные классы
class _AirQuality {
  final int aqi;
  final Color color;
  final String name;

  const _AirQuality({
    required this.aqi,
    required this.color,
    required this.name,
  });
}

class _GasInfo {
  final String label;
  final String key;

  const _GasInfo({required this.label, required this.key});
}
