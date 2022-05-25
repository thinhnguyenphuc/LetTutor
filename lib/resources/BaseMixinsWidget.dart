import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

mixin StatelessVariablesMixin on StatelessWidget {
  late AppLocalizations l10n;

  @mustCallSuper
  @override
  Widget build(BuildContext context) {
    l10n = AppLocalizations.of(context)!;
    return const _NullWidget();
  }
}

@optionalTypeArgs
mixin StateVariablesMixin<T extends StatefulWidget> on State<T> {
  late AppLocalizations l10n;

  @mustCallSuper
  @override
  Widget build(BuildContext context) {
    l10n = AppLocalizations.of(context)!;
    return const _NullWidget();
  }
}

class _NullWidget extends StatelessWidget {
  const _NullWidget();

  @override
  Widget build(BuildContext context) {
    throw FlutterError(
      'Widgets that mix Base widgets for common variables must '
      'call super.build() but must ignore the return value of the superclass.',
    );
  }
}

mixin WidgetBuilderVariableMixin {
  late AppLocalizations l10n;

  void initVariables(BuildContext context) {
    l10n = AppLocalizations.of(context)!;
  }
}
