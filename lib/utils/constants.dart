// ignore_for_file: constant_identifier_names

class AppConstants {
  static const String API_URL = "http://192.168.8.174.nip.io:8000";
  static const String STATIC_WEB_URL = "http://codajobs.beamcoda.com";

  // Partner
  static const String REGISTER_PARTNER = "/api/partner/register";
  static const String PARTNER_LOGIN = "/api/partner/auth/login";
  static const String PARTNER_DETAILS = "/api/partner/auth/details";
  static const String PARTNER_DELETE_URL = "/api/partner/delete";
  static const String PARTNER_NOTIFICATION_SAVE_SETTINGS =
      "/api/notifications/partner/setting";
  static const String PARTNER_NOTIFICATION_SETTINGS =
      "/api/notifications/partner";

  // Jobs
  static const String JOBS_INDEX = "/api/jobs/partner";

  // Subscription
  static const String PACKAGES_INDEX = "/api/packages/all";
  static const String INVOICES_INDEX = "/api/invoices/partner";
  static const String CREATE_INVOICE = "/api/partner/new-invoice";
  static const String PAY_INVOICE = "/api/partner/pay-card-invoice";

  // Notifications
  static const String SAVE_NOTIFICATION_DEVICE =
      "/api/notifications/partner/device";
}
