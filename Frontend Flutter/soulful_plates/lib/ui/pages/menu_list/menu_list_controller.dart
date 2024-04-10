import '../../../constants/enums/view_state.dart';
import '../../../controller/base_controller.dart';
import '../../../model/menu/menu_category_model.dart';
import '../../../model/menu/menu_model.dart';
import '../../../network/network_interfaces/end_points.dart';
import '../../../network/network_interfaces/i_dio_singleton.dart';
import '../../../network/network_utils/api_call.dart';
import '../../../utils/pagination_utils.dart';
import '../../../utils/utils.dart';

class MenuListController extends BaseController
    with PaginationUtils<MenuCategory> {
  @override
  void onInit() {
    super.onInit();
    initPagination();
  }

  updateMenuItemStatus(MenuModel menuModel) async {
    setLoaderState(ViewStateEnum.busy);
    var response = await ApiCall().call<MenuModel>(
        method: RequestMethod.put,
        endPoint: "${EndPoints.addMenuItem}/${menuModel.itemId}",
        obj: MenuModel(),
        apiCallType: ApiCallType.seller,
        parameters: menuModel.toJson());
    resetPagination();
    setLoaderState(ViewStateEnum.idle);
    update();
  }

  @override
  bool isLoading() {
    return state == ViewStateEnum.busy || moreLoading == ViewStateEnum.busy;
  }

  @override
  void fetchData() async {
    await Utils.fetchUpdatedMenuItemList(setLoaderState);
    dataList = Utils.menuCategory;
    setLoaderState(ViewStateEnum.idle);
    update();
  }

  @override
  void loadMore() {
    // getDataFromAPI();
    update();
  }
}
