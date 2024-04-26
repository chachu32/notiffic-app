import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WarnPage extends StatefulWidget {
  const WarnPage({super.key});

  @override
  State<WarnPage> createState() => _WarnPageState();
}

class _WarnPageState extends State<WarnPage> {
  final controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith('https://console.firebase.google.com/project/police-d509c/storage/police-d509c.appspot.com/files')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    )
    ..loadRequest(Uri.parse('https://console.firebase.google.com/project/ambulance-e1636/messaging'));

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Handle the back button press
        // You can add your custom logic here, for example showing a confirmation dialog
        // Return true to allow the app to be popped, false to prevent it
        return showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Exit App?'),
              content: const Text('Do you want to exit the app?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('Yes'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('No'),
                ),
              ],
            );
          },
        ).then((value) => value ?? false); // Return false if showDialog returns null
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255,67,91,91),
          title: const Text(
            'Police',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Stack(
          children: [
            WebViewWidget(controller: controller),
            Positioned(
              bottom: 5.0,
              right: 5.0,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/message');
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  backgroundColor: Color.fromARGB(255, 106, 155, 155),
                  fixedSize:const Size(90.0, 20.0),
                ).copyWith(
                  overlayColor: MaterialStateProperty.resolveWith<Color>(
                    (states) {
                      if (states.contains(MaterialState.hovered)) {
                        return const Color.fromARGB(255, 41, 159, 189);
                      }
                      return Colors.blue;
                    },
                  ),
                ),
                child: const Text('reload',style: TextStyle(color: Colors.white),),
              ),
            ),
            Positioned(
              bottom: 5.0,
              right: 110.0,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/upload');
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  backgroundColor: Color.fromARGB(255, 106, 155, 155),
                  fixedSize:const Size(100.0, 20.0),
                ).copyWith(
                  overlayColor: MaterialStateProperty.resolveWith<Color>(
                    (states) {
                      if (states.contains(MaterialState.hovered)) {
                        return const Color.fromARGB(255, 41, 159, 189);
                      }
                      return Colors.blue;
                    },
                  ),
                ),
                child: const Text('upload',style: TextStyle(color: Colors.white),),
              ),
            ),
           
          ],
        ),
      ),
    );
  }
}
