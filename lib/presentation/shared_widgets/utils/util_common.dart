import 'package:bds_hoan_mobile/data/enums/status.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class UtilCommon {
  UtilCommon._();

  static fieldFocusChange(
    BuildContext context,
    FocusNode current,
    FocusNode next,
  ) {
    current.unfocus();
    FocusScope.of(context).requestFocus(next);
  }

  static hiddenKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  static Future<BitmapDescriptor> bitmapDescriptorFromSvgAsset(
      BuildContext context,
      int kind,
      StatusEnum status,
      String squarePrice,
      String widthPrice,
      String totalPrice,
      bool mapTypeFlag) async {
    // Read SVG file as String
    String fillColor = getFillColorByKind(kind);
    String svgStatus = getStatus(status);
    String textFill =
        mapTypeFlag ? '#DA7F20' : 'white'; //true : normal false : satellite
    String strokeColor =
        mapTypeFlag ? 'white' : 'black'; //true : normal false : satellite

    String svgStrings =
        '''<svg width="199" height="174" viewBox="0 0 199 174" fill="none" xmlns="http://www.w3.org/2000/svg">
              <g clip-path="url(#clip0_16_108)">
              <path d="M131 111.488C131 94.131 116.878 80 99.4678 80C82.1218 80 68 94.131 68 111.488C68 117.166 69.4831 122.457 72.1269 127.103C81.348 143.234 94.4381 166.205 98.3071 173.045C98.565 173.432 98.9519 173.69 99.4678 173.69C99.9191 173.69 100.371 173.432 100.628 173.045C104.497 166.205 117.652 143.234 126.809 127.103C129.452 122.522 131 117.166 131 111.488Z" fill="$fillColor"/>

              <text y="5" x="0" fill="#000000" font-size="19" font-weight="bold" font-family="OpenSans" fill="black">
                <tspan text-anchor="middle" x="100" dy="8.2em">$svgStatus</tspan>
                </text>
              </g>
              <text y="8" x="0" font-size="30" font-weight="bold" font-family="OpenSans" fill="$textFill">
                  <tspan text-anchor="middle" x="100" dy="1em" style="fill: $strokeColor; stroke: $strokeColor; stroke-width: 8">$squarePrice/m2</tspan>
                  <tspan text-anchor="middle" x="100" dy="1em">$squarePrice/m2</tspan>
                  <tspan text-anchor="middle" x="100" dy="3em" style="fill: $strokeColor; stroke: $strokeColor; stroke-width: 8">$widthPrice/mn</tspan>
                  <tspan text-anchor="middle" x="100" dy="3em">$widthPrice/mn</tspan>
                  <tspan text-anchor="middle" x="100" dy="5em" style="fill: $strokeColor; stroke: $strokeColor; stroke-width: 8">$totalPrice</tspan>
                  <tspan text-anchor="middle" x="100" dy="5em">$totalPrice</tspan>
                </text>
              <defs>
              <clipPath id="clip0_16_108">
              <rect width="63" height="93.6902" fill="white" transform="translate(68 80)"/>
              </clipPath>
              </defs>
          </svg>''';
    DrawableRoot svgDrawableRoot = await svg.fromSvgString(
      svgStrings,
      'debug',
    );

    // toPicture() and toImage() don't seem to be pixel ratio aware, so we calculate the actual sizes here
    MediaQueryData queryData = MediaQuery.of(context);
    double devicePixelRatio = queryData.devicePixelRatio;
    double width =
        75 * devicePixelRatio; // where 32 is your SVG's original width
    double height = 50 * devicePixelRatio; // same thing

    // Convert to ui.Picture
    ui.Picture picture = svgDrawableRoot.toPicture(size: Size(width, height));

    // Convert to ui.Image. toImage() takes width and height as parameters
    // you need to find the best size to suit your needs and take into account the
    // screen DPI
    ui.Image image = await picture.toImage(width.toInt(), height.toInt());
    ByteData? bytes = await image.toByteData(format: ui.ImageByteFormat.png);
    return BitmapDescriptor.fromBytes(bytes!.buffer.asUint8List());
  }

  static String getFillColorByKind(int kind) {
    if (kind == 1) {
      // Chinh chu:
      return '#E31313';
    } else if (kind == 2) {
      // Lien ket sale
      return '#43B739';
    } else if (kind == 3) {
      // Hàng công ty
      return '#F68217';
    } else if (kind == 4) {
      // Ky gui
      return '#00A9E0';
    }
    return '#FFFFFF';
  }

  static Color getColorByKind(int kind) {
    if (kind == 1) {
      // Chinh chu:
      return Color(0xFFE31313);
    } else if (kind == 2) {
      // Lien ket sale
      return Color(0xFF43B739);
    } else if (kind == 3) {
      // Hàng công ty
      return Color(0xFFF68217);
    } else if (kind == 4) {
      // Ky gui
      return Color(0xFFFAFF00);
    }
    return Color(0xFFFFFFFF);
  }

  static Color getTextColorByKind(int kind) {
    if (kind == 1) {
      // Chinh chu:
      return Colors.white;
    } else if (kind == 2) {
      // Lien ket sale
      return Colors.white;
    } else if (kind == 3) {
      // Hàng công ty
      return Colors.white;
    } else if (kind == 4) {
      // Ky gui
      return Colors.black;
    }
    return Colors.black;
  }

  static String getStatus(StatusEnum status) {
    if (status == StatusEnum.New || status == StatusEnum.Approved) {
      // New
      return 'NEW';
    } else if (status == StatusEnum.GD) {
      // Dang giao dich
      return 'GD';
    } else if (status == StatusEnum.Normal) {
      // Binh thuong
      return '';
    } else if (status == StatusEnum.SaledByAdmin ||
        status == StatusEnum.SaledByUser) {
      // Da ban
      return 'DB';
    }
    return '';
  }

  static String rounderNumber(double val, int numDegit) {
    return val.toStringAsFixed(numDegit).replaceFirst(RegExp(r'\.?0*$'), '');
  }

  static String formatCommaDouble(double? val) {
    if (val == null) {
      return '';
    }

    var formatter = NumberFormat('#,###,##0');
    return formatter.format(val);
  }

  static String formatCommaDoubleArea(double? val) {
    if (val == null) {
      return '';
    }

    var formatter = NumberFormat('#,###,##0.#');
    return formatter.format(val);
  }

  static String formatCommaInt(int? val) {
    if (val == null) {
      return '';
    }

    var formatter = NumberFormat('#,###,##0');
    return formatter.format(val);
  }

  static String getPriceDisplayStr(int? price) {
    if (price == null) {
      return '';
    }
    if (price >= 1000000000) {
      return '${UtilCommon.rounderNumber(price / 1000000000, 2)} tỷ';
    }
    if (price >= 1000000) {
      return '${UtilCommon.rounderNumber(price / 1000000, 2)} tr';
    }
    if (price >= 1000) {
      return '${UtilCommon.rounderNumber(price / 1000, 0)} ngàn';
    }
    return '${price}';
  }
}
