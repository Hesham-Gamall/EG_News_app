abstract class NewsStates {}

class NewsInitialState extends NewsStates {}

class NewsBNBState extends NewsStates {}

class NewsGetSportsLoadingState extends NewsStates {}
class getSportsSCState implements NewsStates {}
class getSportsERState extends NewsStates {
  late final String error;
  getSportsERState(this.error);
}

class NewsGetTechnologyLoadingState extends NewsStates {}
class getTechnologySCState extends NewsStates {}
class getTechnologyERState extends NewsStates {
  late final String error;
  getTechnologyERState(this.error);
}

class NewsGetBusinessLoadingState extends NewsStates {}
class getBusinessSCState extends NewsStates {}
class getBusinessERState extends NewsStates {
  late final String error;
  getBusinessERState(this.error);
}

class NewsGetHealthLoadingState extends NewsStates {}
class getHealthSCState extends NewsStates {}
class getHealthERState extends NewsStates {
  late final String error;
  getHealthERState(this.error);
}

class NewsGetSciencesLoadingState extends NewsStates {}
class getSciencesSCState extends NewsStates {}
class getSciencesERState extends NewsStates {
  late final String error;
  getSciencesERState(this.error);
}

class NewsSearchLoadingState extends NewsStates {}
class getSearchSCState extends NewsStates {}
class getSearchERState extends NewsStates {
  late final String error;
  getSearchERState(this.error);
}