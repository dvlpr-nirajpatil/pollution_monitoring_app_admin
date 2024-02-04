import 'package:firebase_auth/firebase_auth.dart';
import 'package:rsm/consts/consts.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.only(top: 60, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            "Profile".text.fontFamily(semibold).size(22).make(),
            20.heightBox,
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: borderColor,
                  radius: 35,
                ),
                20.widthBox,
                "Admin".text.fontFamily(semibold).size(18).make()
              ],
            )
                .box
                .border(color: borderColor)
                .roundedSM
                .padding(EdgeInsets.all(12))
                .make(),
            20.heightBox,
            ListTile(
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Get.offAll(() => SplashScreen());
              },
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: blueColor,
              ),
              title: "Sign Out".text.make(),
            ).box.border(color: borderColor).roundedSM.make()
          ],
        ),
      ),
    );
  }
}
