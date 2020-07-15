import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/httpException.dart';
import 'package:shop/providers/products.dart';
import 'package:shop/screens/edit_product_screen.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String image;
  UserProductItem(this.id, this.image, this.title);
  @override
  Widget build(BuildContext context) {
    final ScaffoldState scaffold = Scaffold.of(context);
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(image),
      ),
      title: Text(title),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  Navigator.pushNamed(context, EditProductScreen.routeName,
                      arguments: id);
                }),
            IconButton(
                icon: Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () async {
                  try {
                    await Provider.of<Products>(context, listen: false)
                        .remoteSingle(id);
                    print("Three Line");
                  } on HttpException {
                    print("four Line");
                    scaffold
                        .showSnackBar(SnackBar(content: Text("Delete fail !")));
                  } catch (error) {
                    scaffold
                        .showSnackBar(SnackBar(content: Text("Delete fail !")));
                  }
                }),
          ],
        ),
      ),
    );
  }
}

// class UserProductItem extends StatelessWidget {
//   final String title;
//   final String image;
//   UserProductItem(this.image, this.title);
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 5,
//       margin: EdgeInsets.all(5),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//       child: Column(
//         children: <Widget>[
//           ClipRRect(
//             borderRadius: BorderRadius.circular(10),
//             child: Image.network(
//               image,
//               width: double.infinity,
//               height: 150,
//               fit: BoxFit.cover,
//             ),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Padding(
//             padding: EdgeInsets.all(20),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: <Widget>[
//                 Row(
//                   children: <Widget>[
//                     IconButton(
//                       icon: Icon(Icons.edit),
//                       onPressed: null,
//                     ),
//                   ],
//                 ),
//                 Row(
//                   children: <Widget>[
//                     SizedBox(
//                       width: 20,
//                     ),
//                     InkWell(
//                       splashColor: Colors.red,
//                       child: IconButton(
//                         icon: Icon(
//                           Icons.delete,
//                           color: Theme.of(context).errorColor,
//                         ),
//                         onPressed: null,
//                       ),
//                     )
//                   ],
//                 )
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
