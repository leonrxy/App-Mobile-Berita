import 'package:flutter/material.dart';
import 'package:berita_uts/getapi.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Berita> listBerita = [];
  List<Berita> beritaTerbaru = [];
  List<Berita> beritaTerpopuler = [];
  List<Berita> beritaRekomendasi = [];
  List filteredBerita = [];
  bool isLoading = true;
  bool isSearch = false;

  RepoBerita repoBerita = RepoBerita();

  Widget appLogo = Container(
    padding: const EdgeInsets.all(4.0),
    child: Image.asset(
      'assets/images/logo.png',
      fit: BoxFit.contain,
      height: 32,
    ),
  );
  Widget SearchBar = Icon(
    Icons.search_rounded,
    color: Colors.orange,
  );

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    try {
      List<Berita> dataSemua = await repoBerita.getData('all');
      List<Berita> dataTerbaru = await repoBerita.getData('terbaru');
      List<Berita> dataTerpopuler = await repoBerita.getData('terpopuler');
      List<Berita> dataRekomendasi = await repoBerita.getData('rekomendasi');
      //print('Length of data received: ${data.length}');
      if (mounted) {
        // Pastikan widget masih ada sebelum memanggil setState
        setState(() {
          listBerita = dataSemua;
          beritaTerbaru = dataTerbaru;
          beritaTerpopuler = dataTerpopuler;
          beritaRekomendasi = dataRekomendasi;
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error occurred while fetching data: $e');
      setState(() {
        isLoading = true;
      });
    }
  }

  void filterBerita(String query) {
    setState(() {
      filteredBerita = listBerita
          .where((listBerita) =>
              listBerita.judul.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return MaterialApp(
          home: Scaffold(
        appBar: AppBar(
          title: appLogo,
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
            actions: [
              IconButton(
                onPressed: () {
                  isSearch = !isSearch;
                  setState(() {
                    if (isSearch) {
                      SearchBar = Icon(
                        Icons.cancel,
                        color: Colors.orange,
                      );
                      appLogo = ListTile(
                        leading: Icon(
                          Icons.search,
                          color: Colors.orange,
                          size: 28,
                        ),
                        title: TextField(
                          onChanged: (query) {
                            filterBerita(query);
                          },
                          decoration: InputDecoration(
                            hintText: 'Cari Berita',
                            hintStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontStyle: FontStyle.italic,
                            ),
                            border: InputBorder.none,
                          ),
                          style: TextStyle(
                            color: Color.fromARGB(255, 19, 0, 0),
                          ),
                        ),
                      );
                    } else {
                      SearchBar = Icon(
                        Icons.search_rounded,
                        color: Colors.orange,
                      );
                      appLogo = Container(
                        padding: const EdgeInsets.all(4.0),
                        child: Image.asset(
                          'assets/images/logo.png',
                          fit: BoxFit.contain,
                          height: 32,
                        ),
                      );
                    }
                  });
                },
                icon: SearchBar,
              )
            ],
            title: appLogo,
            backgroundColor: Colors.white,
          ),
          backgroundColor: Colors.grey[200],
          body: ListView(
            padding: const EdgeInsets.all(4),
            children: <Widget>[
              Container(
                height: 50,
                color: Colors.amber[600],
                child: const Center(
                    child: Text(
                  'Berita Terbaru',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )),
              ),
              Container(
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      child: Container(
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
                                  beritaTerbaru[index].foto,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(130, 0, 0, 0),
                              child: Text(
                                beritaTerbaru[index].judul,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(130, 90, 0, 0),
                              child: Text(
                                ('LeoNews - ' + beritaTerbaru[index].waktu),
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey[600]),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: 4,
                ),
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 4,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.87,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Container(
                      color: Colors.white,
                      margin: EdgeInsets.all(4),
                      child: Column(
                        children: [
                          Container(
                            height: 170,
                            margin: EdgeInsets.only(bottom: 3),
                            child: Image.network(
                              beritaRekomendasi[index].foto,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 4, right: 4),
                            child: Text(
                              beritaRekomendasi[index].judul,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 5, right: 5, top: 2),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'LeoNews - ' + beritaRekomendasi[index].waktu,
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              Container(
                alignment: AlignmentDirectional.center,
                margin: EdgeInsets.only(bottom: 4, top: 0),
                child: SizedBox(
                  width: 300,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'Selengkapnya',
                      style: TextStyle(
                          color: Colors.yellow[900],
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.grey[300],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: listBerita.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.all(4),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.all(0.5),
                            height: 200,
                            width: 160,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  Container(
                                    height: 160,
                                    width: 160,
                                    child: Image.network(
                                      listBerita[index].foto,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Container(
                                    color: Colors.white,
                                    height: 55,
                                    alignment: Alignment.bottomCenter,
                                    padding: EdgeInsets.only(
                                        left: 4, right: 4, top: 2, bottom: 2),
                                    child: Text(
                                      listBerita[index].judul,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Container(
                height: 50,
                color: Colors.amber[500],
                child: const Center(
                    child: Text(
                  'Berita Terpopuler',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )),
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 4,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.87,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Container(
                      color: Colors.white,
                      margin: EdgeInsets.all(4),
                      child: Column(
                        children: [
                          Container(
                            height: 170,
                            margin: EdgeInsets.only(bottom: 3),
                            child: Image.network(
                              listBerita[index].foto,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 4, right: 4),
                            child: Text(
                              listBerita[index].judul,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 5, right: 5, top: 2),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'LeoNews - ' + listBerita[index].waktu,
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              Container(
                height: 50,
                color: Colors.orange[300],
                child: const Center(
                    child: Text(
                  'Rekomendasi Untuk Anda',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )),
              ),
              ListView.separated(
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
                              beritaRekomendasi[index].foto,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(130, 0, 0, 0),
                          child: Text(
                            beritaRekomendasi[index].judul,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(130, 90, 0, 0),
                          child: Text(
                            ('LeoNews - ' + beritaRekomendasi[index].waktu),
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
                itemCount: 4,
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 4,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.87,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Container(
                      color: Colors.white,
                      margin: EdgeInsets.all(4),
                      child: Column(
                        children: [
                          Container(
                            height: 170,
                            margin: EdgeInsets.only(bottom: 3),
                            child: Image.network(
                              beritaRekomendasi[index].foto,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 4, right: 4),
                            child: Text(
                              beritaRekomendasi[index].judul,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 5, right: 5, top: 2),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'LeoNews - ' + beritaRekomendasi[index].waktu,
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      );
    }
  }
}
