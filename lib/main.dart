import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:services_provider_application/controllers/chat_controller.dart';
import 'package:services_provider_application/controllers/transport_controller.dart';
import 'package:services_provider_application/views/buyer/controllers/address_controller.dart';
import 'package:services_provider_application/views/buyer/controllers/bargain_controller.dart';
import 'package:services_provider_application/views/buyer/controllers/cart_controller.dart';
import 'package:services_provider_application/views/buyer/controllers/checkout_controller.dart';
import 'package:services_provider_application/views/buyer/controllers/product_details_controller.dart';
import 'package:services_provider_application/views/buyer/controllers/profile_controller.dart';
import 'package:services_provider_application/views/buyer/controllers/store_controller.dart';
import 'package:services_provider_application/views/splash_view.dart';
import 'package:services_provider_application/views/seller/controllers/add_product_controller.dart';
import 'package:services_provider_application/views/seller/controllers/add_shop_controller.dart';
import 'package:services_provider_application/views/seller/controllers/category_controller.dart';
import 'package:services_provider_application/views/seller/controllers/seller_bargain_controller.dart';
import 'package:services_provider_application/views/seller/controllers/seller_home_controller.dart';
import 'constants.dart';
import 'controllers/category_controller.dart';
import 'controllers/order_history_controller.dart';
import 'controllers/products_controller.dart';
import 'controllers/splash_controller.dart';
import 'views/buyer/controllers/home_view_controller.dart';
import 'views/buyer/controllers/pending_order_controller.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  FirebaseMessaging.instance.getInitialMessage().then(
        (value) => FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    }),
  );
}

final box = GetStorage();
final myConstants = Constants();
var customerHomeControl = Get.put(HomeViewController());
var catControl = Get.put(CategoryController());
var addShopController = Get.put(AddShopController());
var productController = Get.put(SellerProductsController());
var homeSellerController = Get.put(SellerHomeController());
var sizeController = Get.put(AddProductController());
var sellerCatController = Get.put(SellerCategoryController());
var cartController = Get.put(CartController());
var checkoutController = Get.put(CheckoutController());
var customerProfileControl = Get.put(CustomerProfileController());
var transportControl = Get.put(TransportController());
var customerAddControl = Get.put(CustomerAddressController());
var customerHistoryControl = Get.put(OrderHistoryController());
var customerPendingOrderControl = Get.put(PendingOrderController());
var customerProductDetailControl = Get.put(CustomerProductDetailsController());
var customerBargainControl = Get.put(CustomerBargainController());
var sellerBargainControl = Get.put(SellerBargainController());
var storeInCustomerControl = Get.put(StoreInBuyerController());
var splashControl = Get.put(SplashController());
var chatControl = Get.put(ChatController());


// class MyHttpOverrides extends HttpOverrides{
//   @override
//   HttpClient createHttpClient(SecurityContext? context){
//     return super.createHttpClient(context)
//       ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
//   }
// }


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp();

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      useDefaultLoading: false,
      overlayWidget: Center(
        child: CircularProgressIndicator(color: Color(0xFFF5951D)),
      ),
      overlayColor: Colors.black12,
      overlayOpacity: 0.8,
      child: ScrollConfiguration(
        behavior: MyBehavior(),
        child: ResponsiveSizer(builder: (context, orientation, screenType) {
          return GetMaterialApp(
            onInit: () {
              EasyLoading.instance
                ..displayDuration = const Duration(seconds: 3)
                ..maskColor = Colors.black54
                ..maskType = EasyLoadingMaskType.custom
                ..loadingStyle = EasyLoadingStyle.light
                ..backgroundColor = Colors.transparent
                ..userInteractions = false
                ..dismissOnTap = false;


              FirebaseMessaging.onMessage.listen((RemoteMessage message) {
                print('Got a message whilst in the foreground!');
                print('Message data: ${message.data}');

                if (message.notification != null) {
                  print('Message also contained a notification: ${message.notification}');
                  Get.snackbar(message.notification!.title!, message.notification!.body!,backgroundColor: Colors.white,instantInit: true,duration: Duration(seconds: 3));
                }
              });
            },
            title: 'Steeldeals',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              useMaterial3: true,
              primaryColor: Color(0xFFF5951D),
              scaffoldBackgroundColor: Colors.white,
              textButtonTheme: TextButtonThemeData(
                  style: ButtonStyle(
                padding: MaterialStateProperty.all(
                  EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
                ),
              )),
              fontFamily: 'gilroy',
            ),
            builder: EasyLoading.init(),
            home: SplashView(),
          );
        }),
      ),
    );
  }
}
