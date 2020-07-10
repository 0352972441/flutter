import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/product.dart';
import 'package:shop/providers/products.dart';

class EditProductScreen extends StatefulWidget {
  static const String routeName = "/edit-product";
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _focusPrice = FocusNode();
  final _focusDescription = FocusNode();
  final _imageControler = TextEditingController();
  final _focusImage = FocusNode();
  final _keyForm = GlobalKey<FormState>();
  String title = "";
  String id = null;
  String imageUrl = '';
  String description = '';
  double price = 0;
  @override
  void initState() {
    _focusImage.addListener(_updateImage);
    super.initState();
  }

  @override
  void dispose() {
    _focusImage.removeListener(_updateImage);
    _focusImage.dispose();
    _imageControler.dispose();
    _focusPrice.dispose();
    _focusDescription.dispose();
    super.dispose();
  }

  String isValidatorImage(String value) {
    if (value.isEmpty) {
      return "Please enter a image url.";
    }
    if (!value.startsWith("http") && !value.startsWith("https")) {
      return "Please enter a valid URL";
    }
    if (!value.endsWith(".png") &&
        !value.endsWith('.jpg') &&
        !value.endsWith('.jpeg')) {
      return "Please enter a valid URL.";
    }
    return null;
  }

  void _updateImage() {
    if (_imageControler.text.isEmpty &&
        !_imageControler.text.startsWith("http") &&
        !_imageControler.text.startsWith("https") &&
        !_imageControler.text.endsWith(".png") &&
        !_imageControler.text.endsWith('.jpg') &&
        !_imageControler.text.endsWith('.jpeg')) {
      return;
    }
    // if (!_focusImage.hasFocus) {
    //   setState(() {});
    // }
    if (_focusImage.hasFocus) {
      setState(() {});
    }
  }

  void _saveForm() {
    bool isValidator = _keyForm.currentState.validate();
    if (!isValidator) {
      return;
    }
    _keyForm.currentState.save();
    Product product = new Product(
        id: null,
        title: title,
        description: description,
        price: price,
        imageUrl: imageUrl);
    print(product.title);
    print(product.description);
    print(product.price);
    print(product.imageUrl);
    Provider.of<Products>(context, listen: false).addProduct(product);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    print("Edit product");
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 200,
              color: Colors.green,
            ),
            Form(
              key: _keyForm,
              child: Container(
                padding:
                    EdgeInsets.only(top: 28.0, left: 10, right: 10, bottom: 10),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: "Title",
                          labelStyle: TextStyle(fontWeight: FontWeight.bold)),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (value) =>
                          FocusScope.of(context).requestFocus(_focusPrice),
                      onSaved: (newValue) => title = newValue,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Please provide a title.";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: "Price",
                          labelStyle: TextStyle(fontWeight: FontWeight.bold)),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      focusNode: _focusPrice,
                      onFieldSubmitted: (value) => FocusScope.of(context)
                          .requestFocus(_focusDescription),
                      onSaved: (newValue) => price = double.parse(newValue),
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Please enter a price.";
                        }
                        if (double.tryParse(value) == null) {
                          return "Please enter a number.";
                        }
                        if (double.parse(value) <= 0) {
                          return "Please enter a number greater than zero.";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: "Description",
                          labelStyle: TextStyle(fontWeight: FontWeight.bold)),
                      maxLines: 2,
                      keyboardType: TextInputType.multiline,
                      focusNode: _focusDescription,
                      onSaved: (newValue) => description = newValue,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Pleas enter a description.";
                        }
                        if (value.length <= 10) {
                          return "Should be at least 10 character long.";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.topCenter,
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            border: Border.all(
                                color: Colors.green,
                                width: 1,
                                style: BorderStyle.solid),
                          ),
                          child: _imageControler.text.isEmpty
                              ? Text("Enter a url")
                              : FittedBox(
                                  child: Image.network(
                                  _imageControler.text,
                                  fit: BoxFit.cover,
                                )),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 16),
                            child: TextFormField(
                              decoration: InputDecoration(labelText: "Image"),
                              controller: _imageControler,
                              keyboardType: TextInputType.url,
                              textInputAction: TextInputAction.done,
                              focusNode: _focusImage,
                              // onFieldSubmitted: (value) {
                              //   if (isValidatorImage(value) != null) {
                              //     return;
                              //   }
                              //   print("Running");
                              //   setState(() {});
                              // },
                              onSaved: (newValue) => imageUrl = newValue,
                              validator: (value) {
                                String error = '';
                                if ((error = isValidatorImage(value)) != null) {
                                  return error;
                                }
                                return null;
                              },
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: _saveForm,
        backgroundColor: Colors.green,
        tooltip: "Save",
      ),
    );
  }
}
