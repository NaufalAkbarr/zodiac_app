import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'data_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zodiac Horoscope',
      theme: ThemeData(
        fontFamily: 'Montserrat',
        primarySwatch: Colors.deepPurple,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Zodiac? zodiac;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchZodiacData();
  }

  Future<void> fetchZodiacData() async {
    final url =
        'https://script.google.com/macros/s/AKfycbywRYYUjvLXuKA0Ad2CUJta3lRDA6RTtHMzWMmFY9jaPzqa9WdWgO9iROHQxi_L9qqK/exec';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        zodiac = Zodiac.fromJson(data);
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load zodiac data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple.shade700, Colors.purpleAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: isLoading
              ? Center(child: CircularProgressIndicator())
              : zodiac != null
                  ? SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Text(
                                'Your Horoscope',
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              'For ${zodiac!.date}',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white70,
                              ),
                            ),
                            SizedBox(height: 20),
                            ZodiacCard(
                                zodiac: zodiac!.aries,
                                zodiacSign: 'Aries',
                                iconPath: 'assets/icons/aries.png'),
                            ZodiacCard(
                                zodiac: zodiac!.taurus,
                                zodiacSign: 'Taurus',
                                iconPath: 'assets/icons/taurus.png'),
                            ZodiacCard(
                                zodiac: zodiac!.gemini,
                                zodiacSign: 'Gemini',
                                iconPath: 'assets/icons/gemini.png'),
                            ZodiacCard(
                                zodiac: zodiac!.cancer,
                                zodiacSign: 'Cancer',
                                iconPath: 'assets/icons/cancer.png'),
                            ZodiacCard(
                                zodiac: zodiac!.leo,
                                zodiacSign: 'Leo',
                                iconPath: 'assets/icons/leo.png'),
                            ZodiacCard(
                                zodiac: zodiac!.virgo,
                                zodiacSign: 'Virgo',
                                iconPath: 'assets/icons/virgo.png'),
                            ZodiacCard(
                                zodiac: zodiac!.libra,
                                zodiacSign: 'Libra',
                                iconPath: 'assets/icons/libra.png'),
                            ZodiacCard(
                                zodiac: zodiac!.scorpio,
                                zodiacSign: 'Scorpio',
                                iconPath: 'assets/icons/scorpio.png'),
                            ZodiacCard(
                                zodiac: zodiac!.sagitarius,
                                zodiacSign: 'Sagitarius',
                                iconPath: 'assets/icons/sagittarius.png'),
                            ZodiacCard(
                                zodiac: zodiac!.capricorn,
                                zodiacSign: 'Capricorn',
                                iconPath: 'assets/icons/capricorn.png'),
                            ZodiacCard(
                                zodiac: zodiac!.aquarius,
                                zodiacSign: 'Aquarius',
                                iconPath: 'assets/icons/aquarius.png'),
                            ZodiacCard(
                                zodiac: zodiac!.pisces,
                                zodiacSign: 'Pisces',
                                iconPath: 'assets/icons/pisces.png'),
                          ],
                        ),
                      ),
                    )
                  : Center(child: Text('Failed to load data')),
        ),
      ),
    );
  }
}

class ZodiacCard extends StatelessWidget {
  final String zodiac;
  final String zodiacSign;
  final String iconPath;

  const ZodiacCard({
    Key? key,
    required this.zodiac,
    required this.zodiacSign,
    required this.iconPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          leading: Image.asset(
            iconPath,
            height: 40,
            width: 40,
          ),
          title: Text(
            zodiacSign,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            zodiac,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
        ),
      ),
    );
  }
}
