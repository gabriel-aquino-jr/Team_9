import 'package:flutter/material.dart';
import 'package:mockup/provider/button_taplistener.dart';
import 'package:provider/provider.dart';

class ButtonProvider extends StatefulWidget {
  const ButtonProvider({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  State<ButtonProvider> createState() => _ButtonProviderState();
}

class _ButtonProviderState extends State<ButtonProvider> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ButtonTapListenerClass>(
      create: (context) => ButtonTapListenerClass(),
      child: widget.child,
    );
  }
}
