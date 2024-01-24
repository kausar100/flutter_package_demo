import 'package:cookbook_flutter/ios-app-cupertino/product_row_item.dart';
import 'package:cookbook_flutter/ios-app-cupertino/search_bar_widget.dart';
import 'package:cookbook_flutter/ios-app-cupertino/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'app_state_model.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({super.key});

  @override
  State<SearchTab> createState() {
    return _SearchTabState();
  }
}

class _SearchTabState extends State<SearchTab> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  String _terms = '';

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController()..addListener(_onTextChanged);
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {
      _terms = _controller.text;
    });
  }

  Widget _buildSearchBox() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SearchBar(
        controller: _controller,
        focusNode: _focusNode,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<AppStateModel>(context);
    final results = model.search(_terms);

    return DecoratedBox(
      decoration: const BoxDecoration(
        color: Styles.scaffoldBackground,
      ),
      child: SafeArea(
        child: Column(
          children: [
            _buildSearchBox(),
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child: results.isNotEmpty
                      ? CupertinoListSection(
                          topMargin: 0,
                          children: [
                            for (var product in results)
                              ProductRowItem(
                                product: product,
                              )
                          ],
                        )
                      : const Center(
                          child: Text("Not found any product!"),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
