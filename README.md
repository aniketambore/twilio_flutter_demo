# Flutter Twilio Sms Example Easy

![Flutter Twilio Sms Example](ss/screenshot.png)

- Package used [twilio_flutter: ^0.0.5](https://pub.dev/packages/twilio_flutter)

---

## Step 1
- Create a new object
```dart
TwilioFlutter twilioFlutter;
```

## Step 2
- From InitState, Initialize with values
```dart
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
```

## Step 3
- Send Sms
```dart
  void sendSms() async {
    twilioFlutter.sendSMS(
        toNumber: '+91', messageBody: 'hello world');
    //Use sendSMS with the recipient number and message body.
  }
```

## Step 4
- Call the sendSms() method from any onPressed event.