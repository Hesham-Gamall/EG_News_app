import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:news_app/modules/web_view/web_view_screen.dart';

Widget buildArticleItem(ar, context) => InkWell(
  onTap: (){
    navigatTo(context, WebViewScreen(ar['url']));
  },
  child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              width: 150,
              height: 120,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    '${ar['image']}',
                  ),
                ),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: SizedBox(
                height: 120,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '${ar['title']}',
                        maxLines: 3,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    Text(
                      '${ar['publishedAt']}',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
);

Widget articaleBuilder(cubit, context, {isSearch = false}) => ConditionalBuilder(
      condition: cubit.length > 0,
      builder: (context) => ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) =>
            buildArticleItem(cubit[index], context),
        separatorBuilder: (context, index) => const SizedBox(
          width: 5,
        ),
        itemCount: 10,
      ),
      fallback: (context) => isSearch ? Container() :  Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>
              (Theme.of(context).hintColor),
        color: Colors.deepOrange,
      )),
    );

void navigatTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(
      builder: (context) => widget
  )
);
