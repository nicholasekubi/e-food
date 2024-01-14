import 'package:flutter/material.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/small_text.dart';

class ExpandableTextWidget extends StatefulWidget {
  final String text;
  const ExpandableTextWidget({Key? key, required this.text}) : super(key: key);

  @override
  State<ExpandableTextWidget> createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  double textHeight = Dimensions.screenHeight / 5.63;
  bool textNeedExpand = false;
  bool textExpanded = false;

  @override
  void initState() {
    super.initState();
    if (widget.text.length >= textHeight) {
      textNeedExpand = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    //
    //A column is used because the Expanded widget has to be placed in either a Flex widget, Row or Column widgets. Now, the column is unbound, so an Expanded widget cannot be used here. Hence, the Flexible widget is used with these prameters set.
    //
    return Flexible(
      fit: FlexFit.loose,
      flex: 1,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: textNeedExpand
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textNeedExpand
                      ? SmallText(
                          maxLines: 0,
                          text: textExpanded
                              ? widget.text
                              : widget.text.substring(0, textHeight.toInt()) +
                                  '...',
                          color: AppColors.paraColor,
                          height: 1.8,
                          size: Dimensions.font16,
                        )
                      : SmallText(
                          maxLines: 0,
                          text: widget.text,
                          color: AppColors.paraColor,
                          height: 1.8,
                          size: Dimensions.font16,
                        ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        textExpanded = !textExpanded;
                      });
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SmallText(
                          maxLines: 0,
                          text: textExpanded ? 'Show less' : 'Show more',
                          color: AppColors.mainColor,
                          size: Dimensions.font16,
                          height: 2,
                        ),
                        Icon(
                          textExpanded
                              ? Icons.keyboard_arrow_up_rounded
                              : Icons.keyboard_arrow_down_rounded,
                          color: AppColors.mainColor,
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : SmallText(
                maxLines: 0,
                text: widget.text,
                color: AppColors.paraColor,
                size: Dimensions.font16,
                height: 1.8,
              ),
      ),
    );
  }
}
