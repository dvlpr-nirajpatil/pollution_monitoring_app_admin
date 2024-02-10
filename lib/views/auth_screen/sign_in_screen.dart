import '../../consts/consts.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final _key = GlobalKey<FormState>();

  TextEditingController emailField = TextEditingController();
  TextEditingController passField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    var controller = Provider.of<AuthController>(context, listen: false);
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
        width: double.infinity,
        child: SingleChildScrollView(
          child: Form(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: height * 0.2,
                ),
                "Hello Again !".text.fontFamily(semibold).size(22).make(),
                30.heightBox,
                customTextField(
                    name: "Email", hint: "Enter Email", controller: emailField),
                customTextField(
                    name: "Password",
                    hint: "Enter your password",
                    is_pass: true,
                    controller: passField),
                const SizedBox(
                  height: 20,
                ),
                FilledButton(
                    onPressed: () async {
                      if (_key.currentState!.validate()) {
                        // Form is valid, perform desired action
                        await controller
                            .userSignIn(
                                email: emailField.text, pass: passField.text)
                            .then((value) {
                          if (value != null) {
                            Get.off(() => Home());
                          }
                        });
                      }
                    },
                    child: const Text("Sign In"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
