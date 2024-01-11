import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/business/business_screen.dart';
import 'package:news_app/modules/health/health_screen.dart';
import 'package:news_app/modules/sciences/sciences_screen.dart';
import 'package:news_app/modules/sports/sports_screen.dart';
import 'package:news_app/modules/technology/technology_screen.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates>
{
  NewsCubit() : super (NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(
      label: 'رياضة',
      icon: Icon(Icons.sports),
    ),
    const BottomNavigationBarItem(
      label: 'تكنولوجيا',
      icon: Icon(Icons.phone_android_outlined),
    ),
    const BottomNavigationBarItem(
      label: 'بزنس',
        icon: Icon(Icons.business_rounded),
    ),
    const BottomNavigationBarItem(
      label: 'الصحة',
        icon: Icon(Icons.directions_run_outlined),
    ),
    const BottomNavigationBarItem(
      label: 'علوم',
        icon: Icon(Icons.science_outlined),
    ),
  ];
  List<Widget> screens = [
    const SportsScreen(),
    const TechnologyScreen(),
    const BusinessScreen(),
    const HealthScreen(),
    const SciencesScreen(),
  ];

  List<dynamic> sports = [];
  void getSports(){
    emit(NewsGetSportsLoadingState());

    DioHelper.getData(
        url: 'https://gnews.io/api/v4/top-headlines',
        query: {
          'country':'eg',
          'category':'sports',
          'apikey':'919bb662138a2e739785bb075fed2bbd',
        },
    ).then((value){

      sports = value.data['articles'];

        emit(getSportsSCState());
    }).catchError((error){

      print(error.toString());
      emit(getSportsERState(error.toString()));

    });
  }

  List<dynamic> technology = [];
  void getTechnology() {
    emit(NewsGetTechnologyLoadingState());
    if (technology.isEmpty) {
      DioHelper.getData(
        url: 'https://gnews.io/api/v4/top-headlines',
        query: {
          'country': 'eg',
          'category': 'technology',
          'apikey':'919bb662138a2e739785bb075fed2bbd',
        },
      ).then((value) {
        technology = value.data['articles'];

        emit(getTechnologySCState());
      }).catchError((error) {
        print(error.toString());
        emit(getTechnologyERState(error.toString()));
      });
    } else {
      emit(getTechnologySCState());
    }
  }



  List<dynamic> business = [];
  void getBusiness() {
    emit(NewsGetBusinessLoadingState());
    if (business.isEmpty) {
      DioHelper.getData(
        url: 'https://gnews.io/api/v4/top-headlines',
        query: {
          'country': 'eg',
          'category': 'business',
          'apikey':'919bb662138a2e739785bb075fed2bbd',
        },
      ).then((value) {
        business = value.data['articles'];

        emit(getBusinessSCState());
      }).catchError((error) {
        print(error.toString());
        emit(getBusinessERState(error.toString()));
      });
    } else {
      emit(getBusinessSCState());
    }
  }


  List<dynamic> health = [];
  void getHealth() {
    emit(NewsGetHealthLoadingState());
    if (health.isEmpty) {
      DioHelper.getData(
        url: 'https://gnews.io/api/v4/top-headlines',
        query: {
          'country': 'eg',
          'category': 'health',
          'apikey':'919bb662138a2e739785bb075fed2bbd',
        },
      ).then((value) {
        health = value.data['articles'];

        emit(getHealthSCState());
      }).catchError((error) {
        print(error.toString());
        emit(getHealthERState(error.toString()));
      });
    } else {
      emit(getHealthSCState());
    }
  }

  List<dynamic> sciences = [];
  void getSciences() {
    emit(NewsGetSciencesLoadingState());
    if (sciences.isEmpty) {
      DioHelper.getData(
        url: 'https://gnews.io/api/v4/top-headlines',
        query: {
          'country': 'eg',
          'category': 'science',
          'apikey':'919bb662138a2e739785bb075fed2bbd',
        },
      ).then((value) {
        sciences = value.data['articles'];

        emit(getSciencesSCState());
      }).catchError((error) {
        print(error.toString());
        emit(getSciencesERState(error.toString()));
      });
    } else {
      emit(getSciencesSCState());
    }
  }

  List<dynamic> search = [];
  void getSearch(String value) {

    emit(NewsSearchLoadingState());

    DioHelper.getData(
      url: 'https://gnews.io/api/v4/search',
      query: {
        'q': '$value',
        'apikey':'919bb662138a2e739785bb075fed2bbd',
      },
    ).then((value) {
      search = value.data['articles'];

      emit(getSearchSCState());
    }).catchError((error) {
      print(error.toString());
      emit(getSearchERState(error.toString()));
    });
  }


  void changeBVB (int index){
    currentIndex = index;
    if(index==1) {
      getTechnology();
    }
    if(index==2) {
      getBusiness();
    }
    if(index==3) {
      getHealth();
    }
    if(index==4) {
      getSciences();
    }
    emit(NewsBNBState());
  }
}