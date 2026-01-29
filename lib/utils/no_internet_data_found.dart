import 'package:flutter/material.dart';
import '../data/remote/dio/InternetStatusManager.dart';
import 'color_res.dart';

// class NoInternetDataFound extends StatefulWidget {
//   final bool isInternet;
//   final Widget child;
//   final Function() onTap;
//   const NoInternetDataFound({
//     super.key,
//     required this.isInternet,
//     required this.child,
//     required this.onTap,
//   });
//
//   @override
//   State<NoInternetDataFound> createState() => _NoInternetDataFoundState();
// }
//
// class _NoInternetDataFoundState extends State<NoInternetDataFound> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           widget.child,
//           if (!widget.isInternet) ...[
//             const Opacity(
//               opacity: 1.0,
//               child: ModalBarrier(dismissible: false, color: Colors.white),
//             ),
//           ],
//           if (!widget.isInternet) ...[
//             Column(
//               children: [
//                 SizedBox(height: ResponsiveHelper.getHeight(context) * 0.25),
//                 Center(child: Image.asset(AssetRes.noWifiImg, height: 200)),
//                 commonHt(height: 20),
//                 headingText('Whoops!!'),
//                 commonHt(height: 20),
//
//                 Padding(
//                   padding: EdgeInsets.symmetric(
//                     horizontal: ResponsiveHelper.getWidth(context) * 0.1,
//                   ),
//                   child: const Text(
//                     'No Internet connection was found. Check your connection or try again.',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w500,
//                       letterSpacing: 1.0,
//                       color: Color(0xff757575),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: ResponsiveHelper.getHeight(context) * 0.05),
//                 //commonButton(context, text: 'Try again', onTap:  () => debugPrint("on Pressed!"),)
//                 // commonButton(context, text: 'Try again', onTap:()=> ())
//                 // commonButton(context, text: 'Try again', onTap:()=> ())
//                 //commonButton(Text('Try again'), widget.onTap, 100)
//                 commonButtonRetry(const Text('Try again',style: TextStyle(color: Colors.white)), widget.onTap, 100),
//               ],
//             ),
//           ],
//         ],
//       ),
//     );
//   }
// }

// 3. UPDATED NoInternetDataFound WIDGET

class NoInternetDataFound extends StatefulWidget {
  final Widget child;
  final Function()? onRetry;

  const NoInternetDataFound({
    super.key,
    required this.child,
    this.onRetry,
  });

  @override
  State<NoInternetDataFound> createState() => _NoInternetDataFoundState();
}

class _NoInternetDataFoundState extends State<NoInternetDataFound> {
  final InternetStatusManager internetManager = InternetStatusManager();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: internetManager.isConnected,
      builder: (context, isConnected, child) {
        return Scaffold(
          body: Stack(
            children: [
              widget.child,
              if (!isConnected) ...[
                const Opacity(
                  opacity: 1.0,
                  child: ModalBarrier(dismissible: false, color: Colors.white),
                ),
                Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.25),
                    Center(child: Icon(Icons.signal_wifi_connected_no_internet_4_outlined,size: 100)),
                    const SizedBox(height: 20),
                    const Text(
                      'Whoops!!',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.1,
                      ),
                      child: const Text(
                        'No Internet connection was found. Check your connection or try again.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1.0,
                          color: Color(0xff757575),
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorRes.primaryDark,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8), // Rounded corners
                        ),
                      ),
                      onPressed: () async {
                        // Check internet connection
                        bool hasInternet = await internetManager.checkConnection();
                        if (hasInternet && widget.onRetry != null) {
                          widget.onRetry!();
                        }
                      },
                      child: const Text('Try again'),
                    ),
                  ],
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
