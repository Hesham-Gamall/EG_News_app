import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/cubit/mode_states.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';


class ModeCubit extends Cubit<ModeStates>
{
  ModeCubit() : super(AppInitialState());
  static ModeCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;


  bool isDark = true;
  void changeAppMode({bool? fromShared})
  {
    isDark = fromShared ?? !isDark;
    CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
      emit(AppChangeModeState());
    });
  }
}