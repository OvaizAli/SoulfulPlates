import '../../../app_singleton.dart';
import '../../../constants/app_theme.dart';
import '../../../constants/enums/view_state.dart';
import '../../../controller/base_controller.dart';
import '../../../model/order_detail_model.dart';
import '../../../network/network_interfaces/end_points.dart';
import '../../../network/network_interfaces/i_dio_singleton.dart';
import '../../../network/network_utils/api_call.dart';
import '../../../utils/pagination_utils.dart';

class LiveOrdersController extends BaseController
    with PaginationUtils<OrderDetailModel> {
  OrderStatus orderStatus = OrderStatus.Pending;

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

    var result = await ApiCall().call<OrderDetailModel>(
        method: RequestMethod.getPost,
        endPoint: EndPoints.getOrdersForStore,
        apiCallType: ApiCallType.seller,
        obj: OrderDetailModel(),
        parameters: {
          "storeId": AppSingleton.storeId,
          // "userId": 1,
          "status": OrderStatus.Pending.name,
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
