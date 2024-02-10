import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rsm/consts/consts.dart';
import 'package:rsm/controllers/challans_controller.dart';
import 'package:rsm/views/view_challans/view_challans.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  TextEditingController searchField = TextEditingController();

  getColor(value) {
    if (value > 100) {
      return Colors.red;
    } else if (value > 50) {
      return Colors.orange;
    } else {
      return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    var challanController =
        Provider.of<ChallansController>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        centerTitle: false,
        title: "Vehicles Information".text.fontFamily(semibold).make(),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchField,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        isDense: true,
                        hintText: "Search Vehicles"),
                  ),
                ),
                Icon(
                  Icons.search,
                  color: borderColor,
                )
              ],
            )
                .box
                .roundedSM
                .border(color: borderColor)
                .padding(
                  const EdgeInsets.symmetric(horizontal: 20),
                )
                .make(),
            20.heightBox,
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Vehicles')
                    .where('vehicle_added', isEqualTo: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: SizedBox(
                          width: 10,
                          height: 10,
                          child: CircularProgressIndicator()),
                    );
                  }

                  // Display the list of documents
                  return ListView.builder(
                    padding: const EdgeInsets.all(0),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var document = snapshot.data!.docs[index];
                      String owner_name = document['username'];
                      // String contact = document['contact_no'];
                      String email = document['login_email'];
                      String insurance_status = document['insurance_status'];
                      String ppm = document['ppm'];
                      String type = document['vehicle_type'];
                      String vehicle_no = document['vehicle_number'];

                      bool isDeviceIntall = document['device_installed'];

                      if (document['challan'] == false &&
                          double.parse(document['ppm']) > 100) {
                        challanController.addChallanDocument(
                            docId: document.id,
                            name: owner_name,
                            email: email,
                            ppm: ppm,
                            uid: document['uid'],
                            vehicleName: document['vehicle_model'],
                            vehicleNo: vehicle_no);
                      }

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              vehicle_no.text
                                  .fontFamily(semibold)
                                  .size(16)
                                  .make(),
                              isDeviceIntall
                                  ? ppm.text
                                      .fontFamily(semibold)
                                      .color(getColor(double.parse(ppm)))
                                      .make()
                                  : "Device Not Install"
                                      .text
                                      .color(Colors.red)
                                      .make(),
                            ],
                          ),
                          20.heightBox,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  "Owner".text.make(),
                                  owner_name.text.fontFamily(semibold).make()
                                ],
                              ),
                              Container(
                                height: 30,
                                width: 1,
                                decoration: BoxDecoration(color: Colors.black),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  "type".text.make(),
                                  type.text.fontFamily(semibold).make()
                                ],
                              ),
                              Container(
                                height: 30,
                                width: 1,
                                decoration: BoxDecoration(color: Colors.black),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  "Insurance".text.make(),
                                  insurance_status.text
                                      .fontFamily(semibold)
                                      .make()
                                ],
                              ),
                            ],
                          ),
                        ],
                      )
                          .box
                          .roundedSM
                          .border(color: borderColor)
                          .padding(
                            const EdgeInsets.all(16),
                          )
                          .margin(EdgeInsets.only(bottom: 15))
                          .make()
                          .onTap(() {
                        challanController.selectedVehicleUid = document['uid'];
                        Get.to(
                          () => ViewChallans(vehicleData: document),
                        );
                      });
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
