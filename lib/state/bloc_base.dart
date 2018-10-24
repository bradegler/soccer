
/// Base class for all BLoC objects 
/// 
/// Main feature is a requirement that all BLoCs that
/// inherit from this class must implement a dispose method
/// which cleans up any resources that are allocated.
abstract class BlocBase {
  /// Close any open resources
  void dispose();
}