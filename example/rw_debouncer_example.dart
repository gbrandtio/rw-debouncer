import 'package:rw_debouncer/rw_debouncer.dart';

const smallDebouncingTimeout = 500;
const mediumDebouncingTimeout = 1000;
const largeDebouncingTimeout = 1500;

/// A simple debouncing call. The () => 'Hello' function will be executed
/// after the smallDebouncingTimeout has elapsed.
void simpleDebounce() {
  var debouncer =
      RwDebouncer<String>('ABC123', () => 'Hello', smallDebouncingTimeout);
  debouncer.debounce().then((result) {
    print(result);
  });
}

/// Cancels all active debouncing invocations, from all the [RwDebouncer] instances.
void clearAllInvocations() {
  var debouncer1 =
      RwDebouncer('a123', () => 'Hello 1', mediumDebouncingTimeout);
  var debouncer2 =
      RwDebouncer('a123', () => 'Hello 2', mediumDebouncingTimeout);
  var debouncer3 =
      RwDebouncer('a123', () => 'Hello 3', mediumDebouncingTimeout);

  debouncer1.debounce();
  debouncer2.debounce();
  debouncer3.debounce();

  // Will clear all the debounced invocations - from all the RwDebouncer instances.
  debouncer1.clearDebouncedInvocations();
}

/// Will execute the passed function immediately, without waiting
/// for the debouncing to happen. The function that will get executed is the
/// one associated with the [RwDebouncer] that called the flush operation.
///
/// After flushing, the operation that was executed is removed from the
/// debouncing operations list.
void flushDebouncer() {
  var flushDebouncer1 =
      RwDebouncer('a123', () => 'Hello', largeDebouncingTimeout);
  var flushDebouncer2 =
      RwDebouncer('a123', () => 'Hello', largeDebouncingTimeout);
  var flushDebouncer3 =
      RwDebouncer('a123', () => 'Hello', largeDebouncingTimeout);

  flushDebouncer1.flush();
  flushDebouncer2.flush();
  flushDebouncer3.flush();
}
