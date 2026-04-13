import 'package:flutter/material.dart';
import 'package:tgbc_app/core/core.dart';
// import 'package:fluttrfly/fluttrfly.dart';


class BaseTemplate extends StatelessWidget {
  const BaseTemplate({
    super.key,
    this.title,
    required this.child,
  });

  final String? title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0XFFFFFFFF),
        shape: const Border(
            bottom: BorderSide(color: Color(0XFFEDEDED), width: 4)),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(title ?? ''),
            // if(subtitle.containsValidValue && actions.isNotEmpty)...[
            //   gapW12,
            //   DocStatusWidget(status: subtitle!),
            // ],
          ],
        ),
        leadingWidth: context.sizeOfWidth * 0.1,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: child,
      ),
    );
    // return ScaffoldX(
    //   resizeToAvoidBottomInset: resizeToAvoidBottomInset,
    //   title: title,
    //   wantLeading: !isHome,
    //   titleTextBlack: true,
    //   appBarActions: actions,
    //   status: subtitle,
    //   floatingActionButton: floatingActionButton,
    //   bottom: bottom,
    //   body: Padding(
    //     padding: EdgeInsets.symmetric(horizontal: horPadding),
    //     child: child,
    //   ),
    // );
  }
}
