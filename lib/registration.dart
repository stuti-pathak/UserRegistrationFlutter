import 'package:flutter/material.dart';
import './services/service.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  static final RegExp emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  static final RegExp passwordRegex =
      RegExp(r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$");
  static final RegExp phoneRegex = RegExp(r"^[1-9]{1}[0-9]{9}$");
  // static final RegExp nameRegex = RegExp(r"[A-Z]{1}[a-z]{2,}");
  var _name;
  var _email;
  var _password;
  var _username;
  var _phoneNumber;

  final _formKey = GlobalKey<FormState>();

  addUser() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();
      var data = {
        "name": _name,
        "email": _email,
        "password": _password,
        "username": _username,
        "phone_number": _phoneNumber,
      };
      registerUser(data);
    }
  }

  Widget _buildNameField() {
    return TextFormField(
      keyboardType: TextInputType.name,
      decoration: InputDecoration(labelText: 'Name'),
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return 'Name is Required';
        }
      },
      onSaved: (value) {
        _name = value;
      },
    );
  }

  Widget _buildEmailFiled() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(labelText: 'Email'),
      validator: (value) {
        if (!emailRegex.hasMatch(value!)) {
          return 'Please enter a valid email address';
        }
        return null;
      },
      onSaved: (value) {
        _email = value;
      },
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(labelText: 'Password'),
      validator: (value) =>
          passwordRegex.hasMatch(value!) ? null : "Enter a valid password",
      onSaved: (value) => _password = value,
    );
  }

  Widget _buildUsernameField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(labelText: "Username"),
      validator: (value) =>
          value?.isEmpty ?? true ? "Please enter something" : null,
      onSaved: (value) => _username = value,
    );
  }

  Widget _buildPhoneNumberField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(labelText: "Mobile"),
      validator: (value) =>
          phoneRegex.hasMatch(value!) ? null : 'Enter a valid phone number',
      onSaved: (value) => _phoneNumber = value,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Store'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey, width: 3.0),
              borderRadius: BorderRadius.all((Radius.circular(2.0)))),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Center(
                    child: new Image.asset(
                  './images/register.jpg',
                  fit: BoxFit.cover,
                  height: 200,
                )),
                _buildNameField(),
                _buildEmailFiled(),
                _buildPasswordField(),
                _buildUsernameField(),
                _buildPhoneNumberField(),
                SizedBox(
                  height: 5,
                ),
                ElevatedButton(
                  onPressed: () {
                    addUser();
                  },
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
