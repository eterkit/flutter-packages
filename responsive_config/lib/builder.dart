import 'package:build/build.dart';

import 'package:responsive_config/builders/responsive_config_part_builder.dart';

/// Builder which generates responsive code for classes annotated with
/// `@ResponsiveConfig`.
Builder responsiveConfig(BuilderOptions options) =>
    responsiveConfigPartBuilder(options);
