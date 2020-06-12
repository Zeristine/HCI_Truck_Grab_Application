import 'package:flutter/cupertino.dart';

enum DirectionMarguee { oneDirection, TwoDirection }

class Marquee extends StatefulWidget {
  final Widget child;
  //final TextDirection textDirection;
  final Axis direction;
  final Duration animationDuration, backDuration, pauseDuration;
  //final DirectionMarguee directionMarguee;

  Marquee({
    @required this.child,
    this.direction = Axis.horizontal,
    //this.textDirection = TextDirection.ltr,
    this.animationDuration = const Duration(milliseconds: 5000),
    this.backDuration = const Duration(milliseconds: 5000),
    this.pauseDuration = const Duration(milliseconds: 2000),
    //this.directionMarguee = DirectionMarguee.TwoDirection
  });

  final ScrollController scrollController = ScrollController();
  @override
  MarqueeState createState() => MarqueeState();
}

class MarqueeState extends State<Marquee> {
  ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: widget.child,
      scrollDirection: widget.direction,
      controller: scrollController,
    );
  }

  @override
  void initState() {
    scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback(scroll);
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void scroll(_) async {
    while (scrollController.hasClients) {
      await Future.delayed(Duration(milliseconds: 1000));
      if (scrollController.hasClients)
        await scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            duration: widget.animationDuration,
            curve: Curves.ease);
      await Future.delayed(widget.pauseDuration);
      if (scrollController.hasClients)
        await scrollController.animateTo(0.0,
            duration: widget.backDuration, curve: Curves.easeOut);
    }
  }
}
