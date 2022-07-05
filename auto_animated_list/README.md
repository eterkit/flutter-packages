# auto_animated_list

AutoAnimatedList Widget that supports automatic animations when list items are changed.

<img src="https://raw.githubusercontent.com/eterkit/flutter-packages/auto_animated_list/main/example.gif">

# example

### How to use

```dart
AutoAnimatedList<Fruit>(
  items: fruits,
  itemBuilder: (context, fruit, index, animation) {
    return SizeFadeTransition(
      animation: animation,
      child: ListTile(
        leading: Text('${index + 1}'),
        title: Text(fruit.name),
      ),
    );
  },
),
```

### Full example

[Source code](https://github.com/eterkit/flutter/auto_animated_list/tree/main/example)

An example showing how to set up and use AutoAnimatedList widget.
