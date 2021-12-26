
import 'package:buzz_app/layout/home_provider/home_bloc.dart';
import 'package:buzz_app/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SportsScreen extends StatelessWidget {
  const SportsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
        builder: (context,provider, state) {
          var list = Provider.of<HomeProvider>(context).Sports;
          return Scaffold(
            body: buildListOfNews(list,context),
          );
        },
    );
  }


}
