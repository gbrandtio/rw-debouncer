<p align="center">
<img src="https://github.com/gbrandtio/rw-debouncer/assets/72696535/d43014b6-43ec-4744-a6c1-8af6d4ccf28b" style="width: 50%;"/>
</p>

## About

`rw_debouncer` provides a simple yet concrete implementation that will allow extending any function
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
Instantiate a new RwDebouncer object:
```
var debouncer =  RwDebouncer<String>('ABC123', () => 'Hello', smallDebouncingTimeout);
```
Start debouncing:
```
var result = await debouncer.debounce();
```

Execute the operation associated with the debouncer instance immediately:
```
var result = debouncer.flush();
```
Cancel the debouncing operation with tracking id 'ABC123':
```
debouncer.cancelDebouncedInvocation('ABC123');
```
Clear all the debounced operations, associated with any of the debounced objects:
```
debouncer.clearDebouncedInvocations();
```

## Additional information

Please file any issues on the [github issue tracker](https://github.com/gbrandtio/rw-debouncer/issues).
