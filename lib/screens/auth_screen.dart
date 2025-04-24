import 'package:experiment/extentions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;
  bool onCheck = true;
  bool obs = true;
  final _formKey = GlobalKey<FormState>(); // Added a form key
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance; // Firebase Auth instance
  bool _isLoading =
      false; // To track loading state for showing progress indicator

  int _currentIndex = 0;

  // Function for showing error dialog
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text('Okay'),
          ),
        ],
      ),
    );
  }

  // Function for handling sign up
  Future<void> _signUp() async {
    if (!_formKey.currentState!.validate() || !onCheck) {
      return;
    }
    setState(() {
      _isLoading = true;
    });
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      //update the user's display name.
      await userCredential.user
          ?.updateDisplayName(_usernameController.text.trim());
      //send email verification
      await userCredential.user?.sendEmailVerification();
      if (mounted) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (_) => Nav(
                  selectedIndex: _currentIndex,
                  onIndexChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ))); // Navigate
      }
    } on FirebaseAuthException catch (error) {
      _showErrorDialog(error.message ?? 'An error occurred');
    } catch (error) {
      _showErrorDialog('An error occurred');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Function for handling sign in
  Future<void> _signIn() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    setState(() {
      _isLoading = true;
    });
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      if (userCredential.user?.emailVerified == false) {
        _showErrorDialog("Please verify your email address.");
        await _auth.signOut();
        return;
      }
      if (mounted) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (_) => Nav(
                  selectedIndex: _currentIndex,
                  onIndexChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ))); // Navigate
      }
    } on FirebaseAuthException catch (error) {
      _showErrorDialog(error.message ?? 'An error occurred');
    } catch (error) {
      _showErrorDialog('An error occurred');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                // Added a form
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      isLogin
                          ? "Login to your account"
                          : "Create Your New Account",
                      style: const TextStyle(
                        fontSize: 30, // Changed to 30
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      isLogin
                          ? "Please sign in to your account"
                          : "Create an account to start looking for the food you like ",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Sign Up Only Field
                    if (!isLogin)
                      TextFormField(
                        controller: _usernameController,
                        style: const TextStyle(
                            fontSize: 18, color: Colors.black), // Changed to 18
                        decoration: const InputDecoration(
                          labelText: 'Username',
                          labelStyle: TextStyle(
                            color: Colors.black87,
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black,
                                  style: BorderStyle.solid)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black,
                                  style: BorderStyle.solid)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black,
                                  style: BorderStyle.solid)),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your username';
                          }
                          return null;
                        },
                      ),
                    if (!isLogin) const SizedBox(height: 16),

                    // Email
                    TextFormField(
                      style: const TextStyle(fontSize: 18, color: Colors.black),
                      // Changed to 18
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!value.contains('@')) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Password
                    TextFormField(
                      style: const TextStyle(fontSize: 18, color: Colors.black),
                      // Changed to 18
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
                        labelStyle: const TextStyle(
                          color: Colors.black87,
                        ),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.black, style: BorderStyle.solid)),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.black, style: BorderStyle.solid)),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.black, style: BorderStyle.solid)),
                      ),
                      obscureText: obs,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters long';
                        }
                        return null;
                      },
                    ),
                    if (isLogin)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ForgotPasswordScreen()),
                              );
                            },
                            child: const Text(
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
                              value: onCheck,
                              onChanged: (value) {
                                setState(() {
                                  onCheck = !onCheck;
                                });
                              }),
                          const Expanded(
                            child: Center(
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "I agree with the ",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    TextSpan(
                                        text: "Terms of Service",
                                        style: TextStyle(color: Colors.orange)),
                                    TextSpan(
                                      text: " and ",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    TextSpan(
                                      text: "Privacy Policy",
                                      style: TextStyle(color: Colors.orange),
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
                        onPressed: _isLoading
                            ? null // Disable button when loading
                            : () {
                                if (isLogin) {
                                  _signIn();
                                } else {
                                  _signUp();
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              !onCheck ? Colors.grey : Colors.orange,
                          // disable button if checkbox is false
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: _isLoading
                            ? const CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ) // Show loader
                            : Text(
                                isLogin ? "Sign In" : "Sign Up",
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Social Login
                    const Divider(
                      color: Colors.grey,
                      thickness: 1,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
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
                        _buildSocialIcon(
                            FontAwesomeIcons.facebookF, Colors.blue),
                        const SizedBox(width: 16),
                        _buildSocialIcon(FontAwesomeIcons.apple, Colors.black),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Switch Mode
                    TextButton(
                      onPressed: () {
                        setState(() {
                          isLogin = !isLogin;
                        });
                      },
                      child: Text(
                        isLogin
                            ? "Don't have an account? Sign Up"
                            : "Already have an account? Log In",
                        style: const TextStyle(
                            color: Colors.deepOrange), // Corrected color
                      ),
                    ),
                  ],
                ),
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

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>(); // Added a form key.
  final _emailController = TextEditingController();
  bool _isLoading =
      false; // Added to track loading state for showing progress indicator.
  final _auth = FirebaseAuth.instance;

  //Function for showing error dialog
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text('Okay'),
          ),
        ],
      ),
    );
  }

  Future<void> _resetPassword() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    setState(() {
      _isLoading = true;
    });
    try {
      await _auth.sendPasswordResetEmail(email: _emailController.text.trim());
      if (mounted) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Password Reset Email Sent"),
                content: const Text(
                    "A password reset link has been sent to your email. Please check your inbox."),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                      child: const Text("Ok"))
                ],
              );
            });
      }
    } on FirebaseAuthException catch (error) {
      _showErrorDialog(error.message ?? "Failed to send reset email");
    } catch (error) {
      _showErrorDialog("An unexpected error occurred");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            // Added a form
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Forgot Password",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Enter your email address to receive a password reset link",
                  style: TextStyle(
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  style: const TextStyle(fontSize: 18, color: Colors.black),
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!value.contains('@')) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading
                        ? null
                        : _resetPassword, // Disable button when loading
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ) // Show loader
                        : const Text(
                            "Send Reset Link",
                            style: TextStyle(fontSize: 20, color: Colors.white),
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
