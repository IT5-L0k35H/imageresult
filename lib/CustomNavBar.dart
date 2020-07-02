import 'dart:async';

import 'package:flutter/material.dart';

class CustomnavBar extends StatefulWidget {
  final List<CustomItemNavBar> items;
  final Function(int i) onTap;

  CustomnavBar({@required this.items, @required this.onTap}) :  assert(items!=null && items.length>=2);

  @override
  _CustomnavBarState createState() => _CustomnavBarState();
}

class _CustomnavBarState extends State<CustomnavBar> {

final StreamController<int> _streamController = new StreamController.broadcast();


@override
  void initState() {
    _streamController.stream.listen((i) => widget.onTap(i));
   
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      color:  Colors.white, 
      width:  MediaQuery.of(context).size.width,
      child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: widget.items.map((item) {
              return new GestureDetector(
                  child: new ItemBottomNavBar(
                      index: widget.items.indexOf(item),
                      stream: _streamController.stream,
                      content: item),
                  onTap: () {
                    _streamController.sink.add(widget.items.indexOf(item));
                  });
            }).toList())
    );
  }

   @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

}

 

class ItemBottomNavBar extends StatelessWidget {
  final int index;
  final CustomItemNavBar content;
  final Stream<int> stream;

  ItemBottomNavBar({this.index, this.content, this.stream});

  @override
  Widget build(BuildContext context) {
    return new Padding(
        padding: EdgeInsets.all(15),
        child: new StreamBuilder(
            initialData: 0,
            stream: stream,
            builder: (context, AsyncSnapshot<int> snapshot) {
              Color _activate =
                  snapshot.data == this.index ? Colors.white : Colors.black;
              return new AnimatedContainer(
                  width: snapshot.data == this.index
                      ? MediaQuery.of(context).size.width * 0.5
                      : IconTheme.of(context).size + 30,
                  decoration: BoxDecoration(
                      color: snapshot.data == this.index
                          ? Colors.black
                          : Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  duration: Duration(milliseconds: 500),
                  curve: Curves.fastOutSlowIn,
                  child: new SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: new Row(children: <Widget>[
                        new Icon(this.content.icon, color: _activate),
                        snapshot.data == this.index
                            ? new Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: new Text(this.content.label,
                                    style: TextStyle(color: _activate)))
                            : new Container(height: 0, width: 0)
                      ])));
            }));
  }
}



class CustomItemNavBar{
  final IconData icon;
  final String label;

  CustomItemNavBar({ @required this.icon, @required this.label});
}