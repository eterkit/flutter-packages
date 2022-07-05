import 'package:flutter_test/flutter_test.dart';

import 'package:responsive_annotation/annotations/responsive_variable.dart';

void main() {
  group('$ResponsiveVariable', () {
    test('should allow providing simple & custom types', () {
      expect(stringVariable.tablet, tabletString);
      expect(boolVariable.tablet, tabletBool);
      expect(doubleVariable.tablet, tabletDouble);
      expect(intVariable.tablet, tabletInt);
      expect(mapVariable.tablet, tabletMap);
      expect(typedMapVariable.tablet, tabletTypedMap);
      expect(setVariable.tablet, tabletSet);
      expect(typedSetVariable.tablet, tabletTypedSet);
      expect(listVariable.tablet, tabletList);
      expect(typedListVariable.tablet, tabletTypedList);
      expect(customTypeVariable.tablet, tabletCustomType);
    });

    test('should throw if any of the parameters is null or not provided', () {
      expect(
        () => ResponsiveVariable(
          mobile: 14,
          tablet: null,
          laptop: 42,
          desktop: 56,
          widescreen: null,
        ),
        throwsAssertionError,
      );
    });
  });
}

const tabletString = 'tablet';
const stringVariable = ResponsiveVariable<String>(
  mobile: 'mobile',
  tablet: tabletString,
  laptop: 'laptop',
  desktop: 'desktop',
  widescreen: 'widescreen',
);

const double tabletDouble = 2;
const doubleVariable = ResponsiveVariable<double>(
  mobile: 1,
  tablet: tabletDouble,
  laptop: 3,
  desktop: 4,
  widescreen: 5,
);

const bool tabletBool = true;
const boolVariable = ResponsiveVariable<bool>(
  mobile: false,
  tablet: tabletBool,
  laptop: true,
  desktop: false,
  widescreen: true,
);

const tabletInt = 2;
const intVariable = ResponsiveVariable<int>(
  mobile: 1,
  tablet: tabletInt,
  laptop: 3,
  desktop: 4,
  widescreen: 5,
);

const tabletMap = {'tablet': 'tablet'};
const mapVariable = ResponsiveVariable<Map>(
  mobile: {'mobile': 'mobile'},
  tablet: tabletMap,
  laptop: {'laptop': 'laptop'},
  desktop: {'desktop': 'desktop'},
  widescreen: {'widescreen': 'widescreen'},
);

const tabletTypedMap = {'tablet': 'tablet'};
const typedMapVariable = ResponsiveVariable<Map<String, String>>(
  mobile: {'mobile': 'mobile'},
  tablet: tabletTypedMap,
  laptop: {},
  desktop: {'desktop': 'desktop'},
  widescreen: {'widescreen': 'widescreen'},
);

const tabletSet = {'tablet'};
const setVariable = ResponsiveVariable<Set>(
  mobile: {'mobile'},
  tablet: tabletSet,
  laptop: {'laptop'},
  desktop: {},
  widescreen: {'widescreen'},
);

const tabletTypedSet = {2};
const typedSetVariable = ResponsiveVariable<Set<int>>(
  mobile: {1},
  tablet: tabletTypedSet,
  laptop: {3},
  desktop: <int>{},
  widescreen: {5},
);

const tabletList = ['tablet'];
const listVariable = ResponsiveVariable<List>(
  mobile: ['mobile'],
  tablet: tabletList,
  laptop: ['laptop'],
  desktop: [],
  widescreen: ['widescreen'],
);

const tabletTypedList = <double>[2];
const typedListVariable = ResponsiveVariable<List<double>>(
  mobile: <double>[1],
  tablet: tabletTypedList,
  laptop: [],
  desktop: [],
  widescreen: [2, 4],
);

const tabletCustomType = _TabletTestType();
const customTypeVariable = ResponsiveVariable<_CustomTestType>(
  mobile: _MobileTestType(),
  tablet: tabletCustomType,
  laptop: _LaptopTestType(),
  desktop: _DesktopTestType(),
  widescreen: _WidescreenTestType(),
);

abstract class _CustomTestType {
  const _CustomTestType();
}

class _MobileTestType extends _CustomTestType {
  const _MobileTestType();
}

class _LaptopTestType extends _CustomTestType {
  const _LaptopTestType();
}

class _TabletTestType extends _CustomTestType {
  const _TabletTestType();
}

class _DesktopTestType extends _CustomTestType {
  const _DesktopTestType();
}

class _WidescreenTestType extends _CustomTestType {
  const _WidescreenTestType();
}
