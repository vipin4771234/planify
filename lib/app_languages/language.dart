// Created by Tayyab Mughal on 12/03/2023.
// Tayyab Mughal
// tayyabmughal676@gmail.com
// © 2022-2023  - All Rights Reserved

/// Language
class Language {
  final int id;
  final String flag;
  final String name;
  final String languageCode;

  Language(this.id, this.flag, this.name, this.languageCode);

  /// Language List
  static List<Language> languageList() {
    return <Language>[
      Language(1, "🇺🇸", "English", "en"),
      Language(2, "🇪🇸", "Spanish", "es"),
      Language(3, "🇫🇷", "French", "fr"),
      Language(4, "🇮🇹", "Italian", "it"),
      // Language(5, "🇨🇳", "Chinese", "ch"),
    ];
  }
}
