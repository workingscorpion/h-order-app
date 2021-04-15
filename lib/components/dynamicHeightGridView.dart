import 'package:flutter/material.dart';

class DynamicHeightGridView extends StatefulWidget {
  final EdgeInsets padding;
  final List<Widget> children;
  final int crossAxisCount;
  final double mainAxisSpacing;
  final double crossAxisSpacing;

  DynamicHeightGridView({
    this.padding,
    this.children,
    this.crossAxisCount,
    this.mainAxisSpacing,
    this.crossAxisSpacing,
  });

  @override
  _DynamicHeightGridViewState createState() => _DynamicHeightGridViewState();
}

class _DynamicHeightGridViewState extends State<DynamicHeightGridView> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: widget.padding,
      children: [
        ...List.generate(
          (widget.children.length / widget.crossAxisCount).ceil(),
          (row) {
            final children = List.generate(
              3,
              (column) {
                final index = row * widget.crossAxisCount + column;

                return Expanded(
                  child: Container(
                    margin:
                        EdgeInsets.only(bottom: widget.mainAxisSpacing ?? 0),
                    child: index < widget.children.length - 1
                        ? widget.children[index]
                        : Container(),
                  ),
                );
              },
            );

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...List.generate(
                  children.length * 2 - 1,
                  (index) => index % 2 == 0
                      ? children[(index / 2).round()]
                      : Container(
                          width: widget.crossAxisSpacing ?? 0,
                        ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
