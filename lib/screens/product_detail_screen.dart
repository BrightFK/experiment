import 'package:experiment/extentions.dart';

class ProductDetailScreen extends StatelessWidget {
  final String name;
  final String img;
  final String price;
  final String detail;

  const ProductDetailScreen(
      {super.key,
      required this.name,
      required this.img,
      required this.price,
      required this.detail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(top: 20, left: 10, right: 10),
            height: 330,
            decoration: BoxDecoration(
                image:
                    DecorationImage(image: AssetImage(img), fit: BoxFit.fill),
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(30))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      size: 30,
                      color: Colors.white,
                    )),
                Text(
                  "About this meal",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.favorite_outline,
                      size: 30,
                      color: Colors.white,
                    )),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 60),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "\$$price",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      color: Colors.orange),
                ),
                SizedBox(
                  height: 20,
                ),
                Divider(),
                Text(
                  "Description",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "dfghyjukilokijuhygtfdghjkilolokijuhygtfdcfvbgnhjml;poiujhygtfcvbnm,.l;poijuhygfvv b nm,.;poiuyhgtfdcfvguiop;lkjhbgvbnm,",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 25),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        height: 100,
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(onPressed: () {}, icon: Icon(Icons.remove, size: 30, color: Colors.black,),),
            Text("4", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),),
            IconButton(onPressed: () {}, icon: Icon(Icons.add, size: 30, color: Colors.black,),),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                minimumSize: Size(200, 80),
              ),
              child: const Text("Add to cart",
                  style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
