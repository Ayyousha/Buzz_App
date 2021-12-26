
import 'package:buzz_app/layout/home_provider/home_bloc.dart';
import 'package:buzz_app/modules/web_view/webview_screen.dart';
import 'package:buzz_app/shared/components/components.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewNewsScreen extends StatelessWidget {
  const NewNewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
        builder: (context,cubit, state) {
          var newNews = Provider.of<HomeProvider>(context).NewNews;
          var list = Provider.of<HomeProvider>(context).FutureNews;
          var newsImages = Provider.of<HomeProvider>(context).NewsImages;
          return Scaffold(
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                child: Column(
                  children: [
                    ConditionalBuilder(
                      condition: newNews.length > 0,
                      builder: (context) {
                        return _buildNewNews(context,newNews);
                      },
                      fallback: (context) => Container(
                        height: 300,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Colors.red[900],
                          ),
                        ),
                      ),
                    ),
                    heightSizedBox(5),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 3),
                          child: Text(
                            "Future & Analysis ",
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.headline3!.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 18
                            ),
                          ),
                        ),
                      ],
                    ),
                    heightSizedBox(5),
                    ConditionalBuilder(
                      condition: list.length > 0 ,
                      builder: (context) {
                        return ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: 5,
                          itemBuilder: (context, index) =>
                              buildBusinessNews(context,list[index]),
                          separatorBuilder: (context, index) => heightSizedBox(10),
                        );
                      },
                      fallback: (context) => Container(
                        height: 150,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Colors.red[900],
                          ),
                        ),
                      ),
                    ),
                    heightSizedBox(5),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 3),
                          child: Text(
                            "In Pictures ",
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.headline3!.copyWith(
                                fontSize: 18
                            ),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 20,
                          color: Colors.red[900],
                        ),
                      ],
                    ),
                    heightSizedBox(5),
                    ConditionalBuilder(
                      condition: newsImages.length > 0,
                      builder: (context) {
                        return ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: 5,
                          itemBuilder: (context, index) => _buildNewsImages(context,newsImages[index]),
                          separatorBuilder: (context, index) => heightSizedBox(10),
                        );
                      },
                      fallback: (context) => Container(
                        height: 200,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Colors.red[900],
                          ),
                        ),
                      ),
                    ),
                    heightSizedBox(10),
                  ],
                ),
              ),
            ),
          );
        },
    );
  }

  Widget _buildNewNews(context,newNews) {
    return Container(
      height: 300,
      color: Theme.of(context).backgroundColor,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: ()
          {
            Navigator.of(context).push(
              CustomPageRoute(
                child : WebViewScreen(
                    newNews[0]["url"],
                    newNews[0]["source"]["name"]
                ),
                direction: AxisDirection.left,
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                width: double.infinity,
                child: Ink.image(
                    image: NetworkImage(newNews[0]["urlToImage"]),
                    fit: BoxFit.cover
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                  child: Text(
                    newNews[0]["title"],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                        fontSize: 18
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                    child: Text(
                      newNews[0]["publishedAt"],
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                          color: Colors.grey,
                          fontSize: 14
                      ),
                    ),
                  ),
                  Text(
                    "|  ${newNews[0]["source"]["name"]}",
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                        color: Colors.red,
                        fontSize: 14
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNewsImages(context,newsImages) {
    return Container(
      color: Theme.of(context).backgroundColor,
      height: 200,
      child: Material(
       color: Colors.transparent,
        child: InkWell(
          onTap: ()
          {
            Navigator.of(context).push(
              CustomPageRoute(
                child : WebViewScreen(newsImages["url"],newsImages["source"]["name"]),
                direction: AxisDirection.left,
              ),
            );
          },
          child: Column(
            children: [
              Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Container(
                    height: 200,
                    width: double.infinity,
                  child: Ink.image(
                  image:  NetworkImage('${newsImages["urlToImage"]}'),
                  fit: BoxFit.cover,
                ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          color: Colors.black.withOpacity(0.4),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 3,right: 3,top: 3),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.camera_alt_outlined,
                                  size: 15,
                                ),
                                Text(
                                  " In Pictures ",
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.headline3!.copyWith(
                                      color: Colors.white,
                                      fontSize: 13
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5,left: 10,right: 5),
                        child: Container(
                          color: Colors.black.withOpacity(0.4),
                          child: Text(
                            " ${newsImages["title"]} ",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: Theme.of(context).textTheme.headline3!.copyWith(
                                color: Colors.white,
                                fontSize: 16
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}
