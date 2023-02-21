class Endpoints {
  Endpoints._();

  static const validateToken = '';
  static const register = '/user/register';
  static const login = '/user/login';
  static const getUserInfo = '/user/info';
  static const updateInfo = '/user/info';
  static const updatePassword = '/user/update-password';
  static const uploadAvatar = '/user/upload';
  static const groupLeave = '/group/leave';
  static const groupAccept = '/group/accept';
  static const groupReject = '/group/reject';
  static const groupListInvite = '/group/list-invite';
  static const requestDeletion = '/user/request-deletion';

  // Admin
  static const getGroupInfo = '/group/info';
  static const createGroup = '/group/create';
  static const updateGroupInfo = '/group/info';
  static const searchUserByPhone = '/user/search';
  static const getInfoByAdmin = '/user/info';
  static const addUserToGroup = '/group/add-user';
  static const removeUserFromGroup = '/group/remove-user';
  static const resetPassword = '/user/reset-password/';

  // Adress
  static const getProvinces = '/province';
  static const getDicstricts = '/province';
  static const getWards = '/districts';

  // Real Estate
  static const getListRealEstate = '/real-estates/get-list';
  static const registerRealEstate = '/real-estates/create';
  static const uploadRealEstateImage = '/real-estates/upload';
  static const delUploadedRealEstateImage = '/real-estates/delete-images';
  static const getRealEstateById = '/real-estates';
  static const updateStatus = '/real-estates/status';
  static const exportExcelRealEstate = '/real-estates/export';
  static const deleteByAdminRealEstate = '/real-estates/delete-by-admin';
  static const disableByAdminRealEstate = '/real-estates/disable-by-admin';
  static const enableByAdminRealEstate = '/real-estates/enable-by-admin';

  // Subcription
  static const getSubcriptionInfo = '/subscription/info';
  static const registerSubcription = '/subscription/create';
  static const confirmSubcription = '/subscription/confirm';
  static const lockSubcription = '/subscription/lock';
  static const unlockSubcription = '/subscription/unlock';
  static const getSubcriptionDetails = '/subscription/details';
  static const getListSubcription = '/subscription/get-all';
  static const uploadSubcriptionImage = '/subscription/upload';
  static const delUploadedSubcriptionImage = '/real-estates/delete-images';
  static const getRegSubcriptionByUser = '/subscription/get-by-user';
  // Notification
  static const getNotifications = '/notification/get-list';
  static const getNotiDetail = '/notification/details';
  static const deleteNotification = '/notification/delete';
}
