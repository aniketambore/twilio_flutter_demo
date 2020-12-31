import 'package:flutter/material.dart';
import 'package:twilio_flutter/twilio_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Twilio Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Twilio Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  MyHomePage({this.title});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TwilioFlutter twilioFlutter;
  final _formKey = GlobalKey<FormState>();
  bool _isSubmitting;

  String _smsToNumber, _smsMessageText;

  @override
  void initState() {
    // TODO: implement initState
    twilioFlutter = TwilioFlutter(
        accountSid: '***', // replace *** with Account SID
        authToken: 'xxx', // replace xxx with Auth Token
        twilioNumber: '+....' // replace .... with Twilio Number
        );
    super.initState();
  }

//  void sendSms() async {
//    twilioFlutter.sendSMS(
//        toNumber: '+91', messageBody: 'hello world from aniket');
//    //Use sendSMS with the recipient number and message body.
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  _showTitle(),
                  _showNumberInput(),
                  _showMessageInput(),
                  _showFormActions()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _showTitle() {
    return Text(
      "Twilio Sms",
      style: TextStyle(fontSize: 72, fontWeight: FontWeight.bold),
    );
  }

  _showNumberInput() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: TextFormField(
        onSaved: (val) => _smsToNumber = val,
        validator: (val) => val.length < 10 ? "Invalid Number" : null,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Enter Number",
            hintText: "Enter Valid Number",
            icon: Icon(
              Icons.phone,
              color: Colors.grey,
            )),
      ),
    );
  }

  _showMessageInput() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: TextFormField(
        onSaved: (val) => _smsMessageText = val,
        validator: (val) => val.length < 5 ? "Very Short Message !" : null,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Enter Message",
            hintText: "Enter Your Message",
            icon: Icon(
              Icons.sms,
              color: Colors.grey,
            )),
      ),
    );
  }

  _showFormActions() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          _isSubmitting == true
              ? CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation(Theme.of(context).primaryColor),
                )
              : RaisedButton(
                  child: Text(
                    "Submit",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  color: Theme.of(context).accentColor,
                  onPressed: _submit),
        ],
      ),
    );
  }

  _submit() {
    final _form = _formKey.currentState;
    if (_form.validate()) {
      _form.save();
      _sendMessage();
    } else {
      print("Form is Invalid");
    }
  }

  _sendMessage() async {
    setState(() {
      _isSubmitting = true;
    });

    try {
      twilioFlutter.sendSMS(
          toNumber: '+91$_smsToNumber', messageBody: '$_smsMessageText');
      //Use sendSMS with the recipient number and message body.
    } catch (err) {
      print("The error is $err");
    }

    setState(() {
      _isSubmitting = false;
      _formKey.currentState.reset();
    });
  }
}
