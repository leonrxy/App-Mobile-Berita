import 'package:http/http.dart' as http;
import 'dart:convert';

class Berita {
  final String id;
  final String kategori;
  final String judul;
  final String deskripsi;
  final String foto;
  final String waktu;

  const Berita({
    required this.id,
    required this.kategori,
    required this.judul,
    required this.deskripsi,
    required this.foto,
    required this.waktu,
  });

  factory Berita.fromJson(Map<String, dynamic> json) {
    return Berita(
      id: json['id_berita'],
      kategori: json['kategori'],
      judul: json['judul'],
      deskripsi: json['deskripsi'],
      foto: json['foto'],
      waktu: json['waktu'],
    );
  }
}

class RepoBerita {
  Future<List<Berita>> getData(String category) async {
    try {
      final response = await http.get(Uri.parse('https://leonrxy.my.id/leonews/berita.php?kategori=$category'));

      if (response.statusCode == 200) {
        Iterable it = jsonDecode(response.body);
        List<Berita> berita = it.map((e) => Berita.fromJson(e)).toList();
        return berita;
      } else {
        throw Exception('Gagal memuat berita');
      }
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
