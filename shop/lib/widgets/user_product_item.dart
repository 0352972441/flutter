import 'package:flutter/material.dart';

class UserProductItem extends StatelessWidget {
  final String title;
  final String image;
  UserProductItem(this.image, this.title);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(image),
      ),
      title: Text(title),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(icon: Icon(Icons.edit), onPressed: () {}),
            IconButton(
                icon: Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () {}),
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
