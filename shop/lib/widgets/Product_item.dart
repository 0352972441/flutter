import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/auth.dart';
import 'package:shop/screens/product_detail_screen.dart';
import '../providers/product.dart';
import '../providers/carts.dart';

class ProductItem extends StatelessWidget {
  // final String title;
  // final String id;
  // final String imageUrl;

  // ProductItem(this.id, this.title, this.imageUrl);

  void selectedItem(BuildContext context) {
    //Navigator.pushNamed(context, ProductDetailScreen.ROUTENAME, arguments: id);
  }

  @override
  Widget build(BuildContext context) {
    print("Item product ");
    final cart = Provider.of<Carts>(context, listen: false);
    final product = Provider.of<Product>(context, listen: false);
    final auth = Provider.of<Auth>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, ProductDetailScreen.ROUTENAME,
                  arguments: product.id);
            },
            splashColor: Colors.blue,
            child: Image.network(product.imageUrl, fit: BoxFit.cover)),
        footer: GridTileBar(
          title: Text(product.title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.title),
          backgroundColor: Colors.black87.withOpacity(0.7),
          leading: Consumer<Product>(
            builder: (context, value, child) => IconButton(
                icon: Icon(
                  value.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: Theme.of(context).accentColor,
                ),
                onPressed: () =>
                    value.toggleChangeFavorite(product.id, auth.token)),
          ),
          trailing: IconButton(
              icon: Icon(Icons.shopping_cart,
                  color: Theme.of(context).accentColor),
              onPressed: () {
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text(
                    "Add " + product.title + " cart",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  backgroundColor: Colors.blue,
                  elevation: 5,
                  duration: Duration(seconds: 2),
                  action: SnackBarAction(
                      label: "UNDO",
                      onPressed: () {
                        cart.removeSingle(product.id);
                      }),
                ));
                cart.addItem(product.id, product.price, product.title);
              }),
        ),
      ),
    );
  }
}
/*
return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(image: NetworkImage(imageUrl),fit: BoxFit.cover,),
      ),
    child: Text(title),
    );*/
