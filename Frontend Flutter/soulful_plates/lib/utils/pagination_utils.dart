import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/enums/view_state.dart';
import '../ui/widgets/base_loading_widget.dart';
import 'extensions.dart';
import 'utils.dart';

/*
  This is abstract class for pagination with getx just add this class to your utils
  extend it in the getx controller for pagination using below syntax
    "with PaginationUtils<DataModel>"
  Implement below methods in the controller with proper definitions.

  //Below methods should be as it is in this example
  @override
  void onInit() {
    super.onInit();
    initPagination();
  }

  //Below methods should be as it is in this example
  updateLoader(ViewStateEnum state) {
    if (pageNo >= 1) {
      moreLoading = state;
    } else {
      setLoaderState(state);
    }
  }

  //Below methods should be as it is in this example
  @override
  bool isLoading() {
    return state == ViewStateEnum.busy || moreLoading == ViewStateEnum.busy;
  }

  //Below methods should be as it is in this example
  @override
  void fetchData() {
    getDataFromAPI();
    update();
  }

  //Below methods should be as it is in this example
  @override
  void loadMore() {
    getDataFromAPI();
    update();
  }

  // Add your api call to this method for response and data conversation
  void getDataFromAPI() async {
      // When data is succeed put below logic for pagination and page change
      List<DataModel> temp =
      DataModel.fromJsonArray(result.data!['data']);
      if (temp.isEmpty || temp.length < recordsPerPage) {
        hasReachedMax = true;
      }
      if (pageNo == 0) {
        dataList.clear();
      }
      if (temp.isNotEmpty) {
        dataList.addAll(temp);
      }
  }
 */
mixin class PaginationUtils<T> {
  final ScrollController scrollController = ScrollController();
  List<T> dataList = [];
  dynamic data;

  bool hasReachedMax = false;
  int pageNo = 0;
  int recordsPerPage = 20;
  ViewStateEnum moreLoading = ViewStateEnum.idle;

  bool isLoading() {
    return true;
  }

  Widget emptyListWidget({required String listEmptyMessage, Color? color}) {
    return Utils.emptyRefreshListWidget(
        listEmptyMessage: listEmptyMessage,
        color: color,
        onTap: () {
          resetPagination();
        },
        isLoading: isLoading());
  }

  Widget loadMoreLoader({Color? color}) {
    return const Center(
      child: BaseLoadingWidget(),
    ).paddingAllDefault();
  }

  Widget endOfListMessage({required String paginationEndMessage}) {
    return Center(
      child: Text(paginationEndMessage),
    ).paddingAll16().visibleWhen(isVisible: dataList.length > 20);
  }

  // if api or fetch function needs some data to pass then set it as data.
  void setData({dynamic data}) async {
    this.data = data;
  }

  void initPagination({fetchOnInit = true}) async {
    dataList.clear();
    initScrollController();
    pageNo = 0;
    if (fetchOnInit) {
      fetchData();
    }
  }

  void fetchData() {}

  void loadMore() {}

  void resetPagination() {
    pageNo = 0;
    hasReachedMax = false;
    fetchData();
  }

  void initScrollController() {
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent &&
          !hasReachedMax &&
          !isLoading()) {
        pageNo = (pageNo + 1);
        loadMore();
      }
    });
  }
}

abstract class TabbedPaginationUtils<T> {
  final ScrollController scrollController1 = ScrollController();
  final ScrollController scrollController2 = ScrollController();
  List<T> dataList1 = [];
  List<T> dataList2 = [];
  dynamic data1, data2;

  bool hasReachedMax1 = false;
  bool hasReachedMax2 = false;

  int pageNo1 = 0;
  int pageNo2 = 0;

  int recordsPerPage = 20;
  ViewStateEnum moreLoading1 = ViewStateEnum.idle;
  ViewStateEnum moreLoading2 = ViewStateEnum.idle;

  bool isLoading1() {
    return true;
  }

  bool isLoading2() {
    return true;
  }

  Widget loadMoreLoader({Color? color}) {
    return const Center(
      child: BaseLoadingWidget(),
    ).paddingAllDefault();
  }

  // if api or fetch function needs some data to pass then set it as data.
  void setData1({dynamic data}) async {
    this.data1 = data;
  }

  void setData2({dynamic data}) async {
    this.data2 = data;
  }

  void initPagination1({fetchOnInit = true}) async {
    dataList1.clear();
    initScrollController1();
    pageNo1 = 0;
    if (fetchOnInit) {
      fetchData1();
    }
  }

  void initPagination2({fetchOnInit = true}) async {
    dataList2.clear();
    initScrollController2();
    pageNo2 = 0;
    if (fetchOnInit) {
      fetchData2();
    }
  }

  void fetchData1();

  void fetchData2();

  void loadMore1();
  void loadMore2();

  void resetPagination1() {
    pageNo1 = 0;
    hasReachedMax1 = false;
    fetchData1();
  }

  void resetPagination2() {
    pageNo2 = 0;
    hasReachedMax2 = false;
    fetchData2();
  }

  void initScrollController1() {
    scrollController1.addListener(() {
      if (scrollController1.position.pixels >=
              scrollController1.position.maxScrollExtent &&
          !hasReachedMax1 &&
          !isLoading1()) {
        pageNo1 = (pageNo1 + 1);
        loadMore1();
      }
    });
  }

  void initScrollController2() {
    scrollController2.addListener(() {
      if (scrollController2.position.pixels >=
              scrollController2.position.maxScrollExtent &&
          !hasReachedMax2 &&
          !isLoading2()) {
        pageNo2 = (pageNo2 + 1);
        loadMore2();
      }
    });
  }
}
