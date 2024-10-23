class Zodiac {
  final String date;
  final String aries;
  final String taurus;
  final String gemini;
  final String cancer;
  final String leo;
  final String virgo;
  final String libra;
  final String scorpio;
  final String sagitarius;
  final String capricorn;
  final String aquarius;
  final String pisces;

  Zodiac({
    required this.date,
    required this.aries,
    required this.taurus,
    required this.gemini,
    required this.cancer,
    required this.leo,
    required this.virgo,
    required this.libra,
    required this.scorpio,
    required this.sagitarius,
    required this.capricorn,
    required this.aquarius,
    required this.pisces,
  });

  factory Zodiac.fromJson(Map<String, dynamic> json) {
    return Zodiac(
      date: json['date'],
      aries: json['aries'],
      taurus: json['taurus'],
      gemini: json['gemini'],
      cancer: json['cancer'],
      leo: json['leo'],
      virgo: json['virgo'],
      libra: json['libra'],
      scorpio: json['scorpio'],
      sagitarius: json['sagitarius'],
      capricorn: json['capricorn'],
      aquarius: json['aquarius'],
      pisces: json['pisces'],
    );
  }
}
