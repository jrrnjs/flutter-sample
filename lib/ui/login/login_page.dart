import 'package:flutter/material.dart';
import 'package:validate/validate.dart';
import 'package:flutter_sample/ui/home/home_page.dart';

class Login extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('login page'),
      ),
      body: LoginPage()
    );
  }
}

class LoginPage extends StatefulWidget {

  LoginPage([Key key]) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final GlobalKey<FormState> _formKey = GlobalKey();
  String email;
  String password;


  String _validateEmail(String value) {
    try {
      Validate.isEmail(value);
    } catch (e) {
      return 'The E-mail Address must be a valid email address.';
    }

    return null;
  }

  String _validatePassword(String value) {
    if (value.length < 8) {
      return 'The Password must be at least 8 characters.';
    }

    return null;
  }

  void onClickLogin() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Home(email))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: this._formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                maxLines: 1,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Enter your e-mail',
                  labelText: 'E-Mail',
                ),
                validator: this._validateEmail,
                onSaved: (String value) {
                  this.email = value;
                },
              ),
              TextFormField(
                maxLines: 1,
                keyboardType: TextInputType.text,
                obscureText: true,
                decoration: InputDecoration(
                    hintText: 'Enter your password',
                    labelText: 'Password'
                ),
                validator: this._validatePassword,
                onSaved: (String value) {
                  this.password = value;
                },
              ),
              Container(
                child: RaisedButton(
                  child: Text(
                    'Login',
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                  onPressed: this.onClickLogin,
                  color: Colors.indigoAccent,
                ),
                margin: EdgeInsets.only(
                    top: 20.0
                ),
              )
            ],
          ),
        ),
    );
  }
}


