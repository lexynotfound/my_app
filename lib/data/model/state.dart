abstract class StateFetcher {}

class Initital extends StateFetcher {}

class Loading extends StateFetcher {}

class Loaded<T> {
  final T data;

  Loaded({required this.data});
}

class Error extends StateFetcher {
  final String error;

  Error({required this.error});
}
