import 'package:experiment/extentions.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final controller = PageController();
  bool isLastPage = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: PageView(
          controller: controller,
          onPageChanged: (index) {
            setState(() => isLastPage = index == 2);
          },
          children: [
            buildPage(
              img: "assets/images/hb/hb5.jpeg",
              title: 'We Serve Incomparable Delicacies',
              subtitle: "All the best restaurants with their top menu waiting for you, they can't wait for your order!",
            ),
            buildPage(
              img: "assets/images/hb/hb6.jpeg",
              title: 'We Serve Incomparable Delicacies',
              subtitle: "All the best restaurants with their top menu waiting for you, they can't wait for your order!",
            ),
            buildPage(
              img: "assets/images/hb/hb7.jpeg",
              title: 'We Serve Incomparable Delicacies',
              subtitle: "All the best restaurants with their top menu waiting for you, they can't wait for your order!",
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPage({
    required String img,
    required String title,
    required String subtitle,
  }) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(img), fit: BoxFit.fitHeight)
      ),
      child: Center(
        child: Container(
          padding: EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.all(Radius.circular(50))
          ),
          width: 400,
          height: 500,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(title,
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold,)),
              SizedBox(height: 10),
              Text(subtitle,
                  textAlign: TextAlign.center, style: TextStyle(fontSize: 20)),
              SizedBox(
                height: 30,
              ),
              isLastPage
                  ? SizedBox(
                height: 80,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to home or login screen
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => AuthScreen()),
                    );
                  },
                  child: Icon(Icons.arrow_forward_outlined, size: 40,),
                ),
              )
                  : Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      child: Text('Skip'),
                      onPressed: () => controller.jumpToPage(2),
                    ),
                    Center(
                      child: SmoothPageIndicator(
                        controller: controller,
                        count: 3,
                        effect: WormEffect(
                          dotHeight: 10,
                          dotWidth: 10,
                          activeDotColor: Colors.white,
                        ),
                      ),
                    ),
                    TextButton(
                      child: Text('Next'),
                      onPressed: () => controller.nextPage(
                        duration: Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
