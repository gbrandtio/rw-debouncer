import 'package:rw_debouncer/rw_debouncer.dart';
import 'package:test/test.dart';

void main() {
  group('flush() tests', () {
    const debouncingTimeout = 3000;
    int simpleDebounceTest() {
      return 1;
    }

    int anotherSimpleDebounceTest() {
      return 2;
    }

    test(
        'Test that flushing a RwDebouncer object executes its associated function immediately',
        () async {
      RwDebouncer<int> rwDebouncerOne =
          RwDebouncer("a123", () => simpleDebounceTest(), debouncingTimeout);
      RwDebouncer<int> rwDebouncerAnother = RwDebouncer(
          "b123", () => anotherSimpleDebounceTest(), debouncingTimeout);

      rwDebouncerOne.debounce();
      rwDebouncerAnother.debounce();

      int firstResult = rwDebouncerOne.flush();
      int secondResult = rwDebouncerAnother.flush();

      expect(firstResult, 1);
      expect(secondResult, 2);
    });

    test('Flushing without any active debouncing will throw an error',
        () async {
      RwDebouncer<int> rwDebouncerOne =
          RwDebouncer("a123", () => simpleDebounceTest(), debouncingTimeout);
      expect(() => rwDebouncerOne.flush(), throwsException);
    });
  });
}
