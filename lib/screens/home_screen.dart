import 'package:experiment/extentions.dart';
import 'package:experiment/screens/search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<List<String>> imgs = [
    ["assets/images/hb/hb1.jpeg", "Burger 1", "20000"],
    ["assets/images/hb/hb2.jpeg", "Burger 2", "21000"],
    ["assets/images/hb/hb3.jpeg", "Burger 3", "24000"],
    ["assets/images/hb/hb4.jpeg", "Burger 4", "18000"],
    ["assets/images/hb/hb5.jpeg", "Burger 5", "14000"],
    ["assets/images/hb/hb6.jpeg", "Burger 6", "19000"],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SizedBox(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 20, left: 10, right: 10),
              height: 330,
              decoration: BoxDecoration(
                color: Colors.deepOrange,
                  borderRadius:
                  BorderRadius.vertical(bottom: Radius.circular(30))),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        height: 100,
                        width: 250,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Your Location",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                                Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: Colors.white,
                                  size: 40,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on_outlined,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                Text(
                                  "Port Harcourt",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen(),));
                                  },
                                  icon: Icon(
                                    Icons.search_outlined,
                                    size: 50,
                                    color: Colors.white,
                                  )),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.notifications_outlined,
                                    size: 50,
                                    color: Colors.white,
                                  )),
                            ],
                          ))
                    ],
                  ),
                  Text(
                    "Provides the best food for you",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 55,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Products",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
            ),
            Expanded(
                child: ListView.builder(
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    final limg = imgs[index];
                    final img = limg[0];
                    final name = limg[1];
                    final price = limg[2];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) =>
                              ProductDetailScreen(name: name,
                                  img: img,
                                  price: price,
                                  detail: "dfghyjukilokijuhygtfdghjkilolokijuhygtfdcfvbgnhjml;poiujhygtfcvbnm,.l;poijuhygfvv b nm,.;poiuyhgtfdcfvguiop;lkjhbgvbnm,"),));
                      },
                      child: box1(
                        price: price,
                        img: img,
                        name: name,
                      ),
                    );
                  },
                ))
          ],
        ),
      ),
    );
  }
}

class box1 extends StatelessWidget {
  final String img;
  final String name;
  final String price;

  const box1(
      {super.key, required this.img, required this.name, required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
      ),
      height: 300,
      width: 200,
      child: Column(
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image:
                DecorationImage(image: AssetImage(img), fit: BoxFit.fill)),
          ),
          Container(
            height: 100,
            child: Column(
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "\$" + price,
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
