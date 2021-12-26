
import 'package:buzz_app/modules/business/business_screen.dart';
import 'package:buzz_app/modules/new_news/new_news_screen.dart';
import 'package:buzz_app/modules/science/science_screen.dart';
import 'package:buzz_app/modules/sports/sports_screen.dart';
import 'package:buzz_app/shared/components/constance.dart';
import 'package:buzz_app/shared/network/remote/dio_helper.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


enum DrawerSections {
  newNews,
  business,
  sports,
  science,
}


class HomeProvider extends ChangeNotifier {



      var currentIndex = DrawerSections.newNews ;
      var container ;
      var title;


      void changeScreen(index)
      {
        currentIndex = index;
        if (currentIndex == DrawerSections.newNews) {
          container = NewNewsScreen();
          title = RichText(
            text: TextSpan(
                children: [
                  TextSpan(
                      text: 'Buzz',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            offset: Offset(2,1.5),
                            color: Colors.grey[900]!,
                          ),
                        ],
                      )
                  ),
                  TextSpan(
                      text: ' News',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            offset: Offset(2,1.5),
                            color: Colors.grey[900]!,
                          ),
                        ],
                      )
                  ),
                ]
            ),
          );
        } else if (currentIndex == DrawerSections.business) {
          container = BusinessScreen();
          title = RichText(
            text: TextSpan(
                children: [
                  TextSpan(
                      text: 'Business',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            offset: Offset(2,1.5),
                            color: Colors.grey[900]!,
                          ),
                        ],
                      )
                  ),
                  TextSpan(
                      text: ' News',
                      style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            shadows: [
                                  Shadow(
                                        offset: Offset(2,1.5),
                                        color: Colors.grey[900]!,
                                  ),
                            ],
                      )
                  ),
                ]
            ),
          );
        } else if (currentIndex == DrawerSections.sports) {
          container = SportsScreen();
          title = RichText(
                  text: TextSpan(
                      children: [
                            TextSpan(
                                text: 'Sports',
                                style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      shadows: [
                                            Shadow(
                                                  offset: Offset(2,1.5),
                                                  color: Colors.grey[900]!,
                                            ),
                                      ],
                                )
                            ),
                            TextSpan(
                                text: ' News',
                                style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      shadows: [
                                            Shadow(
                                                  offset: Offset(2,1.5),
                                                  color: Colors.grey[900]!,
                                            ),
                                      ],
                                )
                            ),
                      ]
                  ),
            );
        } else if (currentIndex == DrawerSections.science) {
          container = ScienceScreen();
          title = RichText(
                  text: TextSpan(
                      children: [
                            TextSpan(
                                text: 'Science',
                                style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      shadows: [
                                            Shadow(
                                                  offset: Offset(2,1.5),
                                                  color: Colors.grey[900]!,
                                            ),
                                      ],
                                )
                            ),
                            TextSpan(
                                text: ' News',
                                style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      shadows: [
                                            Shadow(
                                                  offset: Offset(2,1.5),
                                                  color: Colors.grey[900]!,
                                            ),
                                      ],
                                )
                            ),
                      ]
                  ),
            );
        }
          notifyListeners();
      }

      List<dynamic> NewNews = [];
      void getNewNews()
      {
        DioHelper.getData(
            url: "v2/top-headlines",
            query:
            {
              "country":"eg",
              "category":"technology",
              "apiKey": key,
            }
        ).then((value)
        {
          NewNews = value.data["articles"];
          // print(NewNews[0]["source"]["name"]);
          notifyListeners();
        }).catchError((error)
        {
          print('((((( you have an error in your data :: ${error
              .toString()} )))))');
          notifyListeners();
        });
      }

      List<dynamic> FutureNews = [];
      void getFutureNews()
      {
        DioHelper.getData(
            url: "v2/top-headlines",
            query:
            {
              "country":"eg",
              "category":"health",
              "apiKey": key,
            }
        ).then((value)
        {
          FutureNews = value.data["articles"];
          print(NewNews[0]["source"]["name"]);
          notifyListeners();
        }).catchError((error)
        {
          print('((((( you have an error in your data :: ${error
              .toString()} )))))');
          notifyListeners();
        });
      }

      List<dynamic> NewsImages = [];
      void getNewsImages()
      {
        DioHelper.getData(
            url: "v2/top-headlines",
            query:
            {
              "country":"eg",
              "category":"business",
              "apiKey": key,
            }
        ).then((value)
        {
          NewsImages = value.data["articles"];
          notifyListeners();
        }).catchError((error)
        {
          print('((((( you have an error in your data :: ${error
              .toString()} )))))');
          notifyListeners();
        });
      }

      List<dynamic> Business = [];
      void getBusiness()
      {
        DioHelper.getData(
            url: "v2/top-headlines",
            query:
            {
              "country":"eg",
              "category":"business",
              "apiKey": key,
            }
        ).then((value)
        {
          Business = value.data["articles"];
          // print(Business[0]["source"]["name"]);
          notifyListeners();
        }).catchError((error)
        {
          print('((((( you have an error in your data :: ${error
              .toString()} )))))');
          notifyListeners();
        });
      }

      List<dynamic> Sports = [];
      void getSports()
      {
        DioHelper.getData(
            url: "v2/top-headlines",
            query:
            {
              "country":"eg",
              "category":"sports",
              "apiKey": key,
            }
        ).then((value)
        {
          Sports = value.data["articles"];
          notifyListeners();
        }).catchError((error)
        {
          print('((((( you have an error in your data :: ${error
              .toString()} )))))');
          notifyListeners();
        });
      }


      List<dynamic> Science = [];
      void getScience()
      {
        DioHelper.getData(
            url: "v2/top-headlines",
            query:
            {
              "country":"eg",
              "category":"science",
              "apiKey": key,
            }
        ).then((value)
        {
          Science = value.data["articles"];
          notifyListeners();
        }).catchError((error)
        {
          print('((((( you have an error in your data :: ${error
              .toString()} )))))');
          notifyListeners();
        });
      }

      // News Search
      List<dynamic> Search = [];
      void getSearch(String value)
      {
        Search = [];
        DioHelper.getData(

          url: 'v2/everything',
          query:
          {
            'q':'$value',
            'apiKey': key,
          },
        ).then((value)
        {
          Search = value.data['articles'];
          notifyListeners();
        }).catchError((error){
          print('you have an error in your data :: ${error.toString()}');
          notifyListeners();
        });

      }
}