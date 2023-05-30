import 'dart:async';
import 'package:rw_debouncer/src/rw_debouncer_impl.dart';

/// ----------------------------------------------------------------------------
/// rw_debouncer_base.dart
/// ----------------------------------------------------------------------------
/// A debouncer implementation that allows executing a debounced function
/// after a specified timeout, and provides methods for canceling and flushing
/// debounced invocations.
///
/// The `RwDebouncer` class extends the `RwDebouncerImpl` class to provide
/// the implementation of debouncing logic. It allows tracking and managing
/// debounced invocations based on a tracking ID.
///
/// Example usage:
/// ```dart
/// var debouncer = RwDebouncer<String>('ABC123', () => 'Hello', 500);
/// debouncer.debounce().then((result) {
///   print(result);
/// });
/// ```
///
/// Type parameter:
/// - [T]: The type of the debounced function's return value.
///
/// See also:
/// - [RwDebouncerImpl]: The base class providing the debouncing logic.
class RwDebouncer<T> extends RwDebouncerImpl<T> {
  /// Constructs a new `RwDebouncer` instance with the provided parameters.
  ///
  /// This constructor creates a new `RwDebouncer` object with the specified tracking ID,
  /// debounced function, and debouncing timeout. The tracking ID uniquely identifies
  /// the debouncer instance. The `fn` parameter represents the debounced function to be
  /// executed, and the `debouncingTimeout` parameter determines the time interval for
  /// debouncing.
  ///
  /// Example usage:
  /// ```dart
  /// var debouncer = RwDebouncer('ABC123', () => 'Hello', 500);
  /// ```
  ///
  /// - `trackingId`: The unique identifier associated with the debouncer instance.
  /// - `fn`: The debounced function to be executed.
  /// - `debouncingTimeout`: The time interval for debouncing, in milliseconds.
  RwDebouncer(String trackingId, T Function() fn, int debouncingTimeout) {
    super.debouncedFn = fn;
    super.debouncingTimeout = debouncingTimeout;
    if (!RwDebouncerImpl.debouncingOperationsMemento.containsKey(trackingId)) {
      super.trackingId = trackingId;
    }
  }

  @override
  Future<T> debounce() {
    RwDebouncerImpl.debouncingOperationsMemento[trackingId]?.cancel();

    Duration duration = Duration(milliseconds: debouncingTimeout);
    Completer<T> completer = Completer<T>();

    debouncingTimer = Timer(duration, () {
      T debouncedExecutionResult = super.debouncedFn();
      RwDebouncerImpl.debouncingOperationsMemento.remove(super.trackingId);
      completer.complete(debouncedExecutionResult);
    });

    RwDebouncerImpl.debouncingOperationsMemento[trackingId] = debouncingTimer;
    return completer.future;
  }

  @override
  T flush() {
    try {
      if (RwDebouncerImpl.debouncingOperationsMemento.isNotEmpty) {
        cancelDebouncedInvocation(super.trackingId);
        return super.debouncedFn();
      }
    } catch (e) {
      // Swallow the exception here - a generic exception is thrown afterwards.
    }

    throw Exception();
  }
}
