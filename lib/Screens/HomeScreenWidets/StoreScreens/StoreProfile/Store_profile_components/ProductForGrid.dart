import 'package:flutter/material.dart';
import 'package:ghioon_seller/Models/models.dart';
import 'package:ghioon_seller/Screens/HomeScreenWidets/ProductScreens/Product/ProductDetail/productDetail.dart';
import 'package:ghioon_seller/Screens/HomeScreenWidets/StoreScreens/StoreProfile/Store_profile_components/ProductGridListCard.dart';

class ProductForGrid extends StatelessWidget {
  const ProductForGrid({
    Key? key,
    required this.products,
  }) : super(key: key);

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.count(
          childAspectRatio: (2.5 / 3),
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          crossAxisCount: 2,
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 8.0,
          children: List.generate(products.length, (index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProductDetail(
                            product: products[index],
                          )),
                );
              },
              child: ProductListCard(product: products[index]),
            );
          })),
    );
  }
}
