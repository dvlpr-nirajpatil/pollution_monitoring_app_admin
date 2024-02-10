import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rsm/consts/consts.dart';
import 'package:rsm/consts/list.dart';
import 'package:rsm/consts/margins_and_padding.dart';
import 'package:rsm/controllers/challans_controller.dart';

class ViewChallans extends StatelessWidget {
  ViewChallans({super.key, this.vehicleData});

  var vehicleData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        centerTitle: false,
        title: "${vehicleData['vehicle_number']}"
            .text
            .fontFamily(semibold)
            .size(18)
            .make(),
      ),
      body: Container(
        padding: screenPadding.copyWith(top: 20),
        width: double.infinity,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  "Owner Name".text.fontFamily(semibold).make(),
                  "${vehicleData['username']}".text.fontFamily(semibold).make()
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  "Vehicle Company".text.fontFamily(semibold).make(),
                  "${vehicleData['vehicle_brand']}"
                      .text
                      .fontFamily(semibold)
                      .make()
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  "model".text.fontFamily(semibold).make(),
                  "${vehicleData['vehicle_model']}"
                      .text
                      .fontFamily(semibold)
                      .make()
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  "Insurance".text.fontFamily(semibold).make(),
                  "${vehicleData['insurance_status']}"
                      .text
                      .fontFamily(semibold)
                      .make()
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  "PPM Value".text.fontFamily(semibold).make(),
                  "${vehicleData['ppm']}".text.fontFamily(semibold).make()
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  "Device Status".text.fontFamily(semibold).make(),
                  vehicleData['device_installed'] == true
                      ? "Installed"
                          .text
                          .fontFamily(semibold)
                          .color(Colors.green)
                          .make()
                      : "Not Installed"
                          .text
                          .color(Colors.red)
                          .fontFamily(semibold)
                          .make()
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  "Email".text.fontFamily(semibold).make(),
                  "${vehicleData['login_email']}"
                      .text
                      .fontFamily(semibold)
                      .make()
                ],
              ),
            ],
          )
              .box
              .border(color: borderColor)
              .roundedSM
              .padding(EdgeInsets.all(12))
              .make(),
          20.heightBox,
          "Challans".text.fontFamily(semibold).size(18).make(),
          10.heightBox,
          Consumer<ChallansController>(builder: (context, controller, xxx) {
            return Row(
              children: List.generate(
                Challans.length,
                (index) => "${Challans[index]}"
                    .text
                    .color(controller.selectedChallans == index
                        ? Colors.white
                        : blueColor)
                    .make()
                    .box
                    .border(color: blueColor)
                    .roundedSM
                    .color(controller.selectedChallans == index
                        ? blueColor
                        : Colors.white)
                    .padding(
                      EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    )
                    .margin(
                      EdgeInsets.only(right: 10),
                    )
                    .make()
                    .onTap(() {
                  controller.updateChallan = index;
                }),
              ),
            );
          }),
          20.heightBox,
          Expanded(
            child: Consumer<ChallansController>(
                builder: (context, controller, xx) {
              return StreamBuilder<QuerySnapshot>(
                stream: controller.selectedChallans == 0
                    ? FirebaseFirestore.instance
                        .collection('Challans')
                        .where('uid', isEqualTo: controller.selectedVehicleUid)
                        .where('paid_status', isEqualTo: 'pending')
                        .snapshots()
                    : FirebaseFirestore.instance
                        .collection('Challans')
                        .where('uid', isEqualTo: controller.selectedVehicleUid)
                        .where('paid_status', isEqualTo: 'paid')
                        .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SizedBox(
                      width: 10,
                      height: 10,
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: blueColor,
                          ),
                        ),
                      ),
                    );
                  }

                  // Check if there are no pending documents
                  if (snapshot.data!.docs.isEmpty) {
                    return Center(
                      child: Text('No Challans found.'),
                    );
                  }

                  // Display the list of pending documents
                  return ListView.builder(
                    padding: EdgeInsets.all(0),
                    // itemCount: 10,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var document = snapshot.data!.docs[index];
                      // Access the document data using document.data()
                      var data = document.data() as Map<String, dynamic>;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              "${data['vehicle_no']}"
                                  .text
                                  .fontFamily(semibold)
                                  .size(16)
                                  .make(),
                              "₹ ${data['fine']}"
                                  .text
                                  .color(data['paid_status'] == "paid"
                                      ? Colors.green
                                      : Colors.red)
                                  .fontFamily(semibold)
                                  .size(16)
                                  .make(),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              "PPM ".text.size(16).make(),
                              "${data['ppm']}".text.size(16).make(),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              "Date ".text.size(16).make(),
                              "${data['date']}".text.size(16).make(),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              "Due Date ".text.size(16).make(),
                              "${data['due_date']}".text.size(16).make(),
                            ],
                          ),
                        ],
                      )
                          .box
                          .border(color: borderColor)
                          .padding(EdgeInsets.all(12))
                          .roundedSM
                          .margin(
                            EdgeInsets.only(
                              bottom: 20,
                            ),
                          )
                          .make();
                    },
                  );
                },
              );
            }),
          ),
        ]),
      ),
    );
  }
}
