import 'package:flutter/material.dart';

class PointOfSalePage extends StatefulWidget {
  const PointOfSalePage({super.key});
  
  @override
  State<PointOfSalePage> createState() => _PointOfSalePageState();
}

/* Bianca De Los Angeles
  Team: IDK
  Project: Siksik Labuyo
  Feature: [002] Point of Sale / Cart
  Feature Description:
    The skeletal UI of the shopping cart page view.
 */
class _PointOfSalePageState extends State<PointOfSalePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          // List of Products
          child: Column(
            children: const [
              ProductCard(),
              ProductCard(),
              ProductCard(),
              ProductCard(),
            ],
          ),
        ),

        // Info on Total cost of Products

        // Shopping Cart Button

      ),
    );
  }
}

class ProductCard extends StatelessWidget{
  const ProductCard({super.key});

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(

        shape: RoundedRectangleBorder( // card configurations
          side: BorderSide(color: Theme.of(context).colorScheme.outline,),
          borderRadius: const BorderRadius.all(Radius.circular(15)),
        ),
        child: const ProductInfo(),
      ),
    );
  }
}

// Format for Product Info
class ProductInfo extends StatefulWidget{
  const ProductInfo({super.key});

  @override
  State<StatefulWidget> createState() => _ProductInfoState();

}

class _ProductInfoState extends State<ProductInfo> {

  // Add / Subtract product from cart
  int _counterProduct = 0;
  void incrementProduct(){
    setState(() {
      _counterProduct++;
    });
  }
  void decrementProduct(){
    setState(() {
      if(_counterProduct != 0) {
        _counterProduct--;
      }
    });
  }

  @override
  Widget build(BuildContext context){
    return ListTile(
    // Image of the product
      leading: Image.network(
        "https://images.pexels.com/photos/6913383/pexels-photo-6913383.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
        fit: BoxFit.cover,
        width: 100,
        height: 150,),
      // Product Name & Content
      title: const Text('<Item Name>'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("<Category>"),
          const Text("<Creator/Seller Name>"),

          // Adding / Decrementing Products in cart
          Row(
            children: [
              IconButton(
                  onPressed:(){ incrementProduct(); },
                  icon: const Icon(Icons.add)),
              IconButton(
                  onPressed:(){ decrementProduct(); },
                  icon: const Icon(Icons.remove)),
            ],
          ),
          Text("$_counterProduct x",
          textAlign: TextAlign.right,)
        ],
      ),
      trailing: const Text("<Price>"),
      isThreeLine: true,
    );
  }
}

class _CustomizedButton extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: (){
        const productMessage = SnackBar(content: Text("Product Added / Subtracted"));
        ScaffoldMessenger.of(context).showSnackBar(productMessage);
      },
    );
  }
}