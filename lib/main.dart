import 'dart:io';
import 'dart:math';
import 'package:external_path/external_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

void main()
{
  runApp(MaterialApp(
    home: frist(),
  ));
}

class frist extends StatefulWidget {
  const frist({Key? key}) : super(key: key);

  @override
  State<frist> createState() => _fristState();
}

class _fristState extends State<frist> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ElevatedButton(onPressed: () async {
        final PdfDocument document = PdfDocument();
        final PdfPage page = document.pages.add();

        // write your pdf
        page.graphics.drawString(
            'hello world...\n My name is mihir ramoliya and i am levae in surat and i am a \n'
                'software devloper and my skills is i know about c and c++ and java and '
                '\n master in flutter and in programming language my projects is Tic-Tac-Toe,\n'
                'CLC , Shayari App , Picture Match , Quiz Logo game , and many more\n'
                'and i learn flutter in creative multimedia institute and my hobby is \n'
                'playing criket and lern about thech , reding , and many more \n'
                'my village name is Mandlikapur and my father name is Rameshbhai Ramoliya \n'
                '.', PdfStandardFont(PdfFontFamily.helvetica, 14),
            bounds: const Rect.fromLTWH(0, 0, 500, 500),
            brush: PdfBrushes.black
        );

        var path = await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS)+'/myfolder';
        print(path);

        Directory dir = Directory(path);
        if(! await dir.exists())
          {
            dir.create();
          }

        // type your pdf file name and path
        File f = File('${dir.path}/mihir${Random().nextInt(100)}.pdf');
        await f.writeAsBytes(await document.save());
        OpenFile.open(f.path);
        document.dispose();

      }, child: Text("Submit")),
    );
  }

  @override
  void initState() {
    get();
  }
  get()
  async {
    var status = await Permission.storage.status;
    if(status.isDenied)
      {
        Map<Permission,PermissionStatus> statues = await [
          Permission.location,
          Permission.storage,
        ].request();
      }
  }
}
