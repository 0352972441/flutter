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
  var _editedProduct = Product(
    id: null,
    title: '',
    price: 0,
    description: '',
    imageUrl: '',
  );
  Map<String, Object> products = {
    "title": "",
    'description': "",
    'price': "",
  };
  // String title = "";
  // String id = null;
  // String imageUrl = '';
  // String description = '';
  // double price = 0;
  bool isInit = true;
  bool isLoading = false;
  @override
  void initState() {
    _focusImage.addListener(_updateImage);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (isInit) {
      final idProduct = ModalRoute.of(context).settings.arguments as String;
      if (idProduct != null) {
        _editedProduct = Provider.of<Products>(context).findById(idProduct);
        products = {
          "title": _editedProduct.title,
          "description": _editedProduct.description,
          "price": _editedProduct.price
        };
        _imageControler.text = _editedProduct.imageUrl;
        //id = singleProduct.id;
        // title = singleProduct.title;
        // _imageControler.text = singleProduct.imageUrl;
        // description = singleProduct.description;
        // price = singleProduct.price;
      }
    }
    isInit = false;
    super.didChangeDependencies();
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

  /*void _saveForm() {
    bool isValidator = _keyForm.currentState.validate();
    if (!isValidator) {
      return;
    }
    _keyForm.currentState.save();
    setState(() {
      isLoading = true;
    });  
    Product product = _editedProduct;
    if (_editedProduct.id != null) {
      Provider.of<Products>(context, listen: false)
          .updateSingleProduct(product.id, product);
      Navigator.pop(context);
      setState(() {
        isLoading = false;
      });
    } else {
      Provider.of<Products>(context, listen: false)
          .addProduct(product)
          .catchError((error) {
        return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              elevation: 5,
              title: Text("An error occured!",
                  style: TextStyle(color: Colors.orange)),
              content: Text("Something went wrong!"),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      return Navigator.of(context).pop();
                    },
                    child: Text("Okay"))
              ],
            );
          },
        );
      }).then((_) {
        print("Running Pop");
        setState(() {
          isLoading = false;
        });
        Navigator.pop(context);
      });
    }
  }*/
  Future<void> _saveForm() async {
    final bool isValidator = _keyForm.currentState.validate();
    if (!isValidator) {
      return;
    }
    _keyForm.currentState.save();
    setState(() {
      isLoading = true;
    });
    Product product = _editedProduct;
    if (product.id != null) {
      await Provider.of<Products>(context, listen: false)
          .updateSingleProduct(product.id, product);
      setState(() {
        isLoading = false;
      });
      // Navigator.pop(context);
    } else {
      try {
        await Provider.of<Products>(context, listen: false).addProduct(product);
      } catch (error) {
        await showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                titleTextStyle: TextStyle(color: Colors.orange),
                title: Text("An error Occured !"),
                content: Text("Something went wrong !"),
                actions: <Widget>[
                  FlatButton(
                      onPressed: () => Navigator.pop(ctx), child: Text("Okay"))
                ],
              );
            });
      } finally {
        // setState(() {
        //   isLoading = false;
        // });
        // Navigator.pop(context);
      }
    }
    setState(() {
      isLoading = false;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    print("Edit product");
    return Scaffold(
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.green,
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 200,
                    color: Colors.green,
                  ),
                  Form(
                    key: _keyForm,
                    child: Container(
                      padding: EdgeInsets.only(
                          top: 28.0, left: 10, right: 10, bottom: 10),
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            initialValue: products['title'],
                            decoration: InputDecoration(
                                labelText: "Title",
                                labelStyle:
                                    TextStyle(fontWeight: FontWeight.bold)),
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (value) => FocusScope.of(context)
                                .requestFocus(_focusPrice),
                            onSaved: (value) {
                              //title = value;
                              _editedProduct = Product(
                                  title: value,
                                  price: _editedProduct.price,
                                  description: _editedProduct.description,
                                  imageUrl: _editedProduct.imageUrl,
                                  id: _editedProduct.id,
                                  isFavorite: _editedProduct.isFavorite);
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Please provide a title.";
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            initialValue: products['price'].toString(),
                            decoration: InputDecoration(
                                labelText: "Price",
                                labelStyle:
                                    TextStyle(fontWeight: FontWeight.bold)),
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            focusNode: _focusPrice,
                            onFieldSubmitted: (value) => FocusScope.of(context)
                                .requestFocus(_focusDescription),
                            onSaved: (value) {
                              //price = double.parse(value);
                              _editedProduct = Product(
                                  title: _editedProduct.title,
                                  price: double.parse(value),
                                  description: _editedProduct.description,
                                  imageUrl: _editedProduct.imageUrl,
                                  id: _editedProduct.id,
                                  isFavorite: _editedProduct.isFavorite);
                            },
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
                            initialValue: products["description"],
                            decoration: InputDecoration(
                                labelText: "Description",
                                labelStyle:
                                    TextStyle(fontWeight: FontWeight.bold)),
                            maxLines: 2,
                            keyboardType: TextInputType.multiline,
                            focusNode: _focusDescription,
                            onSaved: (value) {
                              //description = value;
                              _editedProduct = Product(
                                  title: _editedProduct.title,
                                  price: _editedProduct.price,
                                  description: value,
                                  imageUrl: _editedProduct.imageUrl,
                                  id: _editedProduct.id,
                                  isFavorite: _editedProduct.isFavorite);
                            },
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
                                    : Image.network(
                                        _imageControler.text,
                                        fit: BoxFit.cover,
                                      ),
                                // : FittedBox(
                                //     child: Image.network(
                                //     _imageControler.text,
                                //     fit: BoxFit.cover,
                                //   )),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 16),
                                  child: TextFormField(
                                    //initialValue: "",
                                    decoration:
                                        InputDecoration(labelText: "Image"),
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
                                    onSaved: (value) {
                                      //imageUrl = value;
                                      _editedProduct = Product(
                                          title: _editedProduct.title,
                                          price: _editedProduct.price,
                                          description:
                                              _editedProduct.description,
                                          imageUrl: value,
                                          id: _editedProduct.id,
                                          isFavorite:
                                              _editedProduct.isFavorite);
                                    },
                                    validator: (value) {
                                      String error = '';
                                      if ((error = isValidatorImage(value)) !=
                                          null) {
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
