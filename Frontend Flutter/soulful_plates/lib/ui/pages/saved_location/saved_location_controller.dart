import 'package:soulful_plates/controller/base_controller.dart';
import 'package:soulful_plates/model/location/address_model.dart';

import '../../../app_singleton.dart';
import '../../../constants/enums/view_state.dart';
import '../../../network/network_interfaces/end_points.dart';
import '../../../network/network_interfaces/i_dio_singleton.dart';
import '../../../network/network_utils/api_call.dart';
import '../../../utils/pagination_utils.dart';

class SavedLocationController extends BaseController
    with PaginationUtils<AddressModel> {
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
    var result = await ApiCall().call<AddressModel>(
      method: RequestMethod.get,
      endPoint:
          "${EndPoints.addAddress}/${AppSingleton.loggedInUserProfile?.id}",
      obj: AddressModel(),
      apiCallType: ApiCallType.seller,
    );
    //male api call her
    if (result != null) {
      List<AddressModel> temp = result;
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
