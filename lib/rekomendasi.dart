import 'package:flutter/material.dart';
import 'package:berita_uts/getapi.dart';

class Rekomendasi extends StatefulWidget {
  @override
  State<Rekomendasi> createState() => _RekomendasiState();
}

class _RekomendasiState extends State<Rekomendasi> {
  List<Berita> listBerita = [];

  bool isLoading = true;

  RepoBerita repoBerita = RepoBerita();

  getData() async {
    List<Berita> data = await repoBerita.getData('rekomendasi');
    print('Length of data received: ${data.length}');
    if (mounted) {
      // Pastikan widget masih ada sebelum memanggil setState
      setState(() {
        listBerita = data;
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (listBerita.isEmpty && isLoading) {
      getData();
      return MaterialApp(
          home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Rekomendasi Untuk Anda',
            style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          backgroundColor: Colors.white,
        ),
        body: Center(
          child: CircularProgressIndicator.adaptive(
            backgroundColor: Colors.orange[100],
            valueColor: AlwaysStoppedAnimation<Color>(
              Colors.orange, //<-- SEE HERE
            ),
          ),
        ),
      ));
    } else {
      return MaterialApp(
          home: Scaffold(
              appBar: AppBar(
                title: Text(
                  'Rekomendasi Untuk Anda',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                backgroundColor: Colors.white,
              ),
              body: ListView(
                children: [
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.all(4),
                              height: 120,
                              child: Stack(
                                children: [
                                  Container(
                                    width: 120,
                                    height: 120,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        listBerita[index].foto,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(130, 0, 0, 0),
                                    child: Text(
                                      listBerita[index].judul,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(130, 90, 0, 0),
                                    child: Text(
                                      ('LeoNews - ' + listBerita[index].waktu),
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey[600]),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => Divider(),
                          itemCount: listBerita.length,
                        ),
                      ),
                    ],
                  ),
                ],
              )));
    }
  }
}
