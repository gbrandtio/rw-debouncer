import 'dart:async';

/// ----------------------------------------------------------------------------
/// rw_debouncer_impl.dart
/// ----------------------------------------------------------------------------
/// A base contract for the debouncing implementation.
abstract class RwDebouncerImpl<T> {
  /// A map that stores debouncing operations.
  ///
  /// This static variable `debouncingOperationsMemento` is used to track and store
  /// debouncing operations. It maps tracking IDs to corresponding timer instances.
  /// The tracking ID uniquely identifies a debounced invocation, while the timer
  /// represents the debouncing operation associated with that invocation.
  ///
  /// Example usage:
  /// ```dart
  /// debouncingOperationsMemento['ABC123'] = Timer(Duration(seconds: 1), () {
  ///   // Debounced operation
  /// });
  /// ```
  static Map<String, Timer> debouncingOperationsMemento = {};

  /// The tracking ID associated with the object.
  ///
  /// This property holds the unique identifier used for tracking the object. The
  /// tracking ID is a string value that uniquely identifies the object so that
  /// operations like cancel or invoke explicitly can be performed.
  late String trackingId;

  /// The function to be debounced.
  ///
  /// This property holds the function that will be debounced, meaning it will be
  /// executed only after a certain timeout has elapsed since the last invocation.
  /// The function is expected to return a value of type `T`.
  late T Function() debouncedFn;

  /// The timeout duration for debouncing.
  ///
  /// This property represents the duration (in milliseconds) for debouncing, which
  /// is the minimum time that must elapse between invocations of the debounced
  /// function. Adjusting this value can control the rate at which the function is
  /// called after multiple rapid invocations.
  late int debouncingTimeout;

  /// The timer used for debouncing function execution.
  ///
  /// This property holds the instance of the timer used for debouncing the execution
  /// of the function. The timer is started whenever the debounced function is invoked
  /// and is canceled if subsequent invocations occur within the specified debounce
  /// timeout duration.
  late Timer debouncingTimer;

  /// Debounces the execution of a function and returns a future result.
  ///
  /// This method ensures that the function is executed only once within a specified
  /// timeframe, discarding any intermediate invocations. It returns a future that
  /// resolves to the result of the debounced function.
  ///
  /// Example usage:
  /// ```dart
  /// Future<int> result = myDebouncer.debounce();
  /// result.then((value) {
  ///   print(value);
  /// });
  /// ```
  Future<T> debounce();

  /// Executes the debounced function immediately and returns the result.
  ///
  /// This method allows the immediate execution of the debounced function,
  /// bypassing any pending debounce timer. It returns the result of the
  /// debounced function.
  ///
  /// Example usage:
  /// ```dart
  /// String result = myDebouncer.flush();
  /// print(result);
  /// ```
  T flush();

  /// Cancels a specific debounced invocation based on the provided tracking ID.
  ///
  /// This method is responsible for canceling a specific invocation that was previously
  /// scheduled for execution using debouncing. The `trackingId` parameter identifies
  /// the specific invocation to be canceled. Implementations of this method should
  /// handle the cancellation logic based on the provided tracking ID.
  ///
  /// Example usage:
  /// ```dart
  /// myDebouncer.cancelDebouncedInvocation('ABC123');
  /// ```
  ///
  /// - [trackingId]: The unique identifier associated with the debounced invocation
  ///   to be canceled.
  void cancelDebouncedInvocation(String trackingId) {
    bool thereAreDebouncingOperations = debouncingOperationsMemento.isNotEmpty;
    bool trackingIdIsActive =
        debouncingOperationsMemento.containsKey(trackingId);

    if (thereAreDebouncingOperations && trackingIdIsActive) {
      debouncingOperationsMemento[trackingId]?.cancel();
    }
  }

  /// Cancels any pending debounce timer and clears the debouncer.
  ///
  /// This method cancels any scheduled debounced function execution and clears
  /// the internal state of the debouncer. After calling this method, no further
  /// debounced function invocations will be executed.
  ///
  /// Example usage:
  /// ```dart
  /// myDebouncer.clear();
  /// ```
  void clearDebouncedInvocations() {
    for (var element in debouncingOperationsMemento.keys) {
      debouncingOperationsMemento[element]?.cancel();
    }
    debouncingOperationsMemento.clear();
  }
}
