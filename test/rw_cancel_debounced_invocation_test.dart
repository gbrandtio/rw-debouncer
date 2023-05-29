import 'package:rw_debouncer/rw_debouncer.dart';
import 'package:test/test.dart';

void main() {
  group('cancelDebouncedInvocation() tests', () {
    const debouncingTimeout = 3000;
    int simpleDebounceTest() {
      return 1;
    }

    int anotherSimpleDebounceTest() {
      return 2;
    }

    test(
        'Test that cancelling a specific debouncing operation will not return any value,'
        'and will not cancel any other debouncing operation', () async {
      int debouncerOneResult = -1;
      int debouncerTwoResult = -1;

      RwDebouncer<int> rwDebouncerOne =
          RwDebouncer("a123", () => simpleDebounceTest(), debouncingTimeout);
      RwDebouncer<int> rwDebouncerAnother = RwDebouncer(
          "b123", () => anotherSimpleDebounceTest(), debouncingTimeout);

      rwDebouncerOne.debounce().then((value) => debouncerOneResult = value);
      rwDebouncerAnother.debounce().then((value) => debouncerTwoResult = value);

      rwDebouncerOne.cancelDebouncedInvocation("a123");

      await Future.delayed(Duration(milliseconds: 3100));
      expect(debouncerOneResult, -1);
      expect(debouncerTwoResult, 2);
    });
  });
}
