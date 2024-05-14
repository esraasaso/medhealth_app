import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:medhealth/network/api/url_api.dart';
import 'package:medhealth/network/model/product_model.dart';
import 'package:medhealth/screens/cart_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/network/model/pref_profile_model.dart';
import 'detail_product.dart';
import '/theme.dart';
import 'search_product.dart';
import '/widgets/card_category.dart';
import '/widgets/card_product.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:draggable_fab/draggable_fab.dart';
class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late File file;
  bool _hasBeenPressed = false;
  Future pickercamera() async{
    final myfile =await ImagePicker().pickImage(source:ImageSource.gallery);
    setState(() {
      file=File(myfile!.path);
      _hasBeenPressed = !_hasBeenPressed;
    });
  }
  late int index;
  bool filter = false;
  List<CategoryWithProduct> listCategory = [];

  getCategory() async {
    listCategory.clear();
    var urlCategory = Uri.parse(Personal.categoryWithProduct);
    final response = await http.get(urlCategory);
    if (response.statusCode == 200) {
      setState(() {
        final data = jsonDecode(response.body);
        for (Map<String,dynamic> item in data) {
          listCategory.add(CategoryWithProduct.fromJson(item));
        }
      });
      getProduct();
      totalCart();
    }
  }

  List<ProductModel> listProduct = [];
  getProduct() async {
    listProduct.clear();
    var urlProduct = Uri.parse(Personal.getProduct);
    final response = await http.get(urlProduct);
    if (response.statusCode == 200) {
      setState(() {
        final data = jsonDecode(response.body);
        for (Map<String,dynamic> product in data) {
          listProduct.add(ProductModel.fromJson(product));
        }
      });
    }
  }

  late String userID;
  getPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      userID = sharedPreferences.getString(PrefProfile.idUSer).toString();
    });
  }

  var jumlahCart = "0";
  totalCart() async {
    var urlGetTotalCart = Uri.parse(Personal.getTotalCart + userID);
    final response = await http.get(urlGetTotalCart);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)[0];
      String jumlah = data['Jumlah'];
      setState(() {
        jumlahCart = jumlah;
      });
    }
  }
  @override
  void initState(){
    super.initState();
    getCategory();
    getPref();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: DraggableFab(
          child:FloatingActionButton(
            backgroundColor:greenColor,
            elevation: 100,
          onPressed: (){},
          child: Icon(Icons.message,size:30,color:Colors.white,),
      )),
        body: SafeArea(
            child: ListView(
              padding: EdgeInsets.fromLTRB(24, 30, 24, 30),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/logo.png',
                          width: 155,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          "Find a medicine or\nvitamins with MEDHEALTH!",
                          style: regulerTextstyle.copyWith(
                              fontSize: 15, color: gryBoldColor),
                        )
                      ],
                    ),
                    Stack(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CartPage(totalCart)));
                          },
                          icon: Icon(
                            Icons.shopping_cart_outlined,
                            color: greenColor,
                          ),
                        ),
                        jumlahCart == "0" ? SizedBox()
                            : Positioned(
                          right: 10,
                          top: 10,
                          child: Container(
                            height: 13,
                            width: 13,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(30)),
                            child: Center(
                                child: Text(
                                  jumlahCart,
                                  style: regulerTextstyle.copyWith(
                                      color: whiteColor, fontSize: 12),
                                )),
                          ),
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 24,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SearchProdcut()));
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                    height: 55,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xffe4faf0)),
                    child: TextField(
                      enabled: false,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.search,
                            color: Color(0xffb1d8b2),
                          ),
                          hintText: "Search medicine ...",
                          hintStyle: regulerTextstyle.copyWith(color: Color(0xffb0d8b2))),
                    ),
                  ),
                ),
                SizedBox(
                  height: 14,
                ),
           Container(
             child:TextButton.icon(
               onPressed: pickercamera,
               label: Text("Upload Your Prescription here !",textAlign:TextAlign.start,style:regulerTextstyle.copyWith(fontSize:16)),
               style: TextButton.styleFrom(
                 foregroundColor:_hasBeenPressed ?Colors.black54:Color(0xff000000),
                 // color: _hasBeenPressed ?Color(0xffb0d8b9): Colors.white,
                 backgroundColor: _hasBeenPressed ?Color(0xffa5d6a7):Colors.white,
               ),
               icon:Icon(Icons.photo_camera,color:_hasBeenPressed ?greenColor:gryLightColor,size: 25,),),
           ),
               SizedBox(
                  height: 14,
                ),
                Text(
                  "Medicine & Vitamins by Category",
                  style: regulerTextstyle.copyWith(fontSize: 16),
                ),
                SizedBox(
                  height: 14,
                ),
                GridView.builder(
                    physics: ClampingScrollPhysics(),
                    itemCount: listCategory.length,
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4, mainAxisSpacing: 10),
                    itemBuilder: (context, i) {
                      final x = listCategory[i];
                      return InkWell(
                        onTap: () {
                          setState(() {
                            index = i;
                            filter = true;
                            print("$index, $filter");
                          });
                        },
                        child: CardCategory(
                          imageCategory: x.image,
                          nameCategory: x.category,
                        ),
                      );
                    }),
                SizedBox(
                  height: 32,
                ),
                filter
                // ? index == 7
                // ? Text("Feature on proggress")
                    ? GridView.builder(
                    physics: ClampingScrollPhysics(),
                    itemCount: listCategory[index].product.length,
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16),
                    itemBuilder: (context, i) {
                      final y = listCategory[index].product[i];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailProduct(y)));
                        },
                        child: CardProduct(
                          nameProduct: y.nameProduct,
                          imageProduct: y.imageProduct,
                          price: y.price,
                        ),
                      );
                    })
                    : GridView.builder(
                    physics: ClampingScrollPhysics(),
                    itemCount: listProduct.length,
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16),
                    itemBuilder: (context, i) {
                      final y = listProduct[i];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailProduct(y)));
                        },
                        child: CardProduct(
                          nameProduct: y.nameProduct,
                          imageProduct: y.imageProduct,
                          price: y.price,
                        ),
                      );
                    }),
              ],
            )));
  }
}
