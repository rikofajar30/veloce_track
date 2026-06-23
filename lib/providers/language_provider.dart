import 'package:flutter/material.dart';

class LanguageProvider with ChangeNotifier {
  bool _isEnglish = false;

  bool get isEnglish => _isEnglish;

  void toggleLanguage() {
    _isEnglish = !_isEnglish;
    notifyListeners();
  }

  String get txtWelcome =>
      _isEnglish ? "Welcome to Veloce Track" : "Selamat Datang di Veloce Track";
  String get txtLoginBtn =>
      _isEnglish ? "Sign in with Google" : "Masuk dengan Google";
  String get txtSetupTitle =>
      _isEnglish ? "Complete Your Profile" : "Lengkapi Profil Anda";
  String get txtWeight => _isEnglish ? "Weight (kg)" : "Berat Badan (kg)";
  String get txtHeight => _isEnglish ? "Height (cm)" : "Tinggi Badan (cm)";
  String get txtPrimarySport => _isEnglish ? "Primary Sport" : "Olahraga Utama";
  String get txtSave => _isEnglish ? "Save & Continue" : "Simpan & Lanjutkan";
  String get txtRun => _isEnglish ? "Run" : "Lari";
  String get txtRide => _isEnglish ? "Cycling" : "Sepeda";
  String get txtWalk => _isEnglish ? "Walk" : "Jalan Kaki";
}
