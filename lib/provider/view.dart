import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider.dart';

class KeyValueStorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => KeyValueStoreProvider(),
      builder: (context, child) => _buildPage(context),
    );
  }

  Widget _buildPage(BuildContext context) {
    final provider = context.read<KeyValueStoreProvider>();

    return Container();
  }
}

