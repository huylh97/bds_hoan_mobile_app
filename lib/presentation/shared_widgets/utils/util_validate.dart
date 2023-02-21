enum ValidateType {
  email,
  password,
  confirmPassword,
  phone,
  name,
  birthDay,
  nameGroup,
  address,
  taxCode,
  description,
  price,
  commission,
  area,
  date,
  vn2000,
  title,
  numMonth,
  confirmDel
}

class UtilValidator {
  static String? validate({
    required String? data,
    required ValidateType type,
    bool? isRequired,
    String? comparePassword,
  }) {
    if (data == null) return null;

    switch (type) {
      case ValidateType.email:
        if (data.isEmpty) {
          return 'Vui lòng nhập email';
        }
        final RegExp emailRegex = RegExp(
            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
        if (!emailRegex.hasMatch(data)) {
          return 'Email không hợp lệ';
        }
        return null;
      case ValidateType.phone:
        if (isRequired != false && data.isEmpty) {
          return 'Vui lòng nhập số điện thoại';
        }
        final RegExp phoneRegex = RegExp(r'^[0-9]*$');
        if (!phoneRegex.hasMatch(data)) {
          return 'Số điện thoại không hợp lệ';
        }
        if (data.isNotEmpty && data.length != 10) {
          return 'Số điện thoại phải có 10 chữ số';
        }
        return null;
      case ValidateType.password:
        if (data.isEmpty) {
          return 'Vui lòng nhập mật khẩu';
        }
        if (data.length < 6) {
          return 'Mật khẩu phải có ít nhất 6 ký tự';
        }
        return null;
      case ValidateType.confirmPassword:
        if (data.isEmpty) {
          return 'Vui lòng nhập lại mật khẩu';
        }
        if (data.length < 6) {
          return 'Mật khẩu phải có ít nhất 6 ký tự';
        }
        if (data != comparePassword) {
          return 'Xác nhận mật khẩu không khớp';
        }
        return null;
      case ValidateType.name:
        if (isRequired != false && data.isEmpty) {
          return 'Vui lòng nhập họ tên';
        }
        return null;
      case ValidateType.birthDay:
        if (data.isEmpty) {
          return 'Vui lòng nhập ngày sinh';
        }
        return null;
      case ValidateType.nameGroup:
        if (data.isEmpty) {
          return 'Vui lòng nhập tên nhóm';
        }
        return null;
      case ValidateType.address:
        if (data.isEmpty) {
          return 'Vui lòng nhập địa chỉ';
        }
        return null;
      case ValidateType.taxCode:
        if (data.isEmpty) {
          return 'Vui lòng nhập mã số thuế';
        }
        return null;
      case ValidateType.description:
        if (data.isEmpty) {
          return 'Vui lòng nhập mô tả';
        }
        return null;
      case ValidateType.price:
        if (data.isEmpty) {
          return 'Vui lòng nhập đơn giá';
        }
        return null;
      case ValidateType.commission:
        if (data.isEmpty) {
          return 'Vui lòng nhập hoa hồng';
        }
        return null;
      case ValidateType.area:
        if (data.isEmpty) {
          return 'Vui lòng nhập diện tích';
        }

        return null;
      case ValidateType.date:
        if (data.isEmpty) {
          return 'Vui lòng chọn ngày';
        }
        return null;
      case ValidateType.vn2000:
        if (data.isEmpty) {
          return 'Vui lòng nhập tọa độ VN2000';
        }
        return null;
      case ValidateType.title:
        if (data.isEmpty) {
          return 'Vui lòng nhập tiêu đề';
        }
        return null;
      case ValidateType.numMonth:
        if (data.isEmpty) {
          return 'Vui lòng nhập thời hạn';
        }
        int? value = int.tryParse(data);
        if (value == null || value <= 0) {
          return 'Vui lòng nhập thời hạn hợp lệ';
        }
        return null;
      case ValidateType.confirmDel:
        if (data.isEmpty) {
          return 'Vui lòng nhập';
        }
        if (data != 'delete') {
          return 'Không hợp lệ';
        }
        return null;
      default:
        return null;
    }
  }

  ///Singleton factory
  static final UtilValidator _instance = UtilValidator._internal();

  factory UtilValidator() {
    return _instance;
  }

  UtilValidator._internal();
}
