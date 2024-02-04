import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rsm/consts/consts.dart';

String getAirQualityFeedback(double sensorValue) {
  // Define threshold values for different air quality levels
  int goodThreshold = 200; // Example threshold for good air quality
  int moderateThreshold = 400; // Example threshold for moderate air quality
  int poorThreshold = 600; // Example threshold for poor air quality
  int hazardousThreshold = 800; // Example threshold for hazardous air quality

  // Check the air quality level based on the sensor value
  if (sensorValue < goodThreshold) {
    return "Good air quality";
  } else if (sensorValue < moderateThreshold) {
    return "Moderate air quality";
  } else if (sensorValue < poorThreshold) {
    return "Poor air quality";
  } else if (sensorValue < hazardousThreshold) {
    return "Hazardous air quality";
  } else {
    return "Very hazardous air quality";
  }
}

class AreasScreen extends StatelessWidget {
  const AreasScreen({super.key});

  Color getAirQualityColor(double sensorValue) {
    // Define the range for good to hazardous air quality
    int goodThreshold = 200;
    int moderateThreshold = 400;
    int poorThreshold = 600;
    int hazardousThreshold = 800;

    // Map the sensor value to a color gradient from green to red
    Color startColor = Colors.green.withOpacity(0.2);
    Color endColor = Colors.red.withOpacity(0.2);

    if (sensorValue < goodThreshold) {
      return startColor;
    } else if (sensorValue < moderateThreshold) {
      double ratio =
          (sensorValue - goodThreshold) / (moderateThreshold - goodThreshold);
      return Color.lerp(startColor, endColor, ratio)!;
    } else if (sensorValue < poorThreshold) {
      double ratio = (sensorValue - moderateThreshold) /
          (poorThreshold - moderateThreshold);
      return Color.lerp(startColor, endColor, ratio)!;
    } else if (sensorValue < hazardousThreshold) {
      double ratio =
          (sensorValue - poorThreshold) / (hazardousThreshold - poorThreshold);
      return Color.lerp(startColor, endColor, ratio)!;
    } else {
      return endColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('Area').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: blueColor,
                  strokeWidth: 2,
                ),
              );
            }

            var document = snapshot.data!.docs[0];
            String ppm = document['ppm'];
            double lat = document['lat'];
            double lon = document['lon'];
            String zone = document['zone_name'];
            return Stack(
              alignment: Alignment.bottomCenter,
              children: [
                GoogleMap(
                  mapToolbarEnabled: false,
                  myLocationButtonEnabled: false,
                  markers: {
                    Marker(
                      markerId: MarkerId("moudle1"),
                      position: LatLng(lat, lon),
                      infoWindow: InfoWindow(
                        title: "$ppm ${getAirQualityFeedback(
                          double.parse(ppm),
                        )}",
                      ),
                    )
                  },
                  circles: {
                    Circle(
                        circleId:
                            CircleId("your_unique_id"), // Unique identifier
                        center: LatLng(lat, lon), // Center coordinates
                        radius: 350, // Radius in meters
                        fillColor: getAirQualityColor(double.parse("600.0")),
                        // Fill color with opacity
                        strokeColor: Colors.transparent,
                        strokeWidth: 1
                        // Stroke width in pixels
                        )
                  },
                  initialCameraPosition:
                      CameraPosition(target: LatLng(lat, lon), zoom: 16),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        zone.text.fontFamily(semibold).size(16).make(),
                        getAirQualityFeedback(double.parse(ppm)).text.make()
                      ],
                    ),
                    "$ppm"
                        .text
                        .fontFamily(semibold)
                        .size(16)
                        .color(Colors.green)
                        .make()
                  ],
                )
                    .box
                    .white
                    .padding(EdgeInsets.all(12))
                    .roundedSM
                    .make()
                    .marginAll(12)
              ],
            );
          }),
    );
  }
}
