import 'package:cookbook_flutter/ios-app-cupertino/product.dart';
import 'package:cookbook_flutter/ios-app-cupertino/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_state_model.dart';

class ProductRowItem extends StatelessWidget {
  const ProductRowItem({
    required this.product,
    super.key,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      minimum: const EdgeInsets.only(
        left: 0,
        top: 8,
        bottom: 8,
        right: 8,
      ),
      child: CupertinoListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Image.asset(
            product.assetName,
            package: product.assetPackage,
            fit: BoxFit.cover,
            width: 68,
            height: 68,
          ),
        ),
        leadingSize: 68,
        title: Text(
          product.name,
          style: Styles.productRowItemName,
        ),
        subtitle: Text(
          '\$${product.price}',
          style: Styles.productRowItemPrice,
        ),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            final model = Provider.of<AppStateModel>(context, listen: false);
            model.addProductToCart(product.id);
            showCupertinoSnackBar(context: context, message: "Item added to cart Successfully");
          },
          child: const Icon(
            CupertinoIcons.plus_circled,
            semanticLabel: 'Add',
          ),
        ),
      ),
    );
  }
}

void showCupertinoSnackBar({
  required BuildContext context,
  required String message,
  int durationMillis = 2000,
}) {
  final overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      bottom: 16.0,
      left: 8.0,
      right: 8.0,
      child: CupertinoPopupSurface(
        child: Container(
          color: Colors.grey,
          padding: const EdgeInsets.all(16.0),
          child: Text(
            message,
            style: const TextStyle(
              fontSize: 24.0,
              color: CupertinoColors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    ),
  );
  Future.delayed(
    Duration(milliseconds: durationMillis),
    overlayEntry.remove,
  );
  Overlay.of(Navigator.of(context).context).insert(overlayEntry);
}
