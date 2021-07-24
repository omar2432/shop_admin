import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../screens/product_detail_screen.dart';
import '../providers/products.dart';
import '../providers/product.dart';
import '../providers/cart.dart';
import '../providers/auth.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;

  // ProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    String ver = Provider.of<Product>(context, listen: false).isverified;
    final products = Provider.of<Products>(context);
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    final authData = Provider.of<Auth>(context, listen: false);
    print(product.isverified);
    print(product.title);
    print('product.isverified');
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        //product.isverified=='true'?
        header: GridTileBar(
          trailing: Icon(
            ver == 'true'
                ? IconData(0xe699, fontFamily: 'MaterialIcons')
                : null,
            color: Colors.blue.shade400,
          ),
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
              arguments: product.id,
            );
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<Product>(
            builder: (ctx, product, _) => IconButton(
              icon: Icon(
                Icons.delete_outline,
                // product.isFavorite ? Icons.favorite : Icons.favorite_border,
              ),
              color: Theme.of(context).accentColor,
              onPressed: () {
                products.deleteFeateredProduct(product.id);
                //  products.fetchAndSetFeaturedProducts();
                /*
                product.toggleFavoriteStatus(
                  authData.token,
                  authData.userId,
                );*/
              },
            ),
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.featured_play_list,
            ),
            onPressed: () {
              products.addFeateredProduct(product, context);
              // products.fetchAndSetFeaturedProducts();
              // print(product.creatorId);
              //cart.addItem(product.id, product.creatorId, product.price, product.title);
              //  Scaffold.of(context).hideCurrentSnackBar();
              /*ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Item added as featured',
                  ),
                  duration: Duration(seconds: 2),
                  action: SnackBarAction(
                    label: 'UNDO',
                    onPressed: () {
                      products.deleteFeateredProduct(product.id);
                    },
                  ),
                ),
              );*/
            },
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}
