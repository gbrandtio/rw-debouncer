`rw_debouncer` provides a simple yet concrete implementation that will allow expanding any function
with the ability of debouncing.

## Features

- `debounce`: Debounce the function call by a pre-defined debouncing timeout.
- `flush`: Execute the function immediately, if and only if there is at least one active invocation.
- `cancelDebouncedInvocation`: Cancels the invocation of a specific debounce operation.
- `clearDebouncedInvocations`: Cancels all the debounce operations, associated with any of the debouncing objects.

## Getting started

Add the dependency on pubspec.yaml:
`rw_debouncer: 1.0.0`

## Usage

```
// Instantiate a new RwDebouncer.
var debouncer =  RwDebouncer<String>('ABC123', () => 'Hello', smallDebouncingTimeout);
```

```
// Start debouncing.
var result = await debouncer.debounce();
```

```
// Execute the operation associated with the debouncer isntance immediately.
var result = debouncer.flush();
```

```
// Cancel the debouncing operation with tracking id 'ABC123'.
debouncer.cancelDebouncedInvocation('ABC123');
```

```
// Clear all the debounced operations, associated with any of the debounced objects.
debouncer.clearDebouncedInvocations();
```

## Additional information

Please file any issues on the [github issue tracker](https://github.com/gbrandtio/rw-debouncer/issues);
