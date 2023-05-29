import 'package:rw_debouncer/rw_debouncer.dart';
import 'package:test/test.dart';

void main() {
  group('clearDebouncedInvocations() tests', () {
    const debouncingTimeout = 3000;
    int simpleDebounceTest() {
      return 1;
    }

    int anotherSimpleDebounceTest() {
      return 2;
    }

    test(
        'Test that all debouncing operations are canceled once the clear is called',
        () async {
      int oneDebouncerResult = -1;
      int anotherDebouncerResult = -1;

      RwDebouncer<int> rwDebouncerOne =
          RwDebouncer("a123", () => simpleDebounceTest(), debouncingTimeout);
      RwDebouncer<int> rwDebouncerAnother = RwDebouncer(
          "b123", () => anotherSimpleDebounceTest(), debouncingTimeout);

      rwDebouncerOne.debounce().then((value) => oneDebouncerResult = value);
      rwDebouncerAnother.debounce().then((value) {
        print("AnotherDebouncer executed");
        anotherDebouncerResult = value;
      });

      rwDebouncerOne.clearDebouncedInvocations();
      await Future.delayed(Duration(milliseconds: 4000));

      expect(oneDebouncerResult, -1);
      expect(anotherDebouncerResult, -1);
    });
  });
}
