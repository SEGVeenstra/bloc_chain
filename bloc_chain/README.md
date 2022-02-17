<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

Dispatch your `bloc` `events` globally instead of having to target specific `bloc`s.

## About

`bloc_chain` allows you to dispatch events globally to all your '`Chained`' `Bloc`s.

This means you no longer have to add events to specific `Bloc`s like before with:

```dart
context.read<MyBloc>().add(MyEvent());
```

This is specially usefull when a user action has impact on multiple blocs.

For example, when a user logs out from your todo application, you might want to:
1. Clear user profile
2. Clear user todos
3. Clear user settings

With `bloc_chain` you don't have to call each `Bloc` individually like:

```dart
ElevatedButton(
    child: Text('logout'),
    onTap: () {
        context.read<ProfileBloc>().add(Logout());
        context.read<TodosBloc>().add(ClearTodos();
        context.read<SettingsBloc>().add(Clear());
    }
)
```

Instead you just dispatch a single user event:

```dart
ElevatedButton(
    child: Text('logout'),
    onTap: () => BlocChain.instance.add(Logout()),
)
```

## Updating your Blocs

If you want to use `bloc_chain` for your existing application that uses the `bloc` package, all you have to do is make your `bloc`s extend `ChainedBloc` instead of `Bloc`.


### Bloc
```dart
class MyBloc extends Bloc<MyEvent, MyState> {
    const MyBloc() : super(MyInitialState);
}
```

### ChainedBloc
```dart
class MyBloc extends ChainedBloc<MyState> {
    const MyBloc() : super(MyInitialState);
}
```

Notice that you no longer need to specify an `event type`.
This is because all the events should inherit from `GlobalEvent`.

So you need to update your existing events like so:

### Old
```dart
abstract class MyEvent {
    const MyEvent();
} 
```

### New
```dart
abstract class MyEvent extends GlobalEvent {
    const MyEvent();
} 
```

> NOTE: When your event was already extending Equatable, you can use `EquatableMixin` instead.

## Dispatching events

Now instead of calling `add()` on each specific `Bloc` you should use `BlocChain.instance.add()`.

### Bloc
```dart
context.read<MyBloc>().add(MyEvent());
```

### ChainedBloc
```dart
BlocChain.instance.add(MyEvent());
```

## Additional information

I've created this package because I really like to be able to just dispatch events without having to worry about who I have to send it to.