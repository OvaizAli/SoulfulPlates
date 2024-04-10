import 'package:soulful_plates/app_singleton.dart';

import '../../../constants/enums/view_state.dart';
import '../../../controller/base_controller.dart';
import '../../../model/store_details/restaurant_model.dart';
import '../../../network/network_interfaces/end_points.dart';
import '../../../network/network_interfaces/i_dio_singleton.dart';
import '../../../network/network_utils/api_call.dart';
import '../../../utils/pagination_utils.dart';

class HomeController extends BaseController
    with PaginationUtils<RestaurantModel> {
  @override
  void onInit() {
    super.onInit();
    initPagination();
  }

  // @override
  // int recordsPerPage = 2;

  updateLoader(ViewStateEnum state) {
    if (pageNo >= 1) {
      moreLoading = state;
    } else {
      setLoaderState(state);
    }
  }

  void getDataFromAPI() async {
    updateLoader(ViewStateEnum.busy);

    var response = await ApiCall().call<RestaurantModel>(
      method: RequestMethod.get,
      endPoint:
          "${EndPoints.getNearByStores}/${AppSingleton.loggedInUserProfile?.id}/200001",
      obj: RestaurantModel(),
      apiCallType: ApiCallType.seller,
    );

    if (response != null) {
      List<RestaurantModel> temp = response;
      if (temp.isEmpty || temp.length < recordsPerPage) {
        hasReachedMax = true;
      }
      if (pageNo == 0) {
        dataList.clear();
      }
      if (temp.isNotEmpty) {
        dataList.addAll(temp);
      }
      updateLoader(ViewStateEnum.idle);
    } else {
      dataList = [];
      updateLoader(ViewStateEnum.idle);
    }
    update();
  }

  @override
  bool isLoading() {
    return state == ViewStateEnum.busy || moreLoading == ViewStateEnum.busy;
  }

  @override
  void fetchData() {
    getDataFromAPI();
    update();
  }

  @override
  void loadMore() {
    getDataFromAPI();
    update();
  }

  int currentIndex = 0;

  final List<Items> imagesList = [
    Items(
      "https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg?cs=srgb&dl=pexels-ella-olsson-1640777.jpg&fm=jpg",
      "HomeFreshy",
    ),
    Items(
      "https://media.istockphoto.com/id/1457979959/photo/snack-junk-fast-food-on-table-in-restaurant-soup-sauce-ornament-grill-hamburger-french-fries.webp?b=1&s=170667a&w=0&k=20&c=A_MdmsSdkTspk9Mum_bDVB2ko0RKoyjB7ZXQUnSOHl0=",
      "Limon\'s Foods",
    ),
    Items(
      "https://www.eatingwell.com/thmb/m5xUzIOmhWSoXZnY-oZcO9SdArQ=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/article_291139_the-top-10-healthiest-foods-for-kids_-02-4b745e57928c4786a61b47d8ba920058.jpg",
      "GoodFoods",
    ),
  ];

  final List<String> imagesDetails = [
    "Limon\'s Foods",
    "HomeFreshy",
    "GoodFoods",
  ];
}

//
//   int currentIndex = 0;
//
//   final List<Items> imagesList = [
//     Items(
//       "https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg?cs=srgb&dl=pexels-ella-olsson-1640777.jpg&fm=jpg",
//       "HomeFreshy",
//     ),
//     Items(
//       "https://media.istockphoto.com/id/1457979959/photo/snack-junk-fast-food-on-table-in-restaurant-soup-sauce-ornament-grill-hamburger-french-fries.webp?b=1&s=170667a&w=0&k=20&c=A_MdmsSdkTspk9Mum_bDVB2ko0RKoyjB7ZXQUnSOHl0=",
//       "Limon\'s Foods",
//     ),
//     Items(
//       "https://www.eatingwell.com/thmb/m5xUzIOmhWSoXZnY-oZcO9SdArQ=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/article_291139_the-top-10-healthiest-foods-for-kids_-02-4b745e57928c4786a61b47d8ba920058.jpg",
//       "GoodFoods",
//     ),
//   ];
//
//   final List<String> imagesDetails = [
//     "Limon\'s Foods",
//     "HomeFreshy",
//     "GoodFoods",
//   ];
//
//
//   void getNearByStores() async {
//     updateLoader(ViewStateEnum.busy);
//     var response = await ApiCall().call<RestaurantModel>(
//       method: RequestMethod.get,
//       endPoint: "${EndPoints.getNearByStores}/${AppSingleton.loggedInUserProfile?.id}/2001",
//       obj: RestaurantModel(),
//       apiCallType: ApiCallType.seller,
//     );
//     print("Response $response ");
//     updateLoader(ViewStateEnum.idle);
//     update();
//   }
//
//
// }

class Items {
  String image;
  String name;
  Items(this.name, this.image);
}
