import 'package:experiment/extentions.dart';
import 'package:experiment/screens/nav.dart';

class ResetScreen extends StatefulWidget {
  const ResetScreen({super.key});

  @override
  State<ResetScreen> createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
  final _passwordController = TextEditingController();
  final _passwordController1 = TextEditingController();
  bool obs = true;

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("Reset Password"),
        titleTextStyle: TextStyle(
          fontSize: 30,
          color: Colors.black,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Text(
              "Reset Password",
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 10),
            Text(
              "Your new password must be different from the old one",
              style: TextStyle(fontSize: 20, color: Colors.black87),
            ),
            const SizedBox(height: 30),
            // Password
            TextField(
              style: TextStyle(fontSize: 25, color: Colors.black),
              controller: _passwordController,
              decoration: InputDecoration(
                suffix: IconButton(
                    onPressed: () {
                      setState(() {
                        obs = !obs;
                      });
                    },
                    icon: Icon(
                      obs ? Icons.visibility_off : Icons.visibility,
                      color: Colors.black,
                    )),
                labelText: 'Password',
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
              obscureText: obs,
            ),
            const SizedBox(height: 30),
            // Password
            TextField(
              style: TextStyle(fontSize: 25, color: Colors.black),
              controller: _passwordController1,
              decoration: InputDecoration(
                suffix: IconButton(
                    onPressed: () {
                      setState(() {
                        obs = !obs;
                      });
                    },
                    icon: Icon(
                      obs ? Icons.visibility_off : Icons.visibility,
                      color: Colors.black,
                    )),
                labelText: 'Confirm Password',
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
              obscureText: obs,
            ),

            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (_) => Nav(
                              selectedIndex: _currentIndex,
                              onIndexChanged: (index) {
                                setState(() {
                                  _currentIndex = index;
                                });
                              },
                            )));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text("Verify Account",
                  style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
