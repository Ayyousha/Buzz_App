
import 'package:buzz_app/layout/home_provider/home_bloc.dart';
import 'package:buzz_app/modules/web_view/webview_screen.dart';
import 'package:buzz_app/shared/components/components.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';


class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context,cubit, state) {
         var list = Provider.of<HomeProvider>(context).Search;
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.red[800],

            leading: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: IconButton(
                onPressed: ()
                {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
              ),
            ),
            title: LimitedBox(maxHeight: 45, child: _buildTextField5(context)),
          ),
          body: Column(
            children: [
              Expanded(
                child: _buildListOfNews(list,context,isSearch: true),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTextField5(context) => TextFormField(
    decoration: InputDecoration(
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Theme.of(context).backgroundColor),
        borderRadius: BorderRadius.circular(10),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: Theme.of(context).backgroundColor,
        ),
      ),
      prefixIcon: Icon(
        Icons.search,
        color: Theme.of(context).dividerColor,
      ),
      hintText: "What are you searching about ?",
      hintStyle: TextStyle(
        color:  Theme.of(context).dividerColor,
        fontSize: 12,
      ),
      filled: true,
      fillColor: Theme.of(context).backgroundColor,
    ),
    controller: searchController,
    onChanged: (value)
    {
      Provider.of<HomeProvider>(context,listen: false).getSearch(value);
    },
    style: TextStyle(
      color: Theme.of(context).dividerColor,
    ),
  );

  Widget _buildListOfNews(list,context,{isSearch = false}) {
    return ConditionalBuilder(
      condition: list.length > 0,
      builder: (context) {
        return ListView.separated(
          padding: EdgeInsets.all(10),
          itemBuilder: (context, index) =>
              buildBusinessNews(context,list[index]),
          separatorBuilder: (context, index) => heightSizedBox(10),
          itemCount: list.length,
        );
      },
      fallback: (context) =>
      isSearch ? Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.search,
              size: 70,
              color: Colors.grey,
            ),
            Text(
              'No Search even,',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.grey,
              ),
            ),
            Text(
              'Search For Anythings',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ) : Center(child: CircularProgressIndicator()),
    );
  }

}

