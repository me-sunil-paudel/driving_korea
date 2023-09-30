import 'package:flutter/material.dart';
import 'package:advance_pdf_viewer_fork/advance_pdf_viewer_fork.dart';

class ReadScreen extends StatefulWidget {
  const ReadScreen({super.key});

  @override
  State<ReadScreen> createState() => _ReadScreenState();
}

class _ReadScreenState extends State<ReadScreen> {
  bool _isLoading = true;
  late PDFDocument document;
  bool _usePDFListView = false;

  @override
  void initState() {
    super.initState();
    loadDocument();
  }

  @override
  void dispose() {
    PDFDocument? document = PDFDocument();
    document.clearImageCache();
    super.dispose();
  }

  loadDocument() async {
    document = await PDFDocument.fromAsset('assets/pdf/pdf_file.pdf');
    setState(() => _isLoading = false);
  }

  changePDF(value) async {
    setState(() => _isLoading = true);
    if (value == 1) {
      document = await PDFDocument.fromAsset('assets/pdf/pdf_file.pdf');
    } else if (value == 2) {
      document = await PDFDocument.fromURL(
          "http://conorlastowka.com/book/CitationNeededBook-Sample.pdf");
    } else {
      document = await PDFDocument.fromAsset('assets/pdf/pdf_file.pdf');
    }
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 36),
            ListTile(
              title: const Text('Load from Assets'),
              onTap: () {
                changePDF(1);
              },
            ),
            ListTile(
              title: const Text('Load from URL'),
              onTap: () {
                changePDF(2);
              },
            ),
            ListTile(
              title: const Text('Restore default'),
              onTap: () {
                changePDF(3);
              },
            ),
            ListTile(
              title: const Text('close'),
              onTap: () {
                Navigator.pop(context, true);
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Reading section'),
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              _usePDFListView = !_usePDFListView;
              setState(() {});
            },
            child: const Icon(Icons.cached),
          ),
          const SizedBox(
            width: 15,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context, true);
            },
            child: const Icon(Icons.exit_to_app_outlined),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          !_usePDFListView
              ? Expanded(
                  child: Center(
                    child: _isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : PDFViewer(
                            document: document,
                            zoomSteps: 1,
                            //uncomment below line to preload all pages
                            // lazyLoad: false,
                            // uncomment below line to scroll vertically
                            // scrollDirection: Axis.vertical,

                            // enableSwipeNavigation: false,
                            showPicker: false,
                            showNavigation: true,
                            //uncomment below code to replace bottom navigation with your own
                            /* navigationBuilder:
                            (context, page, totalPages, jumpToPage, animateToPage) {
                          return ButtonBar(
                            alignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              IconButton(
                                icon: Icon(Icons.first_page),
                                onPressed: () {
                                  jumpToPage()(page: 0);
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.arrow_back),
                                onPressed: () {
                                  animateToPage(page: page - 2);
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.arrow_forward),
                                onPressed: () {
                                  animateToPage(page: page);
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.last_page),
                                onPressed: () {
                                  jumpToPage(page: totalPages - 1);
                                },
                              ),
                            ],
                          );
                        }, */
                          ),
                  ),
                )
              : Expanded(
                  child: _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : PDFListViewer(
                          document: document,
                          preload: true,
                        ),
                ),
        ],
      ),
    );
  }
}
