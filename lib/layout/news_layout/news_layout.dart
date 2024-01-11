import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/search/search_screen.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/mode_cubit.dart';
import 'package:news_app/shared/cubit/states.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NewsCubit.get(context);
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                navigatTo(context, SearchScreen());
              },
              icon: const Icon(
                Icons.search,
                color: Colors.deepOrange,
              ),
            ),
            centerTitle: true,
            title: Text('أخبار اليوم',
                style: Theme.of(context).textTheme.titleLarge),
            actions: [
              IconButton(
                icon: Icon(
                  ModeCubit.get(context).isDark ? Icons.dark_mode : Icons.dark_mode_outlined,
                ),
                onPressed: ()
                {
                  ModeCubit.get(context).changeAppMode(fromShared: null);
                },
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBVB(index);
            },
            items: cubit.bottomItems,
          ),
        );
      },
    );
  }
}

