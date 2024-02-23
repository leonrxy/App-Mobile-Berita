import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController dateinput = TextEditingController();

  @override
  void initState() {
    dateinput.text = ""; //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        backgroundColor: Colors.yellow[800],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Form(
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                SizedBox(height: 16),
                Image.asset(
                  'assets/images/logo.png',
                  height: 50,
                ),
                SizedBox(height: 16),
                Center(
                  child: Text(
                    'LeoNews ID',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: 400,
                  alignment: Alignment.center,
                  child: Text(
                    'Login dengan LeoNews ID untuk menggunakan layanan-layanan dari LeoNews',
                    style: TextStyle(fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  width: 400,
                  height: 50,
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Nama Lengkap',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  width: 400,
                  height: 60,
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                      labelText: 'Jenis Kelamin',
                      border: OutlineInputBorder(),
                    ),
                    items: [
                      DropdownMenuItem(
                        child: Text('Laki-laki'),
                        value: 'Laki-laki',
                      ),
                      DropdownMenuItem(
                        child: Text('Perempuan'),
                        value: 'Perempuan',
                      ),
                    ],
                    onChanged: (value) {},
                  ),
                ),
                SizedBox(height: 16),
                Container(
                    width: 400,
                    height: 50,
                    child: TextFormField(
                      controller: dateinput,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Tanggal Lahir'),
                      readOnly:
                          true, //set it true, so that user will not able to edit text
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101));

                        if (pickedDate != null) {
                          print(pickedDate);
                          String formattedDate =
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                          print(formattedDate);

                          setState(() {
                            dateinput.text = formattedDate;
                          });
                        } else {
                          print("Date is not selected");
                        }
                      },
                    )),
                SizedBox(height: 16),
                Container(
                  width: 400,
                  height: 50,
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Nomor Telepon',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                ),
                SizedBox(height: 25),
                Container(
                  width: 400,
                  height: 38,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.orange[500],
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/register2');
                    },
                    child: Text('Lanjutkan'),
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Sudah memiliki akun LeoNews?'),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: Text(
                          'Masuk Disini',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 14,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Register2 extends StatefulWidget {
  @override
  _RegisterState2 createState() => _RegisterState2();
}

class _RegisterState2 extends State<Register2> {
  final _formKey = GlobalKey<FormState>(); // add form key
  bool _obscureText = true;
  bool clickButton = false;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        backgroundColor: Colors.yellow[800],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Form(
            key: _formKey, // assign form key
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                SizedBox(height: 16),
                Image.asset(
                  'assets/images/logo.png', // replace with your image path
                  height: 50,
                ),
                SizedBox(height: 16),
                Center(
                  child: Text(
                    'Alamat Email',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: 400,
                  alignment: Alignment.center,
                  child: Text(
                    'Login dengan LeoNews ID untuk menggunakan layanan-layanan dari LeoNews',
                    style: TextStyle(fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  width: 400,
                  height: 50,
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty && clickButton) {
                        return 'Email harus diisi';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  width: 400,
                  height: 50,
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Theme.of(context).primaryColorDark,
                        ),
                        onPressed: _toggle,
                      ),
                    ),
                    obscureText: _obscureText,
                    validator: (value) {
                      if (value!.isEmpty && clickButton) {
                        return 'Password harus diisi';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  width: 400,
                  height: 50,
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Konfirmasi Password',
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Theme.of(context).primaryColorDark,
                        ),
                        onPressed: _toggle,
                      ),
                    ),
                    obscureText: _obscureText,
                    validator: (value) {
                      if (value!.isEmpty && clickButton) {
                        return 'Konfirmasi password harus diisi';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: 400,
                  alignment: Alignment.center,
                  child: Text(
                    'Password minimal 8 karakter, terdiri dari huruf besar, huruf kecil, angka, dan simbol',
                    style: TextStyle(fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  width: 400,
                  height: 38,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // form is valid, do something
                      }
                      clickButton = true;
                    },
                    child: Text('Daftar'),
                    // disable button if form is invalid
                    // enable button if form is valid
                    // change button color based on form validity
                    style: ElevatedButton.styleFrom(
                      primary: Colors.orange[500],
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  width: 400,
                  alignment: Alignment.center,
                  child: Text(
                    'Dengan menekan tombol Daftar, Anda menyetujui Syarat & Ketentuan serta Kebijakan Privasi LeoNews',
                    style: TextStyle(fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
