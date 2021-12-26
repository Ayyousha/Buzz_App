

import 'package:buzz_app/layout/home_provider/home_bloc.dart';
import 'package:buzz_app/modules/search/search_screen.dart';

import 'package:buzz_app/shared/bloc/shared_bloc.dart';
import 'package:buzz_app/shared/components/components.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';


class HomeLayout extends StatelessWidget {
   HomeLayout({Key? key}) : super(key: key);

  final scaffoldKey = GlobalKey<ScaffoldState>();



  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(

        builder: (context,cubit, state) {
          var sharedCubit = Provider.of<SharedCubit>(context);
          String ThemeImage;
          if(sharedCubit.isDark)
          {
            ThemeImage = "assets/images/start1.png";
          } else
          {
            ThemeImage = "assets/images/start2.png";
          }

          // if(Provider.of<HomeCubit>(context).container == null )
          // {
          //   Provider.of<HomeCubit>(context).currentIndex = DrawerSections.newNews;
          // }
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.red[800],
              actions: [
                IconButton(
                    onPressed: ()
                    {
                      Navigator.of(context).push(
                        CustomPageRoute(
                          child : SearchScreen(),
                          direction: AxisDirection.left,
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                ),
              ],
              leading: IconButton(
                onPressed: ()  {
                return  scaffoldKey.currentState!.openDrawer();
                },
                icon: const Icon(
                  Icons.list,
                  color: Colors.white,
                ),
              ),
              centerTitle: true,
              title: cubit.title ,
            ),
            drawer: Drawer(
              backgroundColor: Theme.of(context).backgroundColor,
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader (
                    padding: EdgeInsets.zero,
                    margin: EdgeInsetsDirectional.zero,
                    decoration:  BoxDecoration(
                      color: Colors.redAccent,
                      image: DecorationImage(
                          image: AssetImage(ThemeImage),
                          fit: BoxFit.fitWidth
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 0),
                      child: Container(
                        color: Colors.black.withOpacity(0.3),
                        child: const Center(
                          child: Text(
                            'Buzz News',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Material(
                    color: cubit.currentIndex == DrawerSections.newNews ? Colors.red[700] : Colors.transparent,
                    child: ListTile(
                      // iconColor: Colors.white,
                      // textColor: Colors.white,
                      leading:  Icon(Icons.fiber_new_outlined,
                        color: Theme.of(context).dividerColor,),
                      onTap: ()
                      {
                        Navigator.pop(context);
                        cubit.changeScreen(DrawerSections.newNews);

                        // cubit.currentIndex == DrawerSections.newNews;
                      },
                      title: const Text('Home'),
                    ),
                  ),
                  Material(
                    color: cubit.currentIndex == DrawerSections.business ? Colors.red[900] : Colors.transparent,
                    child: ListTile(
                      // iconColor: Colors.white,
                      // textColor: Colors.white,
                      leading:  Icon(Icons.business_center_outlined,
                        color: Theme.of(context).dividerColor,),
                      onTap: ()
                      {
                        Navigator.pop(context);
                        cubit.changeScreen(DrawerSections.business);

                      },
                      title: const Text('Business'),
                    ),
                  ),
                  Material(
                    color: cubit.currentIndex == DrawerSections.sports ? Colors.red[900] : Colors.transparent,
                    child: ListTile(
                      // iconColor: Colors.white,
                      // textColor: Colors.white,
                      leading:  Icon(Icons.sports_soccer,
                        color: Theme.of(context).dividerColor,),
                      onTap: ()
                      {
                        Navigator.pop(context);
                        cubit.changeScreen(DrawerSections.sports);
                      },
                      title: const Text('Sports'),
                    ),
                  ),
                  Material(
                    color: cubit.currentIndex == DrawerSections.science ? Colors.red[900] : Colors.transparent,
                    child: ListTile(
                      // iconColor: Colors.white,
                      // textColor: Colors.white,
                      leading:  Icon(Icons.science_outlined,
                        color: Theme.of(context).dividerColor,),
                      onTap: ()
                      {
                        Navigator.pop(context);
                        cubit.changeScreen(DrawerSections.science);
                      },
                      title: const Text('Science'),
                    ),
                  ),
                  ListTile(
                    // iconColor: Colors.white,
                    // textColor: Colors.white,
                    leading:  Icon(
                        Icons.nightlight_round,
                      color: Theme.of(context).dividerColor,
                    ),
                    onTap: ()
                    {},
                    title: const Text('Dark Mode'),
                    trailing: Switch(
                      activeColor: Colors.red[900],
                      value:sharedCubit.isDark,
                      onChanged: (value) {
                        sharedCubit.changeThemeMode();
                      },
                    ),
                  ),
                ],
              ),
            ),
            body: cubit.container,
          );
        },
    );
  }
}
