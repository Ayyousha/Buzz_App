
import 'package:buzz_app/layout/home_screen.dart';
import 'package:buzz_app/shared/bloc/shared_bloc.dart';
import 'package:buzz_app/shared/components/components.dart';
import 'package:buzz_app/shared/network/local/cach_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class boardingInfo
{
 final String image;
   final String title;
     final String body;


 boardingInfo({
     required this.image,
        required this.title,
          required this.body,
    });

}

class OnBoardingScreen extends StatefulWidget {


  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {



 var boardingController = PageController();
 bool isLast = false;
 bool isFirst = false;

 void onSubmit()
 {
   CacheHelper.saveData(key: 'onBoarding', value: true).then((value)
   {
     Navigator.of(context).pushAndRemoveUntil(
       CustomPageRoute(
         child : HomeLayout(),
         direction: AxisDirection.left,
       ),
           (Route<dynamic> route) => false,
     );
   });
 }


  @override
  Widget build(BuildContext context) {
   return Consumer<SharedCubit>(
       builder: (context,cubit,state) {
        String ThemeImage;
        if(cubit.isDark)
        {
          ThemeImage = "assets/images/start1.png";
        } else
          {
            ThemeImage = "assets/images/start2.png";
          }
         return Scaffold(
           body: SafeArea(
             child: Container(
               decoration: BoxDecoration(
                 image: DecorationImage(
                   image: AssetImage(ThemeImage),
                   fit: BoxFit.fill,
                 ),
               ),
               child: Column(
                 children: [
                   heightSizedBox(15),
                   Padding(
                     padding: const EdgeInsets.only(left: 10, right: 10),
                     child: Container(
                       width: double.infinity,
                       alignment: Alignment.topLeft,
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(30),
                         gradient: LinearGradient(
                           colors: [Colors.red.withOpacity(0.9),Colors.red.withOpacity(0.5)],
                         ),
                       ),
                       child: Padding(
                         padding: const EdgeInsets.symmetric(horizontal: 10),
                         child: Row(
                           children: [
                             if(!isFirst)
                               IconButton(
                                 onPressed: ()
                                 {
                                   boardingController.previousPage(
                                     duration: Duration(
                                       milliseconds: 1000,
                                     ),
                                     curve: Curves.ease,
                                   );
                                 },
                                 icon: Icon(
                                   Icons.arrow_back_outlined,
                                   // Icons.arrow_back_ios_outlined,
                                   color: Colors.white,
                                   semanticLabel: 'Last',
                                 ),
                                 splashRadius: 25,
                                 splashColor: Colors.grey[200],
                                 highlightColor: Colors.grey[200],
                               ),
                             Spacer(),
                             if(!isLast)
                               IconButton(
                                 onPressed: ()
                                 {
                                   boardingController.nextPage(
                                     duration: Duration(
                                       milliseconds: 1000,
                                     ),
                                     curve: Curves.ease,
                                   );
                                 },
                                 icon: Icon(
                                   Icons.arrow_forward_outlined,
                                   // Icons.arrow_forward_ios_outlined,
                                   color: Colors.white,
                                   semanticLabel: 'Next',
                                 ),
                                 splashRadius: 25,
                                 splashColor: Colors.grey[200],
                                 highlightColor: Colors.grey[200],
                               ),
                           ],
                         ),
                       ),
                     ),
                   ),
                   heightSizedBox(15),
                   _buildPageView(),
                   _buildContainerBox(),
                   heightSizedBox(30),
                 ],
               ),
             ),
           ),
         );
       },
   );
  }

  /// App Bar
 PreferredSizeWidget _buildAppBar()=> AppBar(
   toolbarHeight: 50,
   leading: Row(
     mainAxisAlignment: MainAxisAlignment.center,
     children: [
       if(!isFirst)
         IconButton(
           onPressed: ()
           {
             boardingController.previousPage(
               duration: Duration(
                 milliseconds: 1000,
               ),
               curve: Curves.ease,
             );
           },
           icon: Icon(
             Icons.arrow_back_outlined,
             // Icons.arrow_back_ios_outlined,
             color: Colors.grey,
             semanticLabel: 'Last',
           ),
           splashRadius: 25,
           splashColor: Colors.grey[200],
           highlightColor: Colors.grey[200],
         ),
     ],
   ),
   actions: [

   ],
 );

 /// Page View
 Widget _buildPageView()=> Expanded(
   child: PageView.builder(
     controller: boardingController,
     itemBuilder: (context, index) => _buildPageViewDetails(boarding[index],context),
     itemCount: boarding.length,
     onPageChanged: (int index) {
       if(index == boarding.length - 1) {
         setState(() {
           isLast = true;
         });
       } else {
         setState(() {
           isLast = false;
         });
       };
       if (index == boarding.length -3) {
         setState(() {
           isFirst = true;
         });
       } else {
         setState(() {
           isFirst = false;
         });
       };
     },
   ),
 );

 /// Page View Details
 Widget _buildPageViewDetails(boardingInfo model,context)=> Column(
   crossAxisAlignment: CrossAxisAlignment.center,
   children: [
     Padding(
       padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
       child: Container(
         clipBehavior: Clip.antiAliasWithSaveLayer,
         decoration: BoxDecoration(
           borderRadius: BorderRadius.circular(10)
         ),
         child: Image(
           image: NetworkImage('${model.image}'),

         ),
       ),
     ),
     SizedBox(height: 20,),
     Text(
       model.title,
         style: Theme.of(context).textTheme.headline1!.copyWith(
             fontWeight: FontWeight.w900,
         ),
     ),
     SizedBox(height: 15,),
     Padding(
       padding: const EdgeInsets.symmetric(horizontal: 40),
       child: Text(
         model.body,
         textAlign: TextAlign.center,
         style: Theme.of(context).textTheme.bodyText1!.copyWith(
           color: Colors.grey[400],
           // height: 1.2
         ),
       ),
     ),
   ],
 );

 /// Container box
 Widget _buildContainerBox()=> Padding(
   padding: const EdgeInsets.only(left: 10, right: 10),
   child: Container(
     width: double.infinity,
     alignment: Alignment.topLeft,
     decoration: BoxDecoration(
       borderRadius: BorderRadius.circular(30),
       gradient: LinearGradient(
         colors: [Colors.red.withOpacity(0.9),Colors.red.withOpacity(0.5)],
       ),
     ),
     child: _buildButtonAndSmoothPageIndicator(),
   ),
 );

 /// Skip & Let's Starting Button and Smooth Page Indicator
 Widget _buildButtonAndSmoothPageIndicator()=> Center(
   child: Padding(
     padding: const EdgeInsets.symmetric(horizontal: 20),
     child: Row(
         mainAxisAlignment: MainAxisAlignment.center,
       children: [
         if(isLast == false)
         Expanded(
           child: SmoothPageIndicator(
             controller: boardingController,
             count: boarding.length,
             effect: ExpandingDotsEffect(
               spacing: 10,
               dotHeight: 10,
               dotWidth: 10,
               activeDotColor: Colors.white,
               dotColor: Colors.grey[300]!,
             ),
           ),
         ),
         if(isLast == false)
           TextButton(
             onPressed: onSubmit,
             child: Text(
               'SKIP',
               style: Theme.of(context).textTheme.bodyText1!.copyWith(
                 color: Colors.white
               ),
             ),
           ),
         if(isLast)
           TextButton(
             onPressed: onSubmit,
             child: Text(
               'Let\'s Starting',
               style: Theme.of(context).textTheme.bodyText1!.copyWith(
                 color: Colors.white,
               ),
             ),
           ),
       ],
     ),
   ),
 );


 /// Screen Models
 List<boardingInfo> boarding = [
   boardingInfo(
     image: 'https://image.freepik.com/free-vector/news-concept-landing-page_52683-18598.jpg',
     title: 'Daily News',
     body: 'Lorem ipsum dolor sit amet elit consectetur adipiscing, tempus nostra lacinia adipiscing.',
   ),
   boardingInfo(
     image: 'https://image.freepik.com/free-vector/news-concept-landing-page_52683-20707.jpg',
     title: 'Hot News',
     body: 'Lorem ipsum dolor sit amet consectetur adipiscing, tempus nostra lacinia adipiscing, tempus nostra lacinia nostra lacinia.',
   ),
   boardingInfo(
     image: 'https://image.freepik.com/free-vector/news-concept-landing-page_52683-20706.jpg',
     title: 'World News',
     body: 'Lorem ipsum dolor sit amet elit consectetur adipiscing, tempus nostra lacinia adipiscing, tempus nostra lacinia nostra lacinia.',
   ),
 ];

}




