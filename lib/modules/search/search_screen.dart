import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';

class SearchScreen extends StatelessWidget {
  var search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (BuildContext context, NewsStates state) {  },
      builder: (BuildContext context, NewsStates state) {
        var cubit = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: search,
                  keyboardType: TextInputType.text,
                  validator: (value){
                    if(value!.isEmpty){
                      return 'search must not be empty';
                    }
                    return null;
                  },
                  onChanged: (value){
                    NewsCubit.get(context).getSearch(value);
                  },
                  decoration: InputDecoration(
                    label: const Text('Search',style: TextStyle(color: Colors.deepOrange),),
                    prefixIcon: const Icon(Icons.search,color: Colors.deepOrange,),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.deepOrange,width: 2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              Expanded(child: articaleBuilder(cubit, context, isSearch: true))
            ],
          ),
        );
      },
    );
  }
}
