import 'package:flutter/material.dart';

import 'package:diffutil_dart/diffutil.dart' as diffutil;

import 'package:auto_animated_list/src/extensions/list_element_at_or_null.dart';

/// ListView widget that implicitly animates when `items` changes.
class AutoAnimatedList<T> extends StatefulWidget {
  /// Creates a ListView widget that implicitly animates when `items` changes.
  const AutoAnimatedList({
    Key? key,
    required this.items,
    required this.itemBuilder,
    this.scrollDirection = Axis.vertical,
    this.shrinkWrap = false,
    this.reverse = false,
    this.primary,
    this.physics,
    this.controller,
    this.padding,
  }) : super(key: key);

  /// List of items that the [itemBuilder] should animate widgets for.
  final List<T> items;

  /// Whether the extent of the scroll view in the [scrollDirection] should be
  /// determined by the contents being viewed.
  ///
  /// If the scroll view does not shrink wrap, then the scroll view will expand
  /// to the maximum allowed size in the [scrollDirection]. If the scroll view
  /// has unbounded constraints in the [scrollDirection], then [shrinkWrap] must
  /// be true.
  ///
  /// Shrink wrapping the content of the scroll view is significantly more
  /// expensive than expanding to the maximum allowed size because the content
  /// can expand and contract during scrolling, which means the size of the
  /// scroll view needs to be recomputed whenever the scroll position changes.
  ///
  /// Defaults to false.
  final bool shrinkWrap;

  /// Whether the scroll view scrolls in the reading direction.
  ///
  /// For example, if the reading direction is left-to-right and
  /// [scrollDirection] is [Axis.horizontal], then the scroll view scrolls from
  /// left to right when [reverse] is false and from right to left when
  /// [reverse] is true.
  ///
  /// Similarly, if [scrollDirection] is [Axis.vertical], then the scroll view
  /// scrolls from top to bottom when [reverse] is false and from bottom to top
  /// when [reverse] is true.
  ///
  /// Defaults to false.
  final bool reverse;

  /// The axis along which the scroll view scrolls.
  ///
  /// Defaults to [Axis.vertical].
  final Axis scrollDirection;

  /// Whether this is the primary scroll view associated with the parent
  /// [PrimaryScrollController].
  ///
  /// On iOS, this identifies the scroll view that will scroll to top in
  /// response to a tap in the status bar.
  ///
  /// Defaults to true when [scrollDirection] is [Axis.vertical] and
  /// [controller] is null.
  final bool? primary;

  /// How the scroll view should respond to user input.
  ///
  /// For example, determines how the scroll view continues to animate after the
  /// user stops dragging the scroll view.
  ///
  /// Defaults to matching platform conventions.
  final ScrollPhysics? physics;

  /// An object that can be used to control the position to which this scroll
  /// view is scrolled.
  ///
  /// Must be null if [primary] is true.
  ///
  /// A [ScrollController] serves several purposes. It can be used to control
  /// the initial scroll position (see [ScrollController.initialScrollOffset]).
  /// It can be used to control whether the scroll view should automatically
  /// save and restore its scroll position in the [PageStorage] (see
  /// [ScrollController.keepScrollOffset]). It can be used to read the current
  /// scroll position (see [ScrollController.offset]), or change it (see
  /// [ScrollController.animateTo]).
  final ScrollController? controller;

  /// The amount of space by which to inset the children.
  final EdgeInsetsGeometry? padding;

  /// Called, as needed, to build list item widgets.
  ///
  /// List items are only built when they're scrolled into view.
  final Widget Function(BuildContext, T, int, Animation<double>) itemBuilder;

  @override
  State<AutoAnimatedList<T>> createState() => _AutoAnimatedListState<T>();
}

class _AutoAnimatedListState<T> extends State<AutoAnimatedList<T>> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  List<T> get _items => widget.items;

  @override
  void didUpdateWidget(covariant AutoAnimatedList<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    _handleListUpdated(oldWidget.items);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      key: _listKey,
      controller: widget.controller,
      scrollDirection: widget.scrollDirection,
      shrinkWrap: widget.shrinkWrap,
      reverse: widget.reverse,
      primary: widget.primary,
      physics: widget.physics,
      padding: widget.padding,
      initialItemCount: _items.length,
      itemBuilder: (context, index, animation) => widget.itemBuilder(
        context,
        _items[index],
        index,
        animation,
      ),
    );
  }

  void _handleListUpdated(List<T> oldList) {
    final listState = _listKey.currentState;
    if (listState == null) return;

    final newList = widget.items;
    final diffResult = diffutil.calculateListDiff<T>(oldList, newList);
    final updates = diffResult.getUpdates(batch: false);
    if (updates.isEmpty) return;
    for (final update in updates) {
      update.when(
        move: (from, to) {
          _handleRemoveItem(from);
          _handleInsertItem(to);
        },
        insert: (to, _) => _handleInsertItem(to),
        remove: (from, _) => _handleRemoveItem(from, useAnimation: false),
        change: (_, __) {},
      );
    }
  }

  void _handleInsertItem(int to) => _listKey.currentState?.insertItem(to);

  void _handleRemoveItem(
    int from, {
    bool useAnimation = true,
  }) =>
      _listKey.currentState?.removeItem(from, (context, animation) {
        final item = _items.elementAtOrNull(from);
        if (item == null || !useAnimation) return Container();
        return widget.itemBuilder(context, item, from, animation);
      });
}
