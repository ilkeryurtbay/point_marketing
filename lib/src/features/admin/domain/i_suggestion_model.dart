///The models that will be used for suggestion dropdown should have a name property and a fromJson method\n
///to make sure of it they have to implement this interface
abstract class ISuggestionModel {
  String? get name;
}
