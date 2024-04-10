import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../constants/enums/view_state.dart';
import '../../../controller/base_controller.dart';
import '../../../model/data_model.dart';
import '../../../network/network_interfaces/end_points.dart';
import '../../../network/network_interfaces/i_dio_singleton.dart';
import '../../../network/network_utils/api_call.dart';

class CartPaymentController extends BaseController {
  DataModel? dataModel;
  final cardNumberController = TextEditingController();
  final fullNameController = TextEditingController();
  final cvvController = TextEditingController();
  final dateController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getDataFromAPI();
  }

  double subtotal = 0;
  double deliveryCharges = 0;
  double tax = 0;
  double total = 0;
  int orderId = 0;

  void getDataFromAPI() async {
    setLoaderState(ViewStateEnum.busy);
    var data = Get.arguments;

    subtotal = data['subtotal'];
    deliveryCharges = data['deliveryCharges'];
    tax = data['tax'];
    total = data['total'];
    orderId = data['orderId'];
    print("THis is order id $orderId");
    setLoaderState(ViewStateEnum.idle);
    update();
  }

  createPayment({data}) async {
    setLoaderState(ViewStateEnum.busy);
    var response = await ApiCall().call(
        method: RequestMethod.post,
        endPoint: EndPoints.createPayment,
        apiCallType: ApiCallType.user,
        parameters: data);
    // {"code":1,"description":"Order Created.","data":{"orderId":5}}
    print("Response $response ");
    setLoaderState(ViewStateEnum.idle);
    update();
  }
}
