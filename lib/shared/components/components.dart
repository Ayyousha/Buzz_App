import 'package:buzz_app/layout/home_provider/home_bloc.dart';
import 'package:buzz_app/modules/web_view/webview_screen.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Navigate to another Screen
void NavigateTo(context, Widget) => Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => Widget),
);

/// Navigate To Anther Screen and doesn't Back
void NavigateAndFinish(context, Widget) => Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(builder: (context) => Widget),
      (Route<dynamic> route) => false,
);



/// SizedBox
Widget heightSizedBox(double height) => SizedBox(height: height);
Widget widthSizedBox(double width) => SizedBox(width: width);


/// Custom Page Route
class CustomPageRoute extends PageRouteBuilder{
  final Widget child;
  final AxisDirection direction;

  CustomPageRoute({
    required this.child,
    this.direction = AxisDirection.right,
  }) : super (
      transitionDuration: Duration(milliseconds: 750),
      reverseTransitionDuration: Duration(milliseconds: 750),
      pageBuilder:(context,animation , secondaryAnimation) => child );

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation , Widget child) =>
      SlideTransition(
        position: Tween<Offset>(
          begin: getBeginOffset(),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      );

  Offset getBeginOffset()
  {
    switch (direction){
      case AxisDirection.down:
        return Offset(0, 1);
      case AxisDirection.up:
        return Offset(0, -1);
      case AxisDirection.left:
        return Offset(-1, 0);
      case AxisDirection.right:
        return Offset(1, 0);
    }
  }
}


Widget buildListOfNews(list,context)
{
  return Center(
    child: SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
        child: Column(
          children: [
            heightSizedBox(5),
            ConditionalBuilder(
              condition: list.length > 0,
              builder: (context) {
                return ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: list.length,
                  itemBuilder: (context, index) =>
                      buildBusinessNews(context,list[index]),
                  separatorBuilder: (context, index) => heightSizedBox(10),
                );
              },
              fallback: (context) => Center(
                child: CircularProgressIndicator(
                  color: Colors.red[900],
                ),
              ),
            ),
            heightSizedBox(5),

          ],
        ),
      ),
    ),
  );
}


Widget buildBusinessNews(context,list) {
  return Container(
    color: Theme.of(context).backgroundColor,
    height: 150,
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: ()
        {
          Navigator.of(context).push(
            CustomPageRoute(
              child : WebViewScreen(list["url"],list["source"]["name"]),
              direction: AxisDirection.left,
            ),
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: double.infinity,
              width: 150,
              child: Ink.image(
                image:  NetworkImage('${list["urlToImage"]}'),
                fit: BoxFit.fill,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                      child: Text(
                        '${list["title"]}',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headline3!.copyWith(
                            fontSize: 18
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${list["publishedAt"]}',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.headline3!.copyWith(
                              color: Colors.grey,
                              fontSize: 14
                          ),
                        ),
                        Text(
                          "| ${list["source"]["name"]}",
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.headline3!.copyWith(
                              color: Colors.red,
                              fontSize: 14
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}