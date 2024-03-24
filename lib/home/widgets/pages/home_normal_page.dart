import 'package:flutter/material.dart';
import 'package:webchallenger/home/controller/home_controller.dart';
import 'package:webchallenger/home/widgets/file_attach_widget.dart';
import 'package:webchallenger/home/widgets/historic_file_attached_widget.dart';
import 'package:webchallenger/login/login_page.dart';
import 'package:webchallenger/shared/widgets/error_showdialog_widget.dart';
import 'package:webchallenger/shared/widgets/loading_widget.dart';

class HomeNormalPage extends StatefulWidget {
  final HomeController controller;
  const HomeNormalPage({super.key, required this.controller});

  @override
  State<HomeNormalPage> createState() => _HomeNormalPageState();
}

class _HomeNormalPageState extends State<HomeNormalPage> {
  @override
  void initState() {
    widget.controller.sendFileSuccess.addListener(() {
      setState(() {});
      if (widget.controller.sendFileSuccess.value) {
        widget.controller.attachFiles.value.clear();
        widget.controller.getFiles();
      }
    });
    widget.controller.errorMessage.addListener(() {
      setState(() {});
      if (widget.controller.errorMessage.value.isNotEmpty) {
        if (mounted) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return ErrorShowdialogWidget(errorTitle: widget.controller.errorMessage.value);
            },
          );
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                      text: TextSpan(children: [
                    WidgetSpan(
                        child: Image.asset(
                      'assets/images/hand_image.png',
                      height: 25,
                    )),
                    const TextSpan(
                      text: ' Bem-vindo (a)',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 21,
                        color: Colors.black,
                      ),
                    ),
                  ])),
                  Row(
                    children: [
                      IconButton(onPressed: () {}, icon: const Icon(Icons.account_circle_outlined)),
                      const SizedBox(width: 10),
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ));
                          },
                          icon: const Icon(Icons.exit_to_app_outlined)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 120,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 340),
                    child: ValueListenableBuilder(
                      valueListenable: widget.controller.attachFiles,
                      builder: (context, attachList, _) {
                        return Column(
                          children: [
                            InkWell(
                              onTap: () {
                                widget.controller.attachFile();
                              },
                              child: Card(
                                elevation: 5,
                                shape: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 25),
                                  child: Column(
                                    children: [
                                      Icon(Icons.add, size: 20),
                                      SizedBox(height: 5),
                                      Text(
                                        'Clique aqui para\n anexar um arquivo',
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Text(
                                  'Itens anexados ${widget.controller.attachFiles.value.length}',
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 300),
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: attachList.length,
                                itemBuilder: (context, index) {
                                  var file = attachList[index];
                                  return FileAttachWidget(
                                    fileName: file.name,
                                    onDelete: () => widget.controller.removeItem(file),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 30),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  minimumSize: const Size(300, 56)),
                              onPressed: () async => await widget.controller.sendFiles(),
                              child: const Text('Enviar'),
                            ),
                          ],
                        );
                      },
                    )),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 80.0),
                  child: SizedBox(
                    height: 500,
                    child: VerticalDivider(
                      color: Colors.black,
                      thickness: 2,
                    ),
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: widget.controller.attachFilesHistoric,
                  builder: (context, attachFilesHistoric, _) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Itens anexados anteriormente: ${attachFilesHistoric.length}'),
                        const SizedBox(height: 20),
                        ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 420),
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: attachFilesHistoric.length,
                              itemBuilder: (context, index) {
                                var list = attachFilesHistoric[index];
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: HistoricFileAttachedWidget(fileName: list.nomeUpload),
                                );
                              },
                            ))
                      ],
                    );
                  },
                )
              ],
            ),
          ],
        ),
        LoadingWidget(valueListenable: widget.controller.loading),
      ],
    );
  }
}
