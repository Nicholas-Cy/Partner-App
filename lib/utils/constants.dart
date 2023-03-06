// ignore_for_file: constant_identifier_names

class AppConstants {
  static const String API_URL = "http://192.168.8.173.nip.io:8000";
  static const String STATIC_WEB_URL = "https://codajobs.beamcoda.com";
  static const String CURRENCY_PREFIX = "\$";

  // Social Login
  static const String GOOGLE_LOGIN_URL = "/api/partner/auth/google";

  // Upload urls
  static const String UPLOAD_IMG_URL = "/api/file/upload-image";
  static const String UPLOAD_IMG_DIRECTORY = "/img/uploads";

  // Partner
  static const String REGISTER_PARTNER = "/api/partner/register";
  static const String PARTNER_SAVE_PROFILE = "/api/partner/edit-partner";
  static const String PARTNER_LOGIN = "/api/partner/auth/login";
  static const String PARTNER_LOGOUT = "/api/partner/auth/logout";
  static const String PARTNER_DETAILS = "/api/partner/auth/details";
  static const String PARTNER_DELETE_URL = "/api/partner/delete";
  static const String PARTNER_NOTIFICATION_SAVE_SETTINGS =
      "/api/notifications/partner/setting";
  static const String PARTNER_NOTIFICATION_SETTINGS =
      "/api/notifications/partner";

  // Jobs
  static const String JOBS_INDEX = "/api/jobs/partner";
  static const String JOBS_RETRIEVAL = "/api/jobs/view";
  static const String NEW_JOB = "/api/jobs/new";
  static const String EDIT_JOB = "/api/jobs/edit";
  static const String TOGGLE_JOB_STATUS = "/api/jobs/toggle-status";
  static const String DELETE_JOB = "/api/jobs/delete";
  static const String SHORTLIST_APPLICANT = "/api/job-applications/shortlist";

  // Skills
  static const String SKILLS_INDEX = "/api/skills/autocomplete";

  // Categories
  static const String CATEGORIES_INDEX = "/api/categories/all";

  // Job Types
  static const String JOBTYPES_INDEX = "/api/job-types/all";

  // Post Durations
  static const String POSTDURATIONS_INDEX = "/api/post-durations/partner";

  // Subscription
  static const String PACKAGES_INDEX = "/api/packages/all";
  static const String INVOICES_INDEX = "/api/invoices/partner";
  static const String CREATE_INVOICE = "/api/partner/new-invoice";
  static const String PAY_INVOICE = "/api/partner/pay-card-invoice";

  // Notifications
  static const String SAVE_NOTIFICATION_DEVICE =
      "/api/notifications/partner/device";
}
