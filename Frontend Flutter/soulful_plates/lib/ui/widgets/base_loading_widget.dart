import 'package:flutter/material.dart';


class BaseLoadingWidget extends StatefulWidget {
  const BaseLoadingWidget({Key? key}) : super(key: key);

  @override
  State<BaseLoadingWidget> createState() => _BaseLoadingWidgetState();
}

class _BaseLoadingWidgetState extends State<BaseLoadingWidget> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator();
  }
}

class BaseLoadMoreWidget extends StatefulWidget {
  const BaseLoadMoreWidget({Key? key}) : super(key: key);

  @override
  State<BaseLoadMoreWidget> createState() => _BaseLoadMoreWidgetState();
}

class _BaseLoadMoreWidgetState extends State<BaseLoadMoreWidget> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator();
  }
}
