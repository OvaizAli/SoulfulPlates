import 'package:soulful_plates/app_singleton.dart';

import '../../../constants/enums/view_state.dart';
import '../../../controller/base_controller.dart';
import '../../../model/wishlist_model.dart';
import '../../../network/network_interfaces/end_points.dart';
import '../../../network/network_interfaces/i_dio_singleton.dart';
import '../../../network/network_utils/api_call.dart';
import '../../../utils/pagination_utils.dart';

class WishlistController extends BaseController
    with PaginationUtils<WishlistModel> {
  @override
  void onInit() {
    super.onInit();
    initPagination();
  }

  updateLoader(ViewStateEnum state) {
    if (pageNo >= 1) {
      moreLoading = state;
    } else {
      setLoaderState(state);
    }
  }

  void getDataFromAPI() async {
    updateLoader(ViewStateEnum.busy);

    var result = await ApiCall().call<WishlistModel>(
      method: RequestMethod.get,
      endPoint:
          "${EndPoints.getWishList}/${AppSingleton.loggedInUserProfile?.id}",
      obj: WishlistModel(),
      apiCallType: ApiCallType.user,
    );

    if (result != null) {
      List<WishlistModel> temp = result;
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

  void deleteWishlist(int wishId) async {
    var response = await ApiCall().call(
        method: RequestMethod.delete,
        endPoint: "${EndPoints.deleteWishList}/$wishId",
        apiCallType: ApiCallType.user,
        parameters: {
          "userId": AppSingleton.loggedInUserProfile?.id,
        });
    resetPagination();
  }
}
