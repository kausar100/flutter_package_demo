import 'package:cookbook_flutter/ios-app-cupertino/product_row_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'app_state_model.dart';

class ProductListTab extends StatelessWidget {
  const ProductListTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateModel>(
      builder: (context, model, child) {
        final products = model.getProducts(); // NEW
        return CustomScrollView(
          // MODIFY
          semanticChildCount: products.length, // NEW
          slivers: <Widget>[
            const CupertinoSliverNavigationBar(
              // MODIFY
              largeTitle: Text('Cupertino Store'),
            ),
            SliverSafeArea(
              // ADD from here...
              top: false,
              minimum: const EdgeInsets.only(top: 0),
              sliver: SliverToBoxAdapter(
                child: CupertinoListSection(
                  topMargin: 0,
                  children: [
                    for (var product in products)
                      ProductRowItem(
                        product: product,
                      )
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
