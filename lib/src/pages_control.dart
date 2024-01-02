
import 'package:page_s_index/page_s_index.dart';
import 'package:pages_elements/pages_elements.dart';


class PagesControlPanel {
  PagesCounter pagesCounter = PagesCounter();

  List<int> get indexList => pagesCounter.pagesIndex;

  ElementPages? rearengePageCounter(int index) {
    print(index);
    ElementPages? pagesAndNumber = pagesCounter.startOrExpand(index, false)!;
    return pagesAndNumber;
  }




}

