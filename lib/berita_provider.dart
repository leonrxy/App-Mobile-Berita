import 'package:flutter/material.dart';
import 'package:berita_uts/getapi.dart';

class BeritaProvider with ChangeNotifier {
  List<Berita> _listBerita = [];
  List<Berita> get listBerita => _listBerita;

  void setListBerita(List<Berita> berita) {
    _listBerita = berita;
    notifyListeners();
  }
}