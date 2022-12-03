# auto_animated_list

Zero boilerplate AutoAnimatedList Widget that supports automatic animations when list items are changed.

## Preview
(Keep in mind that gif will not show the actual performance of the widget)

<img src="https://github.com/eterkit/flutter-packages/blob/main/auto_animated_list/example.gif?raw=true">

# Example usage

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

[Source code](https://github.com/eterkit/flutter-packages/tree/main/auto_animated_list/example)

An example showing how to set up and use AutoAnimatedList widget.
