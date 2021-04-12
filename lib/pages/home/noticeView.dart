import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:h_order/components/collapsible.dart';
import 'package:h_order/constants/customColors.dart';
import 'package:h_order/models/noticeModel.dart';
import 'package:intl/intl.dart';

class NoticeView extends StatefulWidget {
  NoticeView();

  @override
  _NoticeViewState createState() => _NoticeViewState();
}

class _NoticeViewState extends State<NoticeView> {
  final List<String> titles = [
    'Falling Fire',
    'The Whispering Doors',
    'Courage of Ice',
    'The Game\'s Sliver',
    'The Waves of the Shadow',
    'Someone in the Touch',
    'Purple Illusion',
    'The Only Silence',
    'Women of Men',
    'The Person\'s Winter',
    'The Tower of the Husband',
    'Moons in the Teacher',
    'Frozen Academy',
    'The Burning Men',
    'Petals of Thought',
    'The Ship\'s Healer',
    'The Child of the Eyes',
    'Female in the Flowers',
    'Frozen Shards',
    'The Dwindling Healer',
  ];

  final List<String> names = [
    'Beverly',
    'Charles',
    'Karla',
    'Marshall',
    'Allegra',
    'Jameel',
    'Cieran',
    'Huw',
    'Niamh',
    'Deon',
    'Dillan',
    'Cheyenne',
    'Nathanial',
    'Sultan',
    'Domonic',
    'Raheel',
    'Beth',
    'Carmen',
    'Katya',
    'Jacqueline',
  ];

  final List<String> contents = [
    '''Too many prisons have become early coffins.
I covered my friend in baby oil.
There was no ice cream in the freezer, nor did they have money to go to the store.
Joe made the sugar cookies; Susan decorated them.
Bill ran from the giraffe toward the dolphin.
Whenever he saw a red flag warning at the beach he grabbed his surfboard.
Her life in the confines of the house became her new normal.
Pink horses galloped across the sea.
The pigs were insulted that they were named hamburgers.
The group quickly understood that toxic waste was the most effective barrier to use against the zombies.''',
    '''Choosing to do nothing is still a choice, after all.
The virus had powers none of us knew existed.
Joe made the sugar cookies; Susan decorated them.
When he encountered maize for the first time, he thought it incredibly corny.
They did nothing as the raccoon attacked the lady’s bag of food.
This made him feel like an old-style rootbeer float smells.
It was a slippery slope and he was willing to slide all the way to the deepest depths.
The irony of the situation wasn't lost on anyone in the room.
The pet shop stocks everything you need to keep your anaconda happy.
Malls are great places to shop; I can find everything I need under one roof.''',
    '''The waitress was not amused when he ordered green eggs and ham.
There aren't enough towels in the world to stop the sewage flowing from his mouth.
We will not allow you to bring your pet armadillo along.
She was too short to see over the fence.
Courage and stupidity were all he had.
I like to leave work after my eight-hour tea-break.
They're playing the piano while flying in the plane.
The skeleton had skeletons of his own in the closet.
He loved eating his bananas in hot dog buns.
The light that burns twice as bright burns half as long.''',
    '''Various sea birds are elegant, but nothing is as elegant as a gliding pelican.
They throw cabbage that turns your brain into emotional baggage.
Car safety systems have come a long way, but he was out to prove they could be outsmarted.
Their argument could be heard across the parking lot.
Swim at your own risk was taken as a challenge for the group of Kansas City college students.
The newly planted trees were held up by wooden frames in hopes they could survive the next storm.
I met an interesting turtle while the song on the radio blasted away.
With a single flip of the coin, his life changed forever.
Dolores wouldn't have eaten the meal if she had known what it actually was.
The clouds formed beautiful animals in the sky that eventually created a tornado to wreak havoc.''',
    '''The murder hornet was disappointed by the preconceived ideas people had of him.
I like to leave work after my eight-hour tea-break.
Joyce enjoyed eating pancakes with ketchup.
I think I will buy the red car, or I will lease the blue one.
I hear that Nancy is very pretty.
His ultimate dream fantasy consisted of being content and sleeping eight hours in a row.
Separation anxiety is what happens when you can't find your phone.
Dan ate the clouds like cotton candy.
The sign said there was road work ahead so he decided to speed up.
Nothing is as cautiously cuddly as a pet porcupine.''',
  ];

  List<NoticeModel> list;

  @override
  void initState() {
    super.initState();

    final random = Random();
    list = List.generate(
      100,
      (index) => NoticeModel(
        index: index + 1,
        writer: names[random.nextInt(names.length)],
        title: titles[random.nextInt(titles.length)],
        content: contents[random.nextInt(contents.length)],
        createdTime: DateTime(
          2021,
          random.nextInt(12),
          random.nextInt(30),
        ),
        hit: random.nextInt(100) + 10,
      ),
    )..sort((a, b) => a.createdTime.isAfter(b.createdTime) ? -1 : 1);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.only(
          left: 25,
          right: 25,
          bottom: 30,
          top: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FractionallySizedBox(
              widthFactor: .25,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  '입주민 공지',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  border: Border.all(
                    color: Theme.of(context).accentColor,
                    width: 3,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),
              ),
            ),
            Expanded(
                child: IntrinsicHeight(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: CustomColors.tableOuterBorder,
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      color: Theme.of(context).accentColor,
                      child: _row(
                        flex: [1, 4, 2, 2],
                        children: [
                          Text(
                            'No.',
                            maxLines: 1,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .copyWith(),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            '제목',
                            maxLines: 1,
                            style: Theme.of(context).textTheme.bodyText1,
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            '작성자',
                            maxLines: 1,
                            style: Theme.of(context).textTheme.bodyText1,
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            '작성일자',
                            maxLines: 1,
                            style: Theme.of(context).textTheme.bodyText1,
                            textAlign: TextAlign.center,
                          ),
                        ],
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                    Expanded(
                      child: ListView(
                        children: [
                          ...list.map(
                            (item) => _item(
                              flex: [1, 4, 2, 2],
                              children: [
                                Text(
                                  '${item.index}',
                                  maxLines: 1,
                                  style: Theme.of(context).textTheme.bodyText2,
                                  textAlign: TextAlign.center,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(right: 10),
                                      child: SvgPicture.asset(
                                        'assets/icons/notice/new.svg',
                                        width: 25,
                                        height: 25,
                                      ),
                                    ),
                                    Flexible(
                                      child: Text(
                                        '${item.title}',
                                        maxLines: 1,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    )
                                  ],
                                ),
                                Text(
                                  '${item.writer}',
                                  maxLines: 1,
                                  style: Theme.of(context).textTheme.bodyText2,
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  '${DateFormat('yyyy/MM/dd').format(item.createdTime)}',
                                  maxLines: 1,
                                  style: Theme.of(context).textTheme.bodyText2,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                              content: item.content,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ))
          ],
        ),
      );

  _row({
    List<int> flex,
    List<Widget> children,
    Color color,
  }) =>
      DefaultTextStyle(
        style: TextStyle(
          fontSize: 24,
        ),
        child: Container(
          color: color,
          padding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 26,
          ),
          child: Row(
            children: [
              ...children
                  .asMap()
                  .map(
                    (index, item) => MapEntry(
                      index,
                      Expanded(
                        flex: flex[index],
                        child: Container(
                          padding: index < children.length - 1
                              ? EdgeInsets.only(right: 10)
                              : EdgeInsets.zero,
                          child: item,
                        ),
                      ),
                    ),
                  )
                  .values,
            ],
          ),
        ),
      );

  _item({
    List<int> flex,
    List<Widget> children,
    String content,
  }) =>
      Collapsible(
        header: _row(
          flex: flex,
          children: children,
          color: Theme.of(context).primaryColor,
        ),
        body: Container(
          padding: EdgeInsets.all(26),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            border: Border(
              top: BorderSide(
                color: CustomColors.tableInnerBorder,
              ),
            ),
          ),
          child: Text(
            content,
            maxLines: null,
          ),
        ),
      );
}
