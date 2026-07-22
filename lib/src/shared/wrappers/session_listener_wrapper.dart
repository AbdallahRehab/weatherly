import 'package:weatherly/src/imports/core_imports.dart';


/// SessionListenerWrapper is no longer needed as auth has been removed.
/// This wrapper now just passes through the child widget.
class SessionListenerWrapper extends StatelessWidget {
  final Widget child;
  const SessionListenerWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return child;
  }
}
