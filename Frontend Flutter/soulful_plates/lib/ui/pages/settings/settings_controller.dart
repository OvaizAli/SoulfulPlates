import '../../../app_singleton.dart';
import '../../../constants/enums/view_state.dart';
import '../../../controller/base_controller.dart';
import '../../../network/network_interfaces/end_points.dart';
import '../../../network/network_interfaces/i_dio_singleton.dart';
import '../../../network/network_utils/api_call.dart';
import '../../../utils/utils.dart';

class SettingsController extends BaseController {
  bool isNotificationEnabled = true;

  void updateNotificationStatus({data}) async {
    setLoaderState(ViewStateEnum.busy);
    var response = await ApiCall().call(
        method: RequestMethod.put,
        endPoint:
            "${EndPoints.updateNotificationStatus}/${AppSingleton.loggedInUserProfile?.id}",
        apiCallType: ApiCallType.seller,
        parameters: data);
    print("Response $response ");
    if (response != null && response['code'] == 1) {
      Utils.showSuccessToast(
          "Notification status has been updated successfully.", true);
    } else {
      setLoaderState(ViewStateEnum.idle);
      Utils.showSuccessToast(
          "Issue while updating notification. Please try again later.", false);
    }
    setLoaderState(ViewStateEnum.idle);
    update();
  }
}
