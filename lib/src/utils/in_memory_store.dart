import 'package:rxdart/rxdart.dart';

/// An in-memory store backed bu BehaviorSubject that can be used to 
/// store the data for all repositories in the app 

class InMemoryStore<T> {
  InMemoryStore(T initial) : _subject = BehaviorSubject<T>.seeded(initial);
  ///The Behavior subject that holds the data 
  final BehaviorSubject<T> _subject;
  

  /// The output stream that can used to listen to the data
  Stream<T> get stream => _subject.stream;

  /// Asynchronous getter for the current value
  T get value => _subject.value;
  /// A setter for updating the value  
  set value(T value) => _subject.add(value);
 /// dont forget colse when done
  void close() => _subject.close();
}
