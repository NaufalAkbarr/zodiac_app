import 'package:flutter/material.dart';
import 'api_service.dart';
import 'data_model.dart';

void main() {
  runApp(ZodiacApp());
}

class ZodiacApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zodiac Horoscope',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: ZodiacListScreen(),
    );
  }
}

class ZodiacListScreen extends StatefulWidget {
  @override
  _ZodiacListScreenState createState() => _ZodiacListScreenState();
}

class _ZodiacListScreenState extends State<ZodiacListScreen> {
  late Future<Zodiac> futureZodiac;
  final ZodiacService zodiacService = ZodiacService();

  @override
  void initState() {
    super.initState();
    futureZodiac = zodiacService.fetchZodiacData().then((data) => Zodiac.fromJson(data));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Zodiac Horoscope'),
      ),
      body: FutureBuilder<Zodiac>(
        future: futureZodiac,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No data available'));
          } else {
            final zodiac = snapshot.data!;
            return ListView(
              children: [
                ZodiacListItem(zodiacSign: 'Aries', detail: zodiac.aries),
                ZodiacListItem(zodiacSign: 'Taurus', detail: zodiac.taurus),
                ZodiacListItem(zodiacSign: 'Gemini', detail: zodiac.gemini),
                ZodiacListItem(zodiacSign: 'Cancer', detail: zodiac.cancer),
                ZodiacListItem(zodiacSign: 'Leo', detail: zodiac.leo),
                ZodiacListItem(zodiacSign: 'Virgo', detail: zodiac.virgo),
                ZodiacListItem(zodiacSign: 'Libra', detail: zodiac.libra),
                ZodiacListItem(zodiacSign: 'Scorpio', detail: zodiac.scorpio),
                ZodiacListItem(zodiacSign: 'Sagitarius', detail: zodiac.sagitarius),
                ZodiacListItem(zodiacSign: 'Capricorn', detail: zodiac.capricorn),
                ZodiacListItem(zodiacSign: 'Aquarius', detail: zodiac.aquarius),
                ZodiacListItem(zodiacSign: 'Pisces', detail: zodiac.pisces),
              ],
            );
          }
        },
      ),
    );
  }
}

class ZodiacListItem extends StatelessWidget {
  final String zodiacSign;
  final String detail;

  const ZodiacListItem({
    Key? key,
    required this.zodiacSign,
    required this.detail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(zodiacSign, style: TextStyle(fontSize: 20)),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ZodiacDetailScreen(zodiacSign: zodiacSign, detail: detail),
          ),
        );
      },
    );
  }
}

class ZodiacDetailScreen extends StatelessWidget {
  final String zodiacSign;
  final String detail;

  const ZodiacDetailScreen({
    Key? key,
    required this.zodiacSign,
    required this.detail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$zodiacSign Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              zodiacSign,
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              detail,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
