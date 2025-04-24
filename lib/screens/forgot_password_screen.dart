import 'package:experiment/extentions.dart';
import 'package:experiment/screens/otp_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Text(
                  "Forgot Password",
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Enter your email address and we'll send you confirmation code to reset your password",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 30),
                TextFormField(
                  controller: _emailController,
                  style: TextStyle(fontSize: 25, color: Colors.black),
                  decoration: const InputDecoration(
                    labelText: 'Email Address',
                    labelStyle: TextStyle(
                      color: Colors.black87,
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.black, style: BorderStyle.solid)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.black, style: BorderStyle.solid)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.black, style: BorderStyle.solid)),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  OtpScreen(email: _emailController.text)));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      "Continue",
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
