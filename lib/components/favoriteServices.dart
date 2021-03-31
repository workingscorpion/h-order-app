import 'package:flutter/material.dart';

class FavoriteServices extends StatelessWidget {
  const FavoriteServices({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _favorites(),
    );
  }

  _favorites() => Container(
        height: 150,
        color: Colors.grey,
        padding: EdgeInsets.symmetric(
          horizontal: 100,
          vertical: 20,
        ),
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            ...List.generate(
              10,
              (index) => Container(
                margin: EdgeInsets.only(
                  right: 30,
                ),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: FlatButton(
                    onPressed: () {
                      print('clicked');
                    },
                    child: Text('Service $index'),
                  ),
                ),
              ),
            )
          ],
        ),
      );
}
