getEmailContent({name, vehicleNumber, ppm}) {
  String emailContent = '''
Dear $name,

I hope this email finds you well. We regret to inform you that your vehicle, with registration number $vehicleNumber, has been recorded exceeding the prescribed pollution limit during a recent inspection. This violation is against the established standards set by the regulatory authorities.

Details of the Violation:
- Vehicle Registration Number: $vehicleNumber
- Date of Violation: ${getCurrentDateTimeString()}
- Exceeded Pollutant Level: ${ppm}

As a consequence of this violation, a challan has been issued against your vehicle. The fine amount is INR 500, and it is due for payment by ${getDateAfterOneMonth()}, which is one month from today.

Please take note of the following details:
- Challan Amount: INR 500
- Due Date: ${getDateAfterOneMonth()}

To facilitate a convenient and swift payment process, we encourage you to use our dedicated mobile application. The app provides a secure and user-friendly platform to complete the payment transaction effortlessly.

Instructions to Pay Challan Using the App:
1. Download our official app from the [App Store/Google Play Store].
2. Open the app and navigate to the "Challan Payment" section.
3. Enter the challan reference number: [Challan Reference Number]
4. Review the details of the violation and confirm the payment amount.
5. Choose your preferred payment method and complete the transaction.

We would like to emphasize the importance of adhering to environmental regulations and contributing to the well-being of our community. Your cooperation in promptly addressing this matter is highly appreciated.

If you have any queries or concerns regarding the challan, please do not hesitate to contact our customer support at [Customer Support Email/Phone Number].

Thank you for your understanding and cooperation.

Sincerely,

Nasik RTO
''';

  return emailContent;
}

String _twoDigits(int n) {
  return n.toString().padLeft(2, '0');
}

String getDateAfterOneMonth() {
  DateTime now = DateTime.now();
  DateTime oneMonthLater = now.add(Duration(days: 30));

  String formattedDate =
      "${_twoDigits(oneMonthLater.day)}-${_twoDigits(oneMonthLater.month)}-${oneMonthLater.year}";
  return formattedDate;
}

String getCurrentDateTimeString() {
  DateTime now = DateTime.now();
  String formattedDateTime =
      "${_twoDigits(now.day)}-${_twoDigits(now.month)}-${now.year} "
      "${_twoDigits(now.hour)}:${_twoDigits(now.minute)}";
  return formattedDateTime;
}
