
import 'package:buzz_app/layout/home_provider/home_bloc.dart';
import 'package:buzz_app/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScienceScreen extends StatelessWidget {
  const ScienceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
        builder: (context,provider, state) {
          var list = Provider.of<HomeProvider>(context).Science;
          return Scaffold(
            body: buildListOfNews(list,context),
          );
        },
    );
  }
}
