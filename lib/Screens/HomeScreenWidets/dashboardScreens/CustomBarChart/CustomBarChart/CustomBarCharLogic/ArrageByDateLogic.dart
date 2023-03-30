import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ghioon_seller/Providers/language_provider.dart';
import 'package:ghioon_seller/Shared/language.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ArrageByDateLogic {
  List listForEachDate = [];
  List<List> listOfDateLists = [];
  int max = 0;
  maxNumber() {
    return max;
  }

  calculation(completeOrders, item, context) {
    var languageprov = Provider.of<LanguageProvider>(context);
    listOfDateLists = [];
    listForEachDate = [];
    //Make sure that there are documents within firebase
    if (completeOrders.length != 0) {
      //Adding the first document manually so that
      //the forloop section has something to compare dates
      //This listForEachDate is for storing a collection
      //of all documents of one date
      listForEachDate = [completeOrders[0]];
      //listOfDateLists is a list of all listForEachDate
      //This gives us a list of lists with the documents
      //separated by date i.e.
      //[[date1, date1], [date2], [date3, date3, date3], etc]
      listOfDateLists = [];

      //i = 1 because index 0 already added above
      for (int i = 1; i < completeOrders.length; i++) {
        DateTime myDateTimei = completeOrders[i].toDate();
        DateTime myDateTimei_1 = completeOrders[i - 1].toDate();
        var myDateTimeii = DateFormat.yMd().format(myDateTimei);
        var myDateTimeii_1 = DateFormat.yMd().format(myDateTimei_1);
        if (item == Language().day[languageprov.LanguageIndex]) {
          myDateTimeii = DateFormat.yMd().format(myDateTimei);
          myDateTimeii_1 = DateFormat.yMd().format(myDateTimei_1);
        } else if (item == Language().week[languageprov.LanguageIndex]) {
          myDateTimeii = DateFormat.d().format(myDateTimei);
          if (int.parse(myDateTimeii) >= 1 && int.parse(myDateTimeii) <= 7) {
            myDateTimeii = '1';
          } else if (int.parse(myDateTimeii) >= 8 &&
              int.parse(myDateTimeii) <= 14) {
            myDateTimeii = '2';
          } else if (int.parse(myDateTimeii) >= 15 &&
              int.parse(myDateTimeii) <= 21) {
            myDateTimeii = '3';
          } else if (int.parse(myDateTimeii) >= 22 &&
              int.parse(myDateTimeii) <= 31) {
            myDateTimeii = '4';
          }
          myDateTimeii_1 = DateFormat.d().format(myDateTimei_1);
          if (int.parse(myDateTimeii_1) >= 1 &&
              int.parse(myDateTimeii_1) <= 7) {
            myDateTimeii_1 = '1';
          } else if (int.parse(myDateTimeii_1) >= 8 &&
              int.parse(myDateTimeii_1) <= 14) {
            myDateTimeii_1 = '2';
          } else if (int.parse(myDateTimeii_1) >= 15 &&
              int.parse(myDateTimeii_1) <= 21) {
            myDateTimeii_1 = '3';
          } else if (int.parse(myDateTimeii_1) >= 22 &&
              int.parse(myDateTimeii_1) <= 31) {
            myDateTimeii_1 = '4';
          }
        } else if (item == Language().month[languageprov.LanguageIndex]) {
          myDateTimeii = DateFormat.MMMM().format(myDateTimei);
          myDateTimeii_1 = DateFormat.MMMM().format(myDateTimei_1);
        } else if (item == Language().year[languageprov.LanguageIndex]) {
          myDateTimeii = DateFormat.y().format(myDateTimei);
          myDateTimeii_1 = DateFormat.y().format(myDateTimei_1);
        }

        //If the current index's date matches that of the previous
        //index's date, then add it to the listForEachDate
        if (myDateTimeii == myDateTimeii_1) {
          listForEachDate.add(completeOrders[i]);
          if (listForEachDate.length > max) {
            max = listForEachDate.length;
          }
          //If [index]date does not match [index - 1]date
          //Then add the current listForEachDate to the
          //listOfDateLists i.e. add sublist to list of lists
        } else {
          listOfDateLists.add(listForEachDate);
          //Clear the listForEachDate so that we can create
          //a new clean list of new dates
          listForEachDate = [];
          //Add the new date to the listForEachDate
          //so that the process can start again
          listForEachDate.add(completeOrders[i]);
        }
      }
      //Once the document has been iterated through,
      //Add to the big list.
      listOfDateLists.add(listForEachDate);
    }
    return listOfDateLists;
  }

  dateConversion(Timestamp timestamp) {
    DateTime date = timestamp.toDate();
    var date_day =
        DateFormat.MMMM().format(date) + ' ' + DateFormat.d().format(date);
    return date_day;
  }

  weekConversion(Timestamp timestamp) {
    DateTime date = timestamp.toDate();
    var date_day = DateFormat.d().format(date);
    if (int.parse(date_day) >= 1 && int.parse(date_day) <= 7) {
      date_day = '1 ' + DateFormat.MMMM().format(date);
    } else if (int.parse(date_day) >= 8 && int.parse(date_day) <= 14) {
      date_day = '2 ' + DateFormat.MMMM().format(date);
    } else if (int.parse(date_day) >= 15 && int.parse(date_day) <= 21) {
      date_day = '3 ' + DateFormat.MMMM().format(date);
    } else if (int.parse(date_day) >= 22 && int.parse(date_day) <= 31) {
      date_day = '4 ' + DateFormat.MMMM().format(date);
    }
    return date_day;
  }

  monthConversion(Timestamp timestamp) {
    DateTime date = timestamp.toDate();
    var date_day = DateFormat.MMMM().format(date);
    return date_day;
  }

  yearConversion(Timestamp timestamp) {
    DateTime date = timestamp.toDate();
    var date_day = DateFormat.y().format(date);
    return date_day;
  }

  monTuesWedConversion(Timestamp timestamp) {
    DateTime date = timestamp.toDate();
    var date_day = DateFormat.E().format(date);
    return date_day;
  }
}
