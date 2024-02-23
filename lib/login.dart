import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String errormsg = '';
  bool statuslogin = false;

  bool error = false;
  bool showprogress = false;

  String username = '';
  String password = '';

  var _username = TextEditingController();

  var _password = TextEditingController();

  startLogin() async {
    String apiurl = "https://leonrxy.my.id/leonews/login.php";
    print(username);

    var response = await http.post(Uri.parse(apiurl),
        body: {'username': username, 'password': password});

    if (response.statusCode == 200 && username != '' && password != '') {
      statuslogin = false;
      var jsondata = json.decode(response.body);
      if (jsondata["error"]) {
        setState(() {
          showprogress = false;
          error = true;
          errormsg = jsondata["message"];
        });
      } else {
        if (jsondata["success"]) {
          setState(() {
            statuslogin = true;
            error = true;
            showprogress = false;
            errormsg = 'Login Berhasil!\nEmail : ' +
                jsondata["email"] +
                '\nNama : ' +
                jsondata["nama"];
          });
          String email = jsondata["email"];
          print(email);
        } else {
          showprogress = false;
          error = true;
          errormsg = "Something went wrong.";
        }
      }
    } else if (username == '' || password == '') {
      setState(() {
        statuslogin = false;
        showprogress = false; //don't show progress indicator
        error = true;
        errormsg = "Harap isi LeoNews ID/Email dan Password.";
      });
    } else {
      setState(() {
        statuslogin = false;
        showprogress = false; //don't show progress indicator
        error = true;
        errormsg = "Error during connecting to server.";
      });
    }
  }

  @override
  void initState() {
    username = "";
    password = "";
    errormsg = "";
    error = false;
    showprogress = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text(
          'Masuk ke LeoNews ID',
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          Center(
            child: Column(
              children: [
                SizedBox(height: 25),
                Image.asset(
                  'assets/images/logo.png',
                  width: 200,
                ),
                SizedBox(height: 25),
                Text(
                  'Login LeoNews',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  width: 400,
                  alignment: Alignment.center,
                  child: Text(
                    'Login dengan LeoNews ID untuk menggunakan layanan-layanan dari LeoNews',
                    style: TextStyle(fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 25),
                Container(
                  width: 400,
                  height: 50,
                  child: TextFormField(
                    controller: _username,
                    decoration: InputDecoration(
                      labelText: 'LeoNews ID/Email',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      //set username  text on change
                      username = value;
                    },
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  width: 400,
                  height: 50,
                  child: TextFormField(
                    controller: _password,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      // change password text
                      password = value;
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 4),
                  padding: EdgeInsets.all(10),
                  child: error ? errmsg(errormsg) : SizedBox(height: 30),
                ),
                Container(
                  width: 400,
                  height: 38,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.orange[500],
                    ),
                    onPressed: () {
                      setState(() {
                        //show progress indicator on click
                        showprogress = true;
                      });
                      startLogin();
                    },
                    child: showprogress
                        ? SizedBox(
                            height: 30,
                            width: 30,
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.orange[100],
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.deepOrangeAccent),
                            ),
                          )
                        : Text(
                            "Masuk",
                            style: TextStyle(fontSize: 18),
                          ),
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/register');
                          },
                          child: Text(
                            'Daftar LeoNews ID',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 14,
                            ),
                          )),
                      Text('atau'),
                      TextButton(
                        onPressed: () {
                          // Navigator.pushNamed(context, '/login');
                        },
                        child: Text(
                          'Lupa Password?',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 14,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 400,
                        height: 40,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            // Sign in with Google
                          },
                          icon: new Image.asset('assets/images/google.png',
                              fit: BoxFit.cover),
                          label: Text(
                            'Masuk dengan Google',
                            style: TextStyle(color: Colors.black),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary:
                                Colors.white, // set the button color to yellow
                          ),
                        ),
                      ),
                      SizedBox(height: 14),
                      Container(
                        width: 400,
                        height: 40,
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: Icon(
                            Icons.facebook,
                            size: 32,
                          ),
                          label: Text('Masuk dengan Facebook'),
                        ),
                      ),
                      SizedBox(height: 5),
                      Container(
                        width: 400,
                        alignment: Alignment.center,
                        child: Text(
                          'Dengan masuk atau mendaftar, Anda menyetujui Ketentuan Layanan dan Kebijakan Privasi LeoNews.',
                          style: TextStyle(fontSize: 14),
                          textAlign: TextAlign.center, // add this line
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }

  InputDecoration myInputDecoration(
      {required String label, required IconData icon}) {
    return InputDecoration(
      hintText: label, //show label as placeholder
      hintStyle:
          TextStyle(color: Colors.orange[100], fontSize: 20), //hint text style
      prefixIcon: Padding(
          padding: EdgeInsets.only(left: 20, right: 10),
          child: Icon(
            icon,
            color: Colors.orange[100],
          )
          //padding and icon for prefix
          ),

      contentPadding: EdgeInsets.fromLTRB(30, 20, 30, 20),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
              color: Colors.orange, width: 1)), //default border of input

      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide:
              BorderSide(color: Colors.orange, width: 1)), //focus border

      fillColor: Color.fromRGBO(251, 140, 0, 0.5),
      filled: true, //set true if you want to show input background
    );
  }

  Widget errmsg(String text) {
    //error message widget.
    if (statuslogin == false) {
      return Container(
        padding: EdgeInsets.all(7.00),
        margin: EdgeInsets.only(bottom: 4.00),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.red,
            border: Border.all(color: Colors.red, width: 2)),
        child: Row(children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 6.00),
            child: Icon(Icons.error, color: Colors.white),
          ),
          Text(text, style: TextStyle(color: Colors.white, fontSize: 13)),
        ]),
      );
    } else {
      return Container(
        padding: EdgeInsets.all(7.00),
        margin: EdgeInsets.only(bottom: 4.00),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.green,
            border: Border.all(color: Colors.green, width: 2)),
        child: Row(children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 6.00),
            child: Icon(Icons.check_circle, color: Colors.white),
          ), // icon for error message

          Text(text, style: TextStyle(color: Colors.white, fontSize: 13)),
          //show error message text
        ]),
      );
    }
  }

  Widget sucmsg(String text) {
    //error message widget.
    return Container(
      padding: EdgeInsets.all(7.00),
      margin: EdgeInsets.only(bottom: 10.00),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.red,
          border: Border.all(color: Colors.green, width: 2)),
      child: Row(children: <Widget>[
        Container(
          margin: EdgeInsets.only(right: 6.00),
          child: Icon(Icons.info, color: Colors.white),
        ), // icon for error message

        Text(text, style: TextStyle(color: Colors.white, fontSize: 13)),
        //show error message text
      ]),
    );
  }
}
