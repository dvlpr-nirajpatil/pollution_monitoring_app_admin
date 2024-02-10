import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rsm/consts/consts.dart';
import 'package:http/http.dart' as http;
import 'package:rsm/consts/email_format.dart';

class ChallansController extends ChangeNotifier {
  int selectedChallans = 0;

  String selectedVehicleUid = "";

  set updateChallan(int value) {
    selectedChallans = value;
    notifyListeners();
  }

  Future<void> sendEmail({to, ppm, name, vehicleNumber}) async {
    try {
      final Uri url = Uri.parse('http://3.147.78.78:80/send-email');

      final Map<String, dynamic> requestBody = {
        'to': to,
        'text':
            getEmailContent(name: name, vehicleNumber: vehicleNumber, ppm: ppm),
        'subject': "Subject: Notice of Traffic Violation - Payment Due",
      };

      final http.Response response = await http.post(
        url,
        body: jsonEncode(requestBody),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        print('Email sent successfully.');
      } else {
        print('Error sending email. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (error) {
      print('Error sending email: $error');
    }
  }

  Future<void> addChallanDocument(
      {name, email, ppm, uid, vehicleName, vehicleNo, docId}) async {
    try {
      // Get a reference to the Firestore instance
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      CollectionReference challansCollection = firestore.collection('Challans');

      await challansCollection.add({
        'ppm': ppm,
        'date': getCurrentDateTimeString(),
        'due_date': getDateAfterOneMonth(),
        'fine': "500",
        'paid_status': "pending",
        'uid': uid,
        'vehicle_name': vehicleName,
        'vehicle_no': vehicleNo,
      });

      sendEmail(to: email, ppm: ppm, name: name, vehicleNumber: vehicleNo);
      updateChallanStatus(docId);

      print('Challan document added successfully.');
    } catch (error) {
      print('Error adding challan document: $error');
    }
  }

  Future<void> updateChallanStatus(String vehicleId) async {
    try {
      // Get a reference to the Firestore instance
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Reference to the "Vehicles" collection
      CollectionReference vehiclesCollection = firestore.collection('Vehicles');

      // Update the 'challan' field to true for the specified document ID
      await vehiclesCollection.doc(vehicleId).update({'challan': true});

      print('Challan status updated successfully.');
    } catch (error) {
      print('Error updating challan status: $error');
    }
  }
}
