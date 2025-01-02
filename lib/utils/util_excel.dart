import 'dart:io';

import 'package:bamboo_app/src/domain/entities/e_marker.dart';
import 'package:excel/excel.dart';
import 'package:path/path.dart';

class UtilExcel {
  Future<bool?> createExcel(Set<EntitiesMarker?> markers) async {
    final Excel excel = Excel.createExcel();
    final Sheet sheet = excel['Sheet1'];

    _insertRowData(sheet, markers);

    var xlsxBytes = excel.save();
    var appDirectory = Directory('/storage/emulated/0/Download/Bamboo Mapper');

    if (!appDirectory.existsSync()) {
      appDirectory.createSync(recursive: true);
    }
    File(join(appDirectory.path,
        'Bamboo Mapper-${markers.first!.createdAt.toString().substring(0, 10)}.xlsx'))
      ..createSync(recursive: true)
      ..writeAsBytesSync(xlsxBytes!);

    return true;
  }

  void _insertRowData(Sheet sheet, Set<EntitiesMarker?> items) {
    sheet.insertRowIterables([
      TextCellValue('No'),
      TextCellValue('Nama'),
      TextCellValue('Kuantitas'),
      TextCellValue('Jenis'),
      TextCellValue('Deskripsi'),
      TextCellValue('Nama Pemilik'),
      TextCellValue('Kontak Pemilik'),
      TextCellValue('Link Gambar'),
    ], 0);

    final List<EntitiesMarker?> itemsList = items.toList();
    for (var i = 0; i < itemsList.length; i++) {
      sheet.appendRow([
        IntCellValue(i + 1),
        TextCellValue(itemsList[i]!.name),
        IntCellValue(itemsList[i]!.qty),
        TextCellValue(itemsList[i]!.strain),
        TextCellValue(itemsList[i]!.description),
        TextCellValue(itemsList[i]!.ownerName),
        TextCellValue(itemsList[i]!.ownerContact),
        TextCellValue(itemsList[i]!.urlImage),
      ]);
    }
  }
}
