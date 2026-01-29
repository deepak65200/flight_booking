import 'package:flutter/material.dart';
import '../utils/color_res.dart';
import 'common_class.dart';

Widget commonFilterTabs({
  required List<String> tabs,
  required String selectedTab,
  required Function(String) onTabSelected,
  Color? color = ColorRes.primaryDark,
  Color? bgColor,
  EdgeInsets? padding,
  double? borderRadius,
  bool showSpeedBubble = true,
}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: LayoutBuilder(
      builder: (context, constraints) {
        double screenWidth = constraints.maxWidth;
        bool isTwoTabs = tabs.length == 2;
        double spacing = 10.0; // Adjust spacing as needed

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Row(
            mainAxisAlignment:
                isTwoTabs
                    ? MainAxisAlignment.spaceBetween
                    : MainAxisAlignment.start,
            children: List.generate(tabs.length, (index) {
              return Expanded(
                flex: isTwoTabs ? 1 : 1,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: isTwoTabs && index == 1 ? spacing : 0,
                    right:
                        isTwoTabs && index == 0
                            ? spacing
                            : (index != tabs.length - 1 ? spacing : 0),
                  ),
                  child: GestureDetector(
                    onTap: () => onTabSelected(tabs[index]),
                    child: Column(
                      children: [
                        Container(
                          padding: padding??const EdgeInsets.symmetric(vertical: 10),
                          width:
                              isTwoTabs
                                  ? screenWidth / 2.0
                                  : null, // Ensure full width for 2 tabs
                          decoration: BoxDecoration(
                            color:
                                selectedTab == tabs[index]
                                    ? ColorRes.primaryDark.withValues(alpha: 0.05)
                                    //? color ?? ColorRes.primaryDark.withValues(alpha: 0.02)
                                    : bgColor??ColorRes.lightTile.withValues(alpha: 0.0),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color:selectedTab == tabs[index]
                                ? ColorRes.primaryDark
                                : Colors.white)
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            tabs[index],
                            style: TextStyle(
                              color:
                                  selectedTab == tabs[index]
                                      ? ColorRes.primaryDark
                                      : Colors.black54,
                              fontSize: isTwoTabs ? 14 : 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        if (selectedTab == tabs[index]&& showSpeedBubble)
                          Visibility(
                            visible: false,
                            child: CustomPaint(
                              size: const Size(14, 8),
                              painter: SpeechBubblePainter(
                                color ?? ColorRes.primaryDark,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        );
      },
    ),
  );
}

// Widget commonFilterTabs({
//   required List<String> tabs,
//   required String selectedTab,
//   required Function(String) onTabSelected,
//   Color? color = ColorRes.primaryDark,
// }) {
//   return SingleChildScrollView(
//     scrollDirection: Axis.horizontal,
//     child: Row(
//       mainAxisAlignment: tabs.length == 2
//           ? MainAxisAlignment.spaceBetween // Space for 2 items
//           : MainAxisAlignment.start, // Align left for more than 2
//       children: tabs.map((tab) {
//         return Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 5),
//           child: GestureDetector(
//             onTap: () => onTabSelected(tab),
//             child: Column(
//               children: [
//                 Container(
//                   padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
//                   decoration: BoxDecoration(
//                     color: selectedTab == tab ? color ?? ColorRes.primaryDark : ColorRes.lightTile.withOpacity(0.2),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   alignment: Alignment.center,
//                   child: Text(
//                     tab,
//                     style: TextStyle(
//                       color: selectedTab == tab ? Colors.white : Colors.black54,
//                       fontSize: 14,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ),
//                 if (selectedTab == tab)
//                   CustomPaint(
//                     size: const Size(14, 8),
//                     painter: SpeechBubblePainter(color ?? ColorRes.primaryDark),
//                   ),
//               ],
//             ),
//           ),
//         );
//       }).toList(),
//     ),
//   );
// }

/*Widget commonFilterTabs({
  required List<String> tabs,
  required String selectedTab,
  required Function(String) onTabSelected,
  Color? color = ColorRes.primaryDark,
}) {
  return Row(
    mainAxisAlignment: tabs.length == 2
        ? MainAxisAlignment.spaceBetween // Space tabs apart for two items
        : MainAxisAlignment.center, // Default for more than two
    children: tabs.map((tab) {
      int index = tabs.indexOf(tab);
      return Expanded(
        child: GestureDetector(
          onTap: () => onTabSelected(tab),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                margin: EdgeInsets.only(left: index == 0 ? 0 : 10),
                decoration: BoxDecoration(
                  color: selectedTab == tab
                      ? color ?? ColorRes.primaryDark
                      : ColorRes.lightTile.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: Text(
                  tab,
                  style: TextStyle(
                    color: selectedTab == tab ? Colors.white : Colors.black54,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              if (selectedTab == tab)
                CustomPaint(
                  size: const Size(14, 8),
                  painter: SpeechBubblePainter(color ?? ColorRes.primaryDark),
                ),
            ],
          ),
        ),
      );
    }).toList(),
  );
}*/

/*Widget commonFilterTabs({
  required List<String> tabs,
  required String selectedTab,
  required Function(String) onTabSelected,
  Color? color=ColorRes.primaryDark
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: tabs.map((tab) {
      int index = tabs.indexOf(tab);
      return Expanded(
        child: GestureDetector(
          onTap: () => onTabSelected(tab),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                margin: EdgeInsets.only(left: index == 0 ? 0 : 10),
                decoration: BoxDecoration(
                  color: selectedTab == tab
                      ? color??ColorRes.primaryDark
                      : ColorRes.lightTile.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: Text(
                  tab,
                  style: TextStyle(
                    color: selectedTab == tab ? Colors.white : Colors.black54,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              if (selectedTab == tab)
                CustomPaint(
                  size: const Size(14, 8),
                  painter: SpeechBubblePainter(color??ColorRes.primaryDark),
                ),
            ],
          ),
        ),
      );
    }).toList(),
  );
}*/

// Widget commonFilterTabs({
//   required List<String> tabs,
//   required String selectedTab,
//   required Function(String) onTabSelected,
// }) {
//   return Row(
//     mainAxisAlignment: MainAxisAlignment.center,
//     children: tabs.map((tab) {
//       return Expanded(
//         child: GestureDetector(
//           onTap: () => onTabSelected(tab),
//           child: Column(
//             children: [
//               Container(
//                 padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
//                 margin: const EdgeInsets.symmetric(horizontal: 16),
//
//                 decoration: BoxDecoration(
//                   color: selectedTab == tab
//                       ? ColorRes.primaryDark
//                       : ColorRes.lightTile.withValues(alpha: 0.2),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 alignment: Alignment.center,
//                 child: Text(
//                   tab,
//                   style: TextStyle(
//                     color: selectedTab == tab ? Colors.white : Colors.black54,
//                     fontSize: 14,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ),
//               if (selectedTab == tab)
//                 CustomPaint(
//                   size: const Size(14, 8),
//                   painter: SpeechBubblePainter(ColorRes.primaryDark),
//                 ),
//             ],
//           ),
//         ),
//       );
//     }).toList(),
//   );
// }
