/*
 * Project Name:  [mKolon3.0] - SalesPortal
 * File: /Users/bakbeom/work/sm/si/SalesPortal/lib/util/hive_select_data_util.dart
 * Created Date: 2021-09-24 15:54:09
 * Last Modified: 2021-12-17 17:12:24
 * Author: bakbeom
 * Modified By: bakbeom
 * copyright @ 2021  KOLON GROUP. ALL RIGHTS RESERVED. 
 * ---	---	---	---	---	---	---	---	---	---	---	---	---	---	---	---
 * 												Discription													
 * ---	---	---	---	---	---	---	---	---	---	---	---	---	---	---	---
 */
import 'package:salesworxm/enums/common_code_return_type.dart';
import 'package:salesworxm/enums/hive_box_type.dart';
import 'package:salesworxm/enums/popup_cell_type.dart';
import 'package:salesworxm/model/commonCode/cell_model.dart';
import 'package:salesworxm/model/commonCode/t_code_model.dart';
import 'package:salesworxm/model/commonCode/t_values_model.dart';
import 'package:salesworxm/service/hive_service.dart';
import 'package:salesworxm/util/format_util.dart';
import 'package:salesworxm/model/commonCode/et_dd07v_customer_category_model.dart';

typedef SearchTcodeConditional = bool Function(TCodeModel);
typedef SearchTvalueConditional = bool Function(TValuesModel);
typedef TcodeResultCondition = String Function(TCodeModel);
typedef EtCustomerResultCondition = CellModel Function(EtDd07vCustomerModel);

class HiveSelectDataUtil {
  static Future<HiveSelectResult> select(
    HiveBoxType type, {
    SearchTcodeConditional? tcodeConditional,
    SearchTvalueConditional? tvalueConditional,
    SearchEtDd07vCustomerConditional? etDd07vCustomerConditional,
    TcodeResultCondition? tcodeResultCondition,
    EtCustomerResultCondition? etCustomerResultCondition,
    CommonCodeReturnType? returnType,
    String? group0SearchKey,
    String? group1SearchKey,
    String? group2SearchKey,
    String? group3SearchKey,
    String? group4SearchKey,
    int? searchLevel,
    bool? isMatchGroup1KeyList,
    bool? isMatchGroup2KeyList,
    bool? isMatchGroup3KeyList,
    bool? isMatchGroup4KeyList,
    bool? isMatchGroup1ValueList,
    bool? isMatchGroup2ValueList,
    bool? isMatchGroup3ValueList,
    bool? isMatchGroup4ValueList,
    String? threeCellSearchKey,
    ThreeCellType? threeCellType,
  }) async {
    if (type == HiveBoxType.T_CODE) {
      await HiveService.init(HiveBoxType.T_CODE);
      await HiveService.getBox();
    }
    if (type == HiveBoxType.T_VALUE) {
      await HiveService.init(HiveBoxType.T_VALUE);
      await HiveService.getBox();
    }
    if (type == HiveBoxType.T_VALUE_COUNTRY) {
      await HiveService.init(HiveBoxType.T_VALUE_COUNTRY);
      await HiveService.getBox();
    }
    if (type == HiveBoxType.ET_CUSTOMER_CATEGORY) {
      await HiveService.init(HiveBoxType.ET_CUSTOMER_CATEGORY);
      await HiveService.getBox();
    }
    if (type == HiveBoxType.ET_CUSTOMER_CUSTOMS_INFO) {
      await HiveService.init(HiveBoxType.ET_CUSTOMER_CUSTOMS_INFO);
      await HiveService.getBox();
    }

    final result = await HiveService.getData(
        searchTvalueConditional: tvalueConditional,
        searchTcodeConditional: tcodeConditional,
        searchEtDd07vCustomerConditional: etDd07vCustomerConditional);
    if (result == null) return HiveSelectResult();

    List<String> group1 = [];
    List<String> group1Value = [];
    List<String> group2 = [];
    List<String> group2Value = [];
    List<String> group3 = [];
    List<String> group3Value = [];
    List<String> group4 = [];
    List<String> group4Value = [];
    List<int> indexList = [];
    List<int> indexList2 = [];
    List<int> indexList3 = [];
    List<int> indexList4 = [];
    List<String> resultList = [];
    List<CellModel> cellResult = [];

    var clearData = () {
      group1.clear();
      group1Value.clear();
      indexList.clear();
      group2.clear();
      group2Value.clear();
      indexList2.clear();
      group3.clear();
      group3Value.clear();
      indexList3.clear();
      group4.clear();
      group4Value.clear();
      indexList4.clear();
    };

    var group1CellProssess = () {
      result as List<TValuesModel>;

      result.forEach((tvalue) {
        if (tvalue.helpValues!.trim().contains(' ')) {
          group1.add(FormatUtil.subToStartSpace(tvalue.helpValues!));
          group1Value.add(FormatUtil.subToEndSpace(tvalue.helpValues!));
        } else {
          group1.add(tvalue.helpValues!.trim());
          group1Value.add(' ');
        }
      });
      // 2
    };
    var group2CellProssess = () {
      group1Value.asMap().entries.forEach((tvalueMap) {
        if (tvalueMap.value.trim().contains(' ')) {
          group2.add(FormatUtil.subToStartSpace(tvalueMap.value));
          group2Value.add(FormatUtil.subToEndSpace(tvalueMap.value));
        } else {
          group2.add(tvalueMap.value.trim());
          group2Value.add(' ');
        }
      });
    };
    var group3CellProssess = () {
      assert(group2.length == group2Value.length);
      if (threeCellType == ThreeCellType.GET_COUNTRY_KR ||
          threeCellType == ThreeCellType.GET_COUNTRY) {
        group2Value.asMap().entries.forEach((tvalueMap) {
          if (tvalueMap.value != ' ') {
            var beforeRemoveSpace = tvalueMap.value.trim();
            if (beforeRemoveSpace.contains(group2[tvalueMap.key])) {
              beforeRemoveSpace = beforeRemoveSpace
                  .substring(beforeRemoveSpace.indexOf(group2[tvalueMap.key]));
              if (beforeRemoveSpace == group2[tvalueMap.key]) {
                group3.add(beforeRemoveSpace);
              } else {
                beforeRemoveSpace = beforeRemoveSpace.substring(
                    beforeRemoveSpace.indexOf(group2[tvalueMap.key]));
                beforeRemoveSpace.trim();
                group3.add(beforeRemoveSpace);
              }
            } else {
              group3.add(group2[tvalueMap.key]);
            }
          } else {
            group3.add(' ');
          }
        });
        assert(
            group1.length == group2.length && group2.length == group3.length);
      }
      print(threeCellType);
      if (threeCellType == ThreeCellType.GET_COUNTRY_AREA) {}
    };

// group 0

    var group0Prossess = () {
      if (group0SearchKey != null) {
        group1Value.asMap().entries.forEach((dataMap) {
          if (dataMap.value == group0SearchKey) {
            resultList.add(group1[dataMap.key]);
          }
        });
      } else {
        resultList = group1Value;
      }
      return HiveSelectResult(strList: resultList);
    };

    // group 1
    var group1Prossess = () {
      resultList.forEach((value) {
        if (value.trim().contains(' ')) {
          group1.add(FormatUtil.subToStartSpace(value));
          group1Value.add(FormatUtil.subToEndSpace(value));
        }
      });
      if (isMatchGroup1KeyList != null && isMatchGroup1KeyList) {
        group1Value.asMap().entries.forEach((map) {
          if (map.value == group1SearchKey) {
            indexList.add(map.key);
          }
        });
      } else if (group1SearchKey != null) {
        group1.asMap().entries.forEach((map) {
          if (map.value == group1SearchKey) {
            indexList.add(map.key);
          }
        });
      } else {
        group1.asMap().entries.forEach((map) {
          indexList.add(map.key);
        });
      }
      indexList.forEach((index) {
        if (isMatchGroup1KeyList != null && isMatchGroup1KeyList) {
          resultList.add(group1[index]);
        } else {
          resultList.add(group1Value[index]);
        }
      });
    };
    // group 2
    var group2Prossess = () {
      resultList.forEach((value) {
        if (value.trim().contains(' ')) {
          group2.add(FormatUtil.subToStartSpace(value));
          group2Value.add(FormatUtil.subToEndSpace(value));
        }
      });
      if (isMatchGroup2KeyList != null && isMatchGroup2KeyList) {
        group2Value.asMap().entries.forEach((map) {
          if (map.value == group2SearchKey) {
            indexList2.add(map.key);
          }
        });
      } else {
        if (group2SearchKey != null) {
          group2.asMap().entries.forEach((map) {
            if (map.value == group2SearchKey) {
              indexList2.add(map.key);
            }
          });
        } else {
          group2.asMap().entries.forEach((map) {
            indexList2.add(map.key);
          });
        }
      }
      resultList.clear();
      indexList2.forEach((index) {
        if (isMatchGroup2KeyList != null && isMatchGroup2KeyList) {
          resultList.add(group2[index]);
        } else {
          resultList.add(group2Value[index]);
        }
      });
    };

    // group 3
    var group3Prossess = () {
      resultList.forEach((value) {
        if (value.trim().contains(' ')) {
          group3.add(FormatUtil.subToStartSpace(value));
          group3Value.add(FormatUtil.subToEndSpace(value));
        }
      });
      // assert(group2Value.length == group1Value.length);
      if (isMatchGroup3KeyList != null && isMatchGroup3KeyList) {
        group3Value.asMap().entries.forEach((map) {
          if (map.value == group3SearchKey) {
            indexList3.add(map.key);
          }
        });
      } else {
        if (group3SearchKey != null) {
          group3.asMap().entries.forEach((map) {
            if (map.value == group3SearchKey) {
              indexList3.add(map.key);
            }
          });
        } else {
          group3.asMap().entries.forEach((map) {
            indexList3.add(map.key);
          });
        }
      }
      resultList.clear();
      indexList3.forEach((index) {
        if (isMatchGroup3KeyList != null && isMatchGroup3KeyList) {
          resultList.add(group3[index]);
        } else {
          resultList.add(group3Value[index]);
        }
      });
    };

    var group4Prossess = () {
      resultList.forEach((value) {
        if (value.trim().contains(' ')) {
          group4.add(FormatUtil.subToStartSpace(value));
          group4Value.add(FormatUtil.subToEndSpace(value));
        }
      });
      // assert(group2Value.length == group1Value.length);
      if (isMatchGroup4KeyList != null && isMatchGroup4KeyList) {
        group4Value.asMap().entries.forEach((map) {
          if (map.value == group4SearchKey) {
            indexList4.add(map.key);
          }
        });
      } else {
        if (group4SearchKey != null) {
          group4.asMap().entries.forEach((map) {
            if (map.value == group4SearchKey) {
              indexList4.add(map.key);
            }
          });
        } else {
          group4.asMap().entries.forEach((map) {
            indexList4.add(map.key);
          });
        }
      }
      resultList.clear();
      indexList4.forEach((index) {
        if (isMatchGroup4KeyList != null && isMatchGroup4KeyList) {
          resultList.add(group4[index]);
        } else {
          resultList.add(group4Value[index]);
        }
      });
    };

    /// entry point!
    /// entry point!
    /// entry point!
    if (tvalueConditional != null) {
      result as List<TValuesModel>;

      if (threeCellType != null) {
        switch (threeCellType) {
          case ThreeCellType.GET_COUNTRY_KR:
            group1CellProssess.call();
            group2CellProssess.call();
            group3CellProssess.call();
            group1.asMap().entries.forEach((map) {
              if (map.value.contains('KR')) {
                cellResult.add(CellModel(
                    column1: map.value,
                    column2: group2[map.key],
                    column3: group3[map.key]));
              }
            });
            break;

          case ThreeCellType.GET_COUNTRY:
            group1CellProssess.call();
            group2CellProssess.call();
            group3CellProssess.call();
            group1.asMap().entries.forEach((map) {
              cellResult.add(CellModel(
                  column1: map.value,
                  column2: group2[map.key],
                  column3: group3[map.key]));
            });
            break;
          case ThreeCellType.GET_COUNTRY_AREA:
            group1CellProssess.call();
            group2CellProssess.call();
            if (threeCellSearchKey != null) {
              group1.asMap().entries.forEach((map) {
                if (map.value == threeCellSearchKey) {
                  cellResult.add(CellModel(
                      column1: map.value,
                      column2: group2[map.key],
                      column3: group2Value[map.key]));
                }
              });
            }
            break;
          // ok
          case ThreeCellType.GET_COUNTRY_AREA_KR:
            group1CellProssess.call();
            group2CellProssess.call();
            if (threeCellSearchKey != null) {
              group1.asMap().entries.forEach((map) {
                if (map.value == threeCellSearchKey) {
                  cellResult.add(CellModel(
                      column1: map.value,
                      column2: group2[map.key],
                      column3: group2Value[map.key]));
                }
              });
            }
            break;
          case ThreeCellType.SEARCH_CUSTOMER_DELEV_AREA:
            group1CellProssess.call();
            group2CellProssess.call();
            group3CellProssess.call();
            group1.asMap().entries.forEach((map) {
              cellResult.add(CellModel(
                  column1: map.value,
                  column2: group2[map.key],
                  column3: group3[map.key]));
            });
            break;
          default:
        }

        return HiveSelectResult(cellList: cellResult);
      }
      if (returnType != null && returnType == CommonCodeReturnType.ALL) {
        result.forEach((tvalue) {
          if (tvalue.helpValues!.contains(' ')) {
            resultList.add(tvalue.helpValues!);
          }
        });
        return HiveSelectResult(strList: resultList);
      }
      result.forEach((tvalue) {
        if (tvalue.helpValues != null) {
          if (tvalue.helpValues!.contains(' ')) {
            group1.add(FormatUtil.subToStartSpace(tvalue.helpValues!));
            group1Value.add(FormatUtil.subToEndSpace(tvalue.helpValues!));
          }
        }
      });
      if (searchLevel != null && searchLevel == 0) {
        group0Prossess.call();
      } else {
        if (searchLevel != null && searchLevel == 1) {
          group1Prossess.call();
        } else if (searchLevel != null && searchLevel == 2) {
          group1Prossess.call();
          group2Prossess.call();
        } else if (searchLevel != null && searchLevel == 3) {
          group1Prossess.call();
          group2Prossess.call();
          group3Prossess.call();
        } else if (searchLevel != null && searchLevel == 4) {
          group1Prossess.call();
          group2Prossess.call();
          group3Prossess.call();
          group4Prossess.call();
        }
      }
    }
    if (tcodeConditional != null && tcodeResultCondition != null) {
      clearData.call();
      result as List<TCodeModel>;
      result.forEach((tcode) {
        resultList.add(tcodeResultCondition.call(tcode));
      });
    }

    if (etDd07vCustomerConditional != null &&
        etCustomerResultCondition != null) {
      result as List<EtDd07vCustomerModel>;

      result.forEach((etCategory) {
        cellResult.add(etCustomerResultCondition.call(etCategory));
      });
    }
    if (returnType != null && returnType == CommonCodeReturnType.KEY) {
      // default로 검색결과의 value를 반완합니다.
      // 검색결과의 key 값이 필요할때 사용하는 Function입니다.
      // group 별 조회 조건이 걸어 있기 때문에  최종 조회결과에서 혜당group의 key값을 select합니다.
      // 예: group1 의 KeyList 에서 조건에 맞는 내용 검색,
      //     group2 의 ValueList에서 조건에 맞는 내용 검색.
      //     group3의  ValueList에서 조건에 맞는 내용 검색.
      //     최종결과의 KeyList를 받환.

      switch (searchLevel) {
        case 0:
          resultList.clear();
          resultList.addAll(group1);
          break;
        case 1:
          resultList.clear();
          indexList.forEach((index) {
            resultList.add(group1[index]);
          });
          break;
        case 2:
          resultList.clear();
          indexList2.forEach((index) {
            resultList.add(group2[index]);
          });
          break;
        case 3:
          resultList.clear();
          indexList3.forEach((index) {
            resultList.add(group3[index]);
          });
          break;
        case 4:
          resultList.clear();
          indexList4.forEach((index) {
            resultList.add(group4[index]);
          });
          break;
        default:
      }
    }
    return HiveSelectResult(strList: resultList, cellList: cellResult);
  }
}

class HiveSelectResult {
  List<String>? strList;
  List<CellModel>? cellList;
  HiveSelectResult({
    this.cellList,
    this.strList,
  });
}
