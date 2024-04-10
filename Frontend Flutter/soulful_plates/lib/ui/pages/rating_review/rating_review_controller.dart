import '../../../constants/enums/view_state.dart';
import '../../../controller/base_controller.dart';
import '../../../model/data_model.dart';

class RatingReviewController extends BaseController {
  DataModel? dataModel;

  @override
  void onInit() {
    super.onInit();
    getDataFromAPI();
  }

  void getDataFromAPI() async {
    setLoaderState(ViewStateEnum.busy);

    /*
    var result = ; //male api call here


    if (result.hasException) {
      //todo handle error
      setLoaderState(ViewStateEnum.idle);
      update();
      return;
    }

    if (result.data != null && result.data!.containsKey('data')) {
      DataModel? temp = DataModel.fromJson(result.data!['data']);
      //todo manage response
      if(temp!=null){
        dataModel = temp;
      }
      setLoaderState(ViewStateEnum.idle);
    } else {
      dataModel = null;
      setLoaderState(ViewStateEnum.idle);
    }*/
    update();
  }
}
