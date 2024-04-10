import 'package:soulful_plates/app_singleton.dart';
import 'package:soulful_plates/model/order_detail_model.dart';

import '../../../constants/app_theme.dart';
import '../../../constants/enums/view_state.dart';
import '../../../controller/base_controller.dart';
import '../../../network/network_interfaces/end_points.dart';
import '../../../network/network_interfaces/i_dio_singleton.dart';
import '../../../network/network_utils/api_call.dart';
import '../../../utils/pagination_utils.dart';

class HomeSellerController extends BaseController
    with PaginationUtils<OrderDetailModel> {
  @override
  void onInit() {
    super.onInit();
    print("This is current token ${AppSingleton.loggedInUserProfile?.id}");
    print(
        "This is current token ${AppSingleton.loggedInUserProfile?.sellerId}");
    print("This is current token ${AppSingleton.loggedInUserProfile?.token}");
    initPagination();
    fetchStatistics(3);
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

    var result = await ApiCall().call<OrderDetailModel>(
        method: RequestMethod.getPost,
        endPoint: EndPoints.getOrdersForStore,
        apiCallType: ApiCallType.seller,
        obj: OrderDetailModel(),
        parameters: {
          "storeId": AppSingleton.storeId,
          // "userId": 1,
          "status": OrderStatus.Pending.name,
          "limit": 4,
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

  double amount = 0;
  int orderCount = 0;

  void fetchStatistics(int month) async {
    setButtonLoaderState(ViewStateEnum.busy);
    var response = await ApiCall().call(
        method: RequestMethod.get,
        endPoint: EndPoints.getMonthlySummary,
        apiCallType: ApiCallType.seller,
        queryParameters: {"storeId": AppSingleton.storeId, "month": month});
    amount = response["totalAmount"];
    orderCount = response["totalOrders"];
    print("This is the stats ${response}");
    setButtonLoaderState(ViewStateEnum.idle);
  }

  changeOrderStatus(
      OrderDetailModel orderDetailModel, OrderStatus? status) async {
    orderDetailModel.setOrderStatus(status ?? OrderStatus.Completed);
    updateLoader(ViewStateEnum.busy);
    var response = await ApiCall().call(
        method: RequestMethod.post,
        endPoint: EndPoints.updateOrderStatus,
        apiCallType: ApiCallType.user,
        parameters: {
          "orderId": orderDetailModel.orderId,
          "status": status?.name ?? OrderStatus.Completed
        });
    // {"code":1,"description":"Order Created.","data":{"orderId":5}}
    print("Response $response ");
    updateLoader(ViewStateEnum.idle);
    update();
    resetPagination();
  }
}
