import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/products.dart';
import 'package:shop/screens/edit_product_screen.dart';
import 'package:shop/widgets/user_product_item.dart';
import '../widgets/drawers.dart';

class ManageProductsScreen extends StatelessWidget {
  static const routeName = '/managerScreen';

  Future<void> refresh(BuildContext context) async {
    await Provider.of<Products>(context, listen: false).fetchDatabase();
  }

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Manager Products"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.pushNamed(context, EditProductScreen.routeName);
              })
        ],
      ),
      drawer: MyDrawer(),
      // body: GridView.builder(
      //     itemCount: products.items.length,
      //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //         crossAxisCount: 1,
      //         crossAxisSpacing: 10,
      //         childAspectRatio: 3 / 2,
      //         mainAxisSpacing: 10),
      //     itemBuilder: (context, index) {
      //       return UserProductItem(
      //           products.items[index].imageUrl, products.items[index].title);
      //     })
      body: RefreshIndicator(
        onRefresh: () => refresh(context),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListView.builder(
            padding: EdgeInsets.only(top: 15),
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                    // border: Border.all(
                    //   color: Colors.blue,
                    //   width: 1,
                    // ),
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.blue.withOpacity(0.6),
                          offset: Offset(0, 2))
                    ]),
                margin: EdgeInsets.only(top: 10),
                child: UserProductItem(
                    products.items[index].id,
                    products.items[index].imageUrl,
                    products.items[index].title),
              );
            },
            itemCount: products.items.length,
          ),
        ),
      ),
    );
  }
}
