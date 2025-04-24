import 'package:experiment/extentions.dart';
import 'package:experiment/screens/nav.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AuthScreen extends StatefulWidget {
  AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;
  bool oncheck = true;
  bool obs = true;

  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Text(
                    isLogin
                        ? "Login to your account"
                        : "Create Your New Account",
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    isLogin
                        ? "Please sign in to your account"
                        : "Create an account to start looking for the food you like ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 30),

                  // Sign Up Only Field
                  if (!isLogin)
                    TextFormField(
                      controller: _usernameController,
                      style: TextStyle(fontSize: 25, color: Colors.black),
                      decoration: const InputDecoration(
                        labelText: 'Username',
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
                  if (!isLogin) const SizedBox(height: 16),

                  // Email
                  TextFormField(
                    style: TextStyle(fontSize: 25, color: Colors.black),
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
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
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),

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
                  if (isLogin)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (_) => ForgotPasswordScreen()),
                            );
                          },
                          child: Text(
                            "Forgotten Password?",
                            style:
                                TextStyle(fontSize: 15, color: Colors.orange),
                          ),
                        )
                      ],
                    ),

                  if (!isLogin)
                    Row(
                      children: [
                        Checkbox(
                            activeColor: Colors.orange,
                            checkColor: Colors.white,
                            value: oncheck,
                            onChanged: (value) {
                              setState(() {
                                oncheck = !oncheck;
                              });
                            }),
                        Expanded(
                          child: Center(
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  const TextSpan(
                                    text: "I agree with the ",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  TextSpan(
                                      text: "Terms of Service",
                                      style: const TextStyle(
                                          color: Colors.orange)),
                                  const TextSpan(
                                    text: " and ",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  TextSpan(
                                    text: "Privacy Policy",
                                    style:
                                        const TextStyle(color: Colors.orange),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 30),

                  // Orange Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (_) => Nav(selectedIndex: _currentIndex, onIndexChanged: (index) {
                              setState(() {
                                _currentIndex = index;
                              });
                            },)));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: !oncheck ? Colors.grey : Colors.orange,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        isLogin ? "Sign In" : "Sign Up",
                        style:
                            const TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Social Login
                  Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "or sign in with",
                        style: TextStyle(
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildSocialIcon(FontAwesomeIcons.google, Colors.red),
                      const SizedBox(width: 16),
                      _buildSocialIcon(FontAwesomeIcons.facebookF, Colors.blue),
                      const SizedBox(width: 16),
                      _buildSocialIcon(FontAwesomeIcons.apple, Colors.black),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Switch Mode
                  TextButton(
                    onPressed: () {
                      setState(() => isLogin = !isLogin);
                    },
                    child: Text(
                      isLogin
                          ? "Don't have an account? Sign Up"
                          : "Already have an account? Log In",
                      style: const TextStyle(color: Colors.deepOrange),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon, Color color) {
    return CircleAvatar(
      radius: 20,
      backgroundColor: color,
      child: Icon(icon, color: Colors.white, size: 18),
    );
  }
}
