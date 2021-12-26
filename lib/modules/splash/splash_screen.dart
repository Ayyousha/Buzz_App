
import 'package:buzz_app/layout/home_screen.dart';
import 'package:buzz_app/modules/onboarding/onboarding_screen.dart';
import 'package:buzz_app/shared/bloc/shared_bloc.dart';
import 'package:buzz_app/shared/components/components.dart';
import 'package:buzz_app/shared/network/local/cach_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}


class _State extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async
  {
    bool onBoarding = CacheHelper.getData(key: 'onBoarding');

    await Future.delayed(Duration(milliseconds: 3000));
    if(onBoarding != null)
    {
      NavigateAndFinish(context, HomeLayout());
    } else
      {
        NavigateAndFinish(context, OnBoardingScreen());
      }
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<SharedCubit>(
      builder: (context,cubit,state)
      {
        String ThemeImage;
        if(cubit.isDark)
        {
          ThemeImage = "assets/images/start1.png";
        } else
        {
          ThemeImage = "assets/images/start2.png";
        }
        return Scaffold(
          body: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(ThemeImage),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    'Buzz News',
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                      fontSize: 40,
                      color: Colors.red,
                    ),
                  ),
                ),
                heightSizedBox(10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    'Buzz News is a personalized news aggregator that organizes and highlights what’s happening in the world.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText1!,
                  ),
                ),
                // heightSizedBox(40),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 10),
                //   child: Container(
                //     height: 50,
                //     width: double.infinity,
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(10),
                //       gradient: LinearGradient(colors: [
                //         Colors.red.withOpacity(0.9),
                //         Colors.red.withOpacity(0.5)
                //       ]),
                //       color: Colors.white,
                //     ),
                //     child: MaterialButton(
                //       child: Text(
                //           'Log in',
                //           style: Theme.of(context).textTheme.bodyText1
                //       ),
                //       onPressed: ()
                //       {
                //         // Navigator.of(context).push(
                //         //   CustomPageRoute(
                //         //     child : LoginScreen(),
                //         //     direction: AxisDirection.left,
                //         //   ),
                //         // );
                //       },
                //     ),
                //   ),
                // ),
                // heightSizedBox(10),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 10),
                //   child: Container(
                //     height: 50,
                //     width: double.infinity,
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(10),
                //       border: Border.all(
                //         color: Theme.of(context).buttonColor,
                //         width: 1,
                //       ),
                //     ),
                //     child: MaterialButton(
                //       child: Text(
                //         'Sign up',
                //       ),
                //       onPressed: ()
                //       {
                //         // Navigator.of(context).push(
                //         //   CustomPageRoute(
                //         //     child : RegisterScreen(),
                //         //     direction: AxisDirection.left,
                //         //   ),
                //         // );
                //       },
                //     ),
                //   ),
                // ),
                // heightSizedBox(15),
              ],
            ),
          ),
        );
      },
    );
  }
}
