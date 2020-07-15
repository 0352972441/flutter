import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/products.dart';
import 'package:shop/widgets/badge.dart';
import 'package:shop/screens/cart_screen.dart';
import '../providers/carts.dart';
import '../widgets/products_grid.dart';
import '../widgets/drawers.dart' as dr;

enum FilterOption { FavoriteOnly, All }

class ProductOverviewScreen extends StatefulWidget {
  bool isFavorite = false;
  bool isInit = true;
  bool _isLoading = false;
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  @override
  void didChangeDependencies() {
    if (widget.isInit) {
      setState(() {
        widget._isLoading = true;
      });
      Provider.of<Products>(context).fetchDatabase()
          //.catchError((error) {
          //   return showDialog(
          //       context: context,
          //       builder: (context) {
          //         return AlertDialog(
          //           actionsPadding:
          //               EdgeInsets.symmetric(vertical: 10, horizontal: 50),
          //           titleTextStyle: TextStyle(
          //               color: Colors.orange, fontWeight: FontWeight.bold),
          //           title: Text("An error occured !"),
          //           content: Text("Something went wrong !"),
          //           actions: <Widget>[
          //             FlatButton(
          //                 onPressed: () {
          //                   setState(() {});
          //                 },
          //                 child: Text("Ok"))
          //           ],
          //         );
          //       });
          // })
          .then((value) {
        setState(() {
          widget._isLoading = false;
        });
      });
    }
    widget.isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    //final showProduct = Provider.of<Products>(context);
    print("Product OverView");
    return Scaffold(
        appBar: AppBar(
          title: Text("Shop"),
          actions: <Widget>[
            PopupMenuButton(
              onSelected: (value) {
                if (FilterOption.FavoriteOnly == value) {
                  //showProduct.onlyFavorite();
                  setState(() {
                    widget.isFavorite = true;
                  });
                }
                if (FilterOption.All == value) {
                  setState(() {
                    widget.isFavorite = false;
                  });
                  //showProduct.showAll();
                }
              },
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    child: Text("Only Favorite"),
                    value: FilterOption.FavoriteOnly,
                  ),
                  PopupMenuItem(
                    child: Text("Show All"),
                    value: FilterOption.All,
                  ),
                ];
              },
            ),
            Consumer<Carts>(
              builder: (context, value, ch) =>
                  Badge(ch, value.size, Colors.green),
              child: IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: () {
                    return Navigator.pushNamed(context, CartScreen.ROUTERNAME);
                  }),
            ),
          ],
        ),
        drawer: dr.MyDrawer(),
        body: widget._isLoading
            ? Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.orange,
                ),
              )
            : ProductsGrid(widget.isFavorite));
  }
}

/**class ProductOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final showProduct = Provider.of<Products>(context);
    print("Product OverView");
    return Scaffold(
        appBar: AppBar(
          title: Text("Shop"),
          actions: <Widget>[
            PopupMenuButton(
              onSelected: (value) {
                if (FilterOption.FavoriteOnly == value) {
                  //showProduct.onlyFavorite();
                }
                if (FilterOption.All == value) {
                  //showProduct.showAll();
                }
              },
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    child: Text("Only Favorite"),
                    value: FilterOption.FavoriteOnly,
                  ),
                  PopupMenuItem(
                    child: Text("Show All"),
                    value: FilterOption.All,
                  ),
                ];
              },
            )
          ],
        ),
        body: ProductsGrid());
  }
} */
