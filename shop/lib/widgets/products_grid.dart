import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/auth.dart';
import '../providers/products.dart';
import '../widgets/Product_item.dart';
import '../providers/product.dart';

class ProductsGrid extends StatelessWidget {
  bool isFavorite;

  ProductsGrid(this.isFavorite);

  @override
  Widget build(BuildContext context) {
    print("Product Grid");
    final listProduct = Provider.of<Products>(context, listen: true);
    final List<Product> product =
        isFavorite ? listProduct.favorite : listProduct.items;
    return GridView.builder(
      padding: EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) =>
          /*ChangeNotifierProvider(
            create: (c) => product[index],*/
          ChangeNotifierProvider.value(
        value: product[index],
        /*Product(
            id: product[index].id,
            title: product[index].title,
            description: product[index].description,
            price: product[index].price,
            imageUrl: product[index].imageUrl), */
        child: ProductItem(
            // products[i].id,
            // products[i].title,
            // products[i].imageUrl,
            ),
      ),
      itemCount: product.length,
    );
  }
}
