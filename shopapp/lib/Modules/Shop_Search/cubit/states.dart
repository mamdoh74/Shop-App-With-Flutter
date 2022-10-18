abstract class SearchStates{}

class SearchInintialState extends SearchStates{}

class SearchLoadingState extends SearchStates{}
class SearchSuccessState extends SearchStates{}
class SearchErrorState extends SearchStates{
  String error;
  SearchErrorState(this.error);
}
