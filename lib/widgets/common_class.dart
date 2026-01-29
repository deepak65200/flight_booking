import 'package:flutter/material.dart';
import '../helpers/navHelper.dart';
import '../utils/color_res.dart';
import '../utils/preferences.dart';
import 'common_filter_tabs.dart';
import 'common_method.dart';

class CommonHeaderBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBackTap,onRightTap;
  //final IconData icon;
  final Widget? backIconWidget; // <-- Add this
  final bool showBackIcon;
  final bool showRightWidget;
  final Widget? rightWidget;
  final Color backgroundColor;
  final bool centerTitle;
  final bool showFilterTabs;
  // for filter tabs
  final List<String>? filterTabs;
  final String? selectedTab;
  final Function(String)? onTabSelected;
  final bool showDivider;


  const CommonHeaderBar({
    super.key,
    required this.title,
    this.onBackTap,this.onRightTap,
    //this.icon = Icons.arrow_back_ios_new,
    this.backIconWidget,
    this.showBackIcon = true,
    this.showRightWidget = false,
    this.rightWidget,
    this.backgroundColor = Colors.white,
    this.centerTitle = true,
    this.showFilterTabs = false,
    this.filterTabs,
    this.selectedTab,
    this.onTabSelected,
    this.showDivider=true,

  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      child: SafeArea(
        bottom: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: SizedBox(
                height: 40,
                child: centerTitle
                    ? Stack(
                  alignment: Alignment.center,
                  children: [
                    // Centered Title
                    Center(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    // Left Back Icon
                    if (showBackIcon)
                      Align(
                        alignment: Alignment.centerLeft,
                        child: _buildBackButton(context),
                      ),

                    // Right Widget
                      if (showRightWidget)
                        Align(
                          alignment: Alignment.centerRight,
                          child: buildBounceGesDetector(
                            onTap: () {
                              if (onRightTap != null) {
                                onRightTap!(); // <- This line calls your callback
                              }
                            },
                            child: rightWidget ??
                                Icon(
                                  Icons.notifications_none,
                                  color: ColorRes.iconBlue,
                                ),
                          ),
                        ),

                  ],
                )
                    : Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if (showBackIcon) _buildBackButton(context),
                    if (showBackIcon) const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    if (showRightWidget) ...[
                      const SizedBox(width: 12),
                      buildBounceGesDetector(
                        onTap: () {
                          if (onRightTap != null) {
                            onRightTap!();
                          }
                        },
                        child: rightWidget ??
                            const Icon(
                              Icons.notifications_none,
                              color: ColorRes.iconBlue,
                            ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            if (showFilterTabs) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: commonFilterTabs(
                  tabs: filterTabs!,
                  selectedTab: selectedTab!,
                  onTabSelected: onTabSelected!,       // Callback to update state
                  color: ColorRes.iconBlue,
                ),
              ),
            ],
            if(showDivider)...[
              commonDivider(),
            ]
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(showFilterTabs?(kToolbarHeight + 80):kToolbarHeight + 5);

  Widget _buildBackButton(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onBackTap != null) {
          onBackTap!();
        } else {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          } else {
           // navPushAndRemove(context: context, widget: DashboardScreen());
          }
        }
      },
      borderRadius: BorderRadius.circular(20),
      // child: Container(
      //   height: 32,
      //   width: 32,
      //   decoration: BoxDecoration(
      //     shape: BoxShape.circle,
      //     border: Border.all(color: Colors.black, width: 1.2),
      //     color: Colors.white,
      //     boxShadow: const [
      //       BoxShadow(
      //         color: Colors.black12,
      //         blurRadius: 1,
      //         offset: Offset(0, 1),
      //       ),
      //     ],
      //   ),
        child: backIconWidget ??
            const Icon(Icons.arrow_back_ios_new, size: 20, color: Colors.black),
      //),
    );
  }
}



class SpeechBubblePainter extends CustomPainter {
  final Color color;
  SpeechBubblePainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = color;
    Path path = Path();

    path.moveTo(size.width / 2, size.height);
    path.lineTo(0, 0);
    path.lineTo(size.width, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(SpeechBubblePainter oldDelegate) => false;
}











