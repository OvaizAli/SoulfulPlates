import 'package:soulful_plates/constants/app_theme.dart';

import '../../../app_singleton.dart';
import '../../../constants/enums/view_state.dart';
import '../../../controller/base_controller.dart';
import '../../../model/order_detail_model.dart';
import '../../../network/network_interfaces/end_points.dart';
import '../../../network/network_interfaces/i_dio_singleton.dart';
import '../../../network/network_utils/api_call.dart';
import '../../../utils/pagination_utils.dart';

class OrderHistoryBuyerController extends BaseController
    with PaginationUtils<OrderDetailModel> {
  OrderStatus orderStatus = OrderStatus.Pending;

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

    var result = await ApiCall().call<OrderDetailModel>(
        method: RequestMethod.getPost,
        endPoint: EndPoints.getOrdersForUser,
        apiCallType: ApiCallType.user,
        obj: OrderDetailModel(),
        parameters: {
          "userId": AppSingleton.loggedInUserProfile?.id,
          "status": orderStatus.name,
          "limit": recordsPerPage,
          "offset": pageNo
        }); //male api call here

    if (result != null) {
      List<OrderDetailModel> temp = result;
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
}
