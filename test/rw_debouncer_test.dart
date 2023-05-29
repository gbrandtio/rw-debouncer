import 'package:rw_debouncer/rw_debouncer.dart';
import 'package:test/test.dart';

void main() {
  group('debounce() tests', () {
    const debouncingTimeout = 1000;
    bool simpleDebounceTest() {
      return true;
    }

    test('Test that the debouncing eventually executes', () async {
      RwDebouncer<bool> rwDebouncer =
          RwDebouncer("a123", () => simpleDebounceTest(), debouncingTimeout);
      bool result = await rwDebouncer.debounce();
      expect(result, true);
    });

    test('Test that the debouncing does not execute before the defined timeout',
        () async {
      RwDebouncer<bool> rwDebouncer =
          RwDebouncer("b123", () => simpleDebounceTest(), debouncingTimeout);
      bool result = false;
      rwDebouncer.debounce().then((value) => result = value);
      await Future.delayed(Duration(milliseconds: 500));
      expect(result, false);
    });

    test('Test that the debouncing executes only after the defined timeout',
        () async {
      RwDebouncer<bool> rwDebouncer =
          RwDebouncer("c123", () => simpleDebounceTest(), debouncingTimeout);
      bool result = false;
      rwDebouncer.debounce().then((value) => result = value);
      await Future.delayed(Duration(milliseconds: 500));
      await Future.delayed(Duration(milliseconds: 600));
      expect(result, true);
    });
  });
}
