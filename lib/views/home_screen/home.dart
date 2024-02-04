import 'package:rsm/consts/consts.dart';
import 'package:rsm/views/areas/areas_screen.dart';
import 'package:rsm/views/profile/profile_screen.dart';

class Home extends StatelessWidget {
  Home({super.key});

  List<Widget> screensList = [HomeScreen(), AreasScreen(), ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<HomeScreenController>(context, listen: false);
    return Scaffold(
      bottomNavigationBar:
          Consumer<HomeScreenController>(builder: (context, controller, xxx) {
        return BottomNavigationBar(
          selectedItemColor: blueColor,
          unselectedItemColor: Colors.grey.shade400,
          currentIndex: controller.selectedScreenIndex,
          onTap: (value) {
            controller.updateScreen = value;
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.public), label: "Areas"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile")
          ],
        );
      }),
      body: Consumer<HomeScreenController>(
        builder: (context, controller, xxx) {
          return screensList[controller.selectedScreenIndex];
        },
      ),
    );
  }
}
