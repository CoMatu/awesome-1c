import 'dart:convert' show jsonDecode;
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/foundation.dart' show SynchronousFuture;
import 'package:flutter/material.dart' show BuildContext, Locale, Localizations, LocalizationsDelegate, immutable;

///
@immutable
class Localizer {
  const Localizer(this.locale);

  final Locale locale;
  String get languageCode => locale.languageCode;
  String get language => _languages[locale.languageCode];

  static Localizer of(BuildContext context) =>
    Localizations.of<Localizer>(context, Localizer);
  
  static Iterable<String> get supportedLanguageCodes =>
    _languages.keys;

  static Iterable<Locale> get supportedLocales =>
    _languages.keys.map<Locale>((String code) => Locale(code));
    
  static Locale get defaultLocale =>
    Locale(_languages.keys.first);
  
  static const Map<String, String> _languages = <String, String>{
    'en': 'English',
    'ru': 'Русский',
  };

  String operator [](String key) => Dictionaries.get(languageCode, key) ?? '...';
}

///
@immutable
class LocalizerDelegate extends LocalizationsDelegate<Localizer> {
  const LocalizerDelegate();
  
  @override
  bool isSupported(Locale locale) => 
    Localizer.supportedLanguageCodes.contains(locale.languageCode);

  @override
  Future<Localizer> load(Locale locale) =>
    SynchronousFuture<Localizer>(Localizer(locale));

  @override
  bool shouldReload(LocalizerDelegate old) => false;
}

///
class Dictionaries {
  final Map<String, Map<String, String>> _localizedValues = {};  
  static Map<String, Map<String, String>> get localizedValues => _instance._localizedValues;

  static String get(String languageCode, String key) =>
    _instance._localizedValues.containsKey(languageCode)
    ? _instance._localizedValues[languageCode][key]
    : null;

  static Future<void> fill() =>
    Future.wait<dynamic>(
      Localizer.supportedLanguageCodes
        .map<Future<dynamic>>(_languageCodeToDictionaryFromAsset)
    ).then<void>((List<dynamic> value) => 
      value
        .cast<MapEntry<String, dynamic>>()
        .forEach((MapEntry<String, dynamic> entry) =>
          _instance._localizedValues[entry.key] = Map<String, String>.from(entry.value as Map)));

  static Future<MapEntry<String, dynamic>> _languageCodeToDictionaryFromAsset(String languageCode) =>
    rootBundle.loadString('assets/lang/${languageCode?.toLowerCase() ?? 'en'}.json', cache: false)
      .then<dynamic>(jsonDecode)
      .then<MapEntry<String, dynamic>>((dynamic value) => MapEntry<String, dynamic>(languageCode, value));

  // SINGLETON +
  Dictionaries._();
  static final Dictionaries _instance = Dictionaries._();
  // SINGLETON -
}