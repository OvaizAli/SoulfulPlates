import 'package:flutter/cupertino.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:soulful_plates/model/order_detail_model.dart';

import '../../../constants/enums/view_state.dart';
import '../../../controller/base_controller.dart';
import '../../../network/network_interfaces/end_points.dart';
import '../../../network/network_interfaces/i_dio_singleton.dart';
import '../../../network/network_utils/api_call.dart';

class OrderDetailController extends BaseController {
  OrderDetailModel? orderDetailModel;
  final feedbackController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    orderDetailModel = Get.arguments;
    // getDataFromAPI();
  }

  void createRating({data}) async {
    setLoaderState(ViewStateEnum.busy);
    var response = await ApiCall().call(
        method: RequestMethod.post,
        endPoint: EndPoints.createRating,
        apiCallType: ApiCallType.user,
        parameters: data);
    // {"code":1,"description":"Order Created.","data":{"orderId":5}}
    print("Response $response ");
    setLoaderState(ViewStateEnum.idle);
    update();
  }
}
