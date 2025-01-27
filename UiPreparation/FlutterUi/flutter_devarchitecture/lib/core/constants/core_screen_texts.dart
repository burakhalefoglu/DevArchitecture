import 'package:flutter/material.dart';

import 'base_constants.dart';

class CoreScreenTexts extends ScreenConstantsBase {
  static late String appName;
  static late String adminPanel;
  static late String returnHomePage;
  static late String attention;
  static late String warning;
  static late String success;
  static late String information;
  static late String search;
  static late String ok;
  static late String cancel;
  static late String yes;
  static late String no;

  static late String pdfDownloadTooltip;
  static late String excelDownloadTooltip;
  static late String csvDownloadTooltip;
  static late String imageDownloadTooltip;
  static late String txtDownloadTooltip;
  static late String jsonDownloadTooltip;
  static late String xmlDownloadTooltip;

  static late String pdfShareTooltip;
  static late String excelShareTooltip;
  static late String csvShareTooltip;
  static late String imageShareTooltip;
  static late String txtShareTooltip;
  static late String jsonShareTooltip;
  static late String xmlShareTooltip;
  static late String shareTitle;

  static late String dateFormat;
  static late String timeFormat;
  static late String dateTimeFormat;
  static late String dateHint;
  static late String okButton;
  static late String cancelButton;
  static late String yesButton;
  static late String noButton;
  static late String deleteButton;
  static late String editButton;
  static late String saveButton;
  static late String backButton;
  static late String addButton;
  static late String filterButton;
  static late String clearButton;
  static late String sortButton;
  static late String updateButton;

  static late String id;
  static late String logOutButton;
  static late String profileButton;
  static late String notificationsButton;
  static late String changeThemeButton;
  static late String categories;
  static late String sales;
  static late String name;
  static late String days;
  static late String months;
  static late String years;
  static late String hours;
  static late String minutes;
  static late String seconds;
  static late String today;
  static late String yesterday;
  static late String week;
  static late String month;
  static late String year;
  static late String day;
  static late String hour;
  static late String minute;
  static late String second;
  static late String dataTableTitle;
  static late String address;
  static late String addressHint;
  static late String email;
  static late String password;
  static late String phoneNumber;
  static late String status;
  static late String mobilePhones;
  static late String thisActionCannotBeUndone;
  static late String vehicleRegistrationNumber;
  static late String vehicleLicensePlate;
  static late String notes;
  static late String notesHint;
  static late String alias;
  static late String aliasHint;
  static late String description;

  static void init(BuildContext context) {
    BaseConstants.init(context);
    appName = BaseConstants.translate("AppName");
    attention = BaseConstants.translate("Attention");
    warning = BaseConstants.translate("Warning");
    success = BaseConstants.translate("Success");
    information = BaseConstants.translate("Information");
    search = BaseConstants.translate("Search");
    ok = BaseConstants.translate("Ok");
    cancel = BaseConstants.translate("Cancel");
    yes = BaseConstants.translate("Yes");
    no = BaseConstants.translate("No");

    pdfDownloadTooltip = BaseConstants.translate("PdfDownloadTooltip");
    excelDownloadTooltip = BaseConstants.translate("ExcelDownloadTooltip");
    csvDownloadTooltip = BaseConstants.translate("CsvDownloadTooltip");
    imageDownloadTooltip = BaseConstants.translate("ImageDownloadTooltip");
    txtDownloadTooltip = BaseConstants.translate("TxtDownloadTooltip");
    jsonDownloadTooltip = BaseConstants.translate("JsonDownloadTooltip");
    xmlDownloadTooltip = BaseConstants.translate("XmlDownloadTooltip");

    pdfShareTooltip = BaseConstants.translate("PdfShareTooltip");
    excelShareTooltip = BaseConstants.translate("ExcelShareTooltip");
    csvShareTooltip = BaseConstants.translate("CsvShareTooltip");
    imageShareTooltip = BaseConstants.translate("ImageShareTooltip");
    txtShareTooltip = BaseConstants.translate("TxtShareTooltip");
    jsonShareTooltip = BaseConstants.translate("JsonShareTooltip");
    xmlShareTooltip = BaseConstants.translate("XmlShareTooltip");

    shareTitle = BaseConstants.translate("ShareTitle");

    dateFormat = BaseConstants.translate("DateFormat");
    timeFormat = BaseConstants.translate("TimeFormat");
    dateTimeFormat = BaseConstants.translate("DateTimeFormat");
    dateHint = BaseConstants.translate("DateHint");
    okButton = BaseConstants.translate("OkButton");
    cancelButton = BaseConstants.translate("CancelButton");
    yesButton = BaseConstants.translate("YesButton");
    noButton = BaseConstants.translate("NoButton");
    deleteButton = BaseConstants.translate("DeleteButton");
    editButton = BaseConstants.translate("EditButton");
    saveButton = BaseConstants.translate("SaveButton");
    backButton = BaseConstants.translate("BackButton");
    addButton = BaseConstants.translate("AddButton");
    filterButton = BaseConstants.translate("FilterButton");
    clearButton = BaseConstants.translate("ClearButton");
    sortButton = BaseConstants.translate("SortButton");
    id = BaseConstants.translate("Id");
    logOutButton = BaseConstants.translate("LogOutButton");
    profileButton = BaseConstants.translate("ProfileButton");
    notificationsButton = BaseConstants.translate("NotificationsButton");
    changeThemeButton = BaseConstants.translate("ChangeThemeButton");
    categories = BaseConstants.translate("Categories");
    sales = BaseConstants.translate("Sales");
    name = BaseConstants.translate("Name");
    days = BaseConstants.translate("Days");
    months = BaseConstants.translate("Months");
    years = BaseConstants.translate("Years");
    hours = BaseConstants.translate("Hours");
    minutes = BaseConstants.translate("Minutes");
    seconds = BaseConstants.translate("Seconds");
    today = BaseConstants.translate("Today");
    yesterday = BaseConstants.translate("Yesterday");
    week = BaseConstants.translate("Week");
    month = BaseConstants.translate("Month");
    year = BaseConstants.translate("Year");
    day = BaseConstants.translate("Day");
    hour = BaseConstants.translate("Hour");
    minute = BaseConstants.translate("Minute");
    second = BaseConstants.translate("Second");
    dataTableTitle = BaseConstants.translate("DataTableTitle");
    address = BaseConstants.translate("Address");
    addressHint = BaseConstants.translate("AddressHint");
    email = BaseConstants.translate("Email");
    password = BaseConstants.translate("Password");
    phoneNumber = BaseConstants.translate("PhoneNumber");
    thisActionCannotBeUndone =
        BaseConstants.translate("ThisActionCannotBeUndone");
    vehicleRegistrationNumber =
        BaseConstants.translate("VehicleRegistrationNumber");
    vehicleLicensePlate = BaseConstants.translate("VehicleLicensePlate");
    updateButton = BaseConstants.translate("UpdateButton");
    adminPanel = BaseConstants.translate("AdminPanel");
    returnHomePage = BaseConstants.translate("ReturnHomePage");
    status = BaseConstants.translate("Status");
    mobilePhones = BaseConstants.translate("MobilePhones");
    notes = BaseConstants.translate("Notes");
    notesHint = BaseConstants.translate("NotesHint");
    aliasHint = BaseConstants.translate("AliasHint");
    alias = BaseConstants.translate("Alias");
    description = BaseConstants.translate("Description");
  }
}
