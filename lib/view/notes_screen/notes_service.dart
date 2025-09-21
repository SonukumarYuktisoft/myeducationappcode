import 'package:device_info_plus/device_info_plus.dart';
import 'package:education/view/notes_screen/models/note_model.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class NotesService {
  static final Dio _dio = Dio();

  // Updated getDummyNotes method with real public PDF links and pricing
  static List<NoteModel> getDummyNotes() {
    return [
      // Free SSC Notes
      NoteModel(
        id: '1',
        title: 'SSC CGL 2026 Complete Study Guide',
        description:
            'Comprehensive notes covering Quantitative Aptitude, Reasoning, English, and General Awareness for SSC CGL 2026',
        pdfUrl: 'https://www.tutorialspoint.com/flutter/flutter_tutorial.pdf',
        thumbnailUrl:
            'https://images.unsplash.com/photo-1434030216411-0b793f4b4173?w=400&h=300&fit=crop',
        category: 'SSC',
        teacherName: 'Rahul Sharma',
        createdAt: DateTime.now().subtract(Duration(days: 1)),
        isFree: true,
        isPdf: true,
        price: 0.0,
      ),
      NoteModel(
        id: '2',
        title: 'SSC CHSL Tier 1 Preparation Notes',
        description:
            'Complete preparation material with previous year questions and practice papers for SSC CHSL Tier 1',
        pdfUrl: 'https://www.adobe.com/content/dam/cc/us/en/creative-cloud/photography/discover/astrophotography/astro_A4.pdf',
        thumbnailUrl:
            'https://images.unsplash.com/photo-1456513080510-7bf3a84b82f8?w=400&h=300&fit=crop',
        category: 'SSC',
        teacherName: 'Priya Singh',
        createdAt: DateTime.now().subtract(Duration(days: 2)),
        isFree: true,
        isPdf: true,
        price: 0.0,
      ),
      NoteModel(
        id: '3',
        title: 'SSC MTS Essential Study Material',
        description:
            'Focused study material covering all topics for SSC Multi Tasking Staff examination',
        pdfUrl:
            'https://www.w3.org/WAI/WCAG21/Understanding/understanding-techniques.pdf',
        thumbnailUrl:
            'https://images.unsplash.com/photo-1481627834876-b7833e8f5570?w=400&h=300&fit=crop',
        category: 'SSC',
        teacherName: 'Amit Kumar',
        createdAt: DateTime.now().subtract(Duration(days: 3)),
        isFree: false,
        isPdf: true,
        price: 149.0,
      ),
      NoteModel(
        id: '4',
        title: 'SSC Reasoning Quick Formula Guide',
        description:
            'Smart shortcuts and techniques for solving reasoning questions in minimum time',
        pdfUrl:
            'https://www.un.org/en/about-us/universal-declaration-of-human-rights',
        thumbnailUrl:
            'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400&h=300&fit=crop',
        category: 'SSC',
        teacherName: 'Neha Gupta',
        createdAt: DateTime.now().subtract(Duration(days: 4)),
        isFree: true,
        isPdf: true,
        price: 0.0,
      ),

      // Banking Notes
      NoteModel(
        id: '5',
        title: 'IBPS PO Prelims Master Guide',
        description:
            'Complete preparation guide for IBPS PO Prelims with Quantitative Aptitude and Reasoning',
        pdfUrl: 'https://www.clickdimensions.com/links/TestPDFfile.pdf',
        thumbnailUrl:
            'https://images.unsplash.com/photo-1554224155-6726b3ff858f?w=400&h=300&fit=crop',
        category: 'Banking',
        teacherName: 'Vikram Patel',
        createdAt: DateTime.now().subtract(Duration(days: 1)),
        isFree: false,
        isPdf: true,
        price: 199.0,
      ),
      NoteModel(
        id: '6',
        title: 'SBI Clerk Mains Complete Notes',
        description:
            'Detailed notes for SBI Clerk Mains covering English Language and General Awareness',
        pdfUrl:
            'https://www.ecma-international.org/wp-content/uploads/ECMA-262_6th_edition_june_2015.pdf',
        thumbnailUrl:
            'https://images.unsplash.com/photo-1560472354-b33ff0c44a43?w=400&h=300&fit=crop',
        category: 'Banking',
        teacherName: 'Sanjay Mehta',
        createdAt: DateTime.now().subtract(Duration(days: 2)),
        isFree: true,
        isPdf: true,
        price: 0.0,
      ),
      NoteModel(
        id: '7',
        title: 'RBI Assistant Exam Preparation',
        description:
            'Comprehensive study material for RBI Assistant examination with practice questions',
        pdfUrl:
            'https://www.rfc-editor.org/rfc/rfc793.pdf',
        thumbnailUrl:
            'https://images.unsplash.com/photo-1586953208448-b95a79798f07?w=400&h=300&fit=crop',
        category: 'Banking',
        teacherName: 'Anjali Desai',
        createdAt: DateTime.now().subtract(Duration(days: 3)),
        isFree: false,
        isPdf: true,
        price: 299.0,
      ),
      NoteModel(
        id: '8',
        title: 'Banking Awareness Current Affairs',
        description:
            'Latest banking current affairs and awareness capsule for all banking examinations',
        pdfUrl: 'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf',
        thumbnailUrl:
            'https://images.unsplash.com/photo-1559526324-4b87b5e36e44?w=400&h=300&fit=crop',
        category: 'Banking',
        teacherName: 'Rajesh Iyer',
        createdAt: DateTime.now().subtract(Duration(days: 4)),
        isFree: true,
        isPdf: true,
        price: 0.0,
      ),

      // UPSC Notes
      NoteModel(
        id: '9',
        title: 'UPSC Prelims General Studies Paper 1',
        description:
            'Complete coverage of GS Paper 1 including History, Geography, Polity, and Economy',
        pdfUrl:
            'https://www.ipcc.ch/site/assets/uploads/2018/02/ar4-wg1-spm-1.pdf',
        thumbnailUrl:
            'https://images.unsplash.com/photo-1551836022-d5d88e9218df?w=400&h=300&fit=crop',
        category: 'UPSC',
        teacherName: 'Dr. S. Krishnamurthy',
        createdAt: DateTime.now().subtract(Duration(days: 1)),
        isFree: false,
        isPdf: true,
        price: 499.0,
      ),
      NoteModel(
        id: '10',
        title: 'UPSC Mains Essay Writing Guide',
        description:
            'Comprehensive guide for UPSC Mains Essay paper with sample essays and writing techniques',
        pdfUrl: 'https://www.ietf.org/rfc/rfc2616.pdf',
        thumbnailUrl:
            'https://images.unsplash.com/photo-1455390582262-044cdead277a?w=400&h=300&fit=crop',
        category: 'UPSC',
        teacherName: 'Prof. Meena Sharma',
        createdAt: DateTime.now().subtract(Duration(days: 2)),
        isFree: true,
        isPdf: true,
        price: 0.0,
      ),
      NoteModel(
        id: '11',
        title: 'UPSC Optional Subjects Overview',
        description:
            'Detailed analysis and preparation strategy for popular UPSC optional subjects',
        pdfUrl:
            'https://www.gnu.org/licenses/gpl-3.0.pdf',
        thumbnailUrl:
            'https://images.unsplash.com/photo-1521737711867-e3b97375f902?w=400&h=300&fit=crop',
        category: 'UPSC',
        teacherName: 'Dr. A. Khan',
        createdAt: DateTime.now().subtract(Duration(days: 3)),
        isFree: false,
        isPdf: true,
        price: 399.0,
      ),
      NoteModel(
        id: '12',
        title: 'UPSC Monthly Current Affairs Digest',
        description:
            'Comprehensive monthly current affairs compilation for UPSC preparation',
        pdfUrl:
            'https://www.adobe.com/support/products/enterprise/knowledgecenter/media/c4611_sample_explain.pdf',
        thumbnailUrl:
            'https://images.unsplash.com/photo-1504711434969-e33886168f5c?w=400&h=300&fit=crop',
        category: 'UPSC',
        teacherName: 'Ravi Verma',
        createdAt: DateTime.now().subtract(Duration(days: 4)),
        isFree: true,
        isPdf: true,
        price: 0.0,
      ),

      // Railway Notes
      NoteModel(
        id: '13',
        title: 'RRB NTPC Mathematics & Reasoning',
        description:
            'Complete Mathematics and Reasoning preparation guide for RRB NTPC examination',
        pdfUrl: 'https://www.mozilla.org/media/PDFs/Firefox_Privacy_Notice_en_US.pdf',
        thumbnailUrl:
            'https://images.unsplash.com/photo-1544620347-c4fd4a3d5957?w=400&h=300&fit=crop',
        category: 'Railway',
        teacherName: 'Mohan Das',
        createdAt: DateTime.now().subtract(Duration(days: 1)),
        isFree: false,
        isPdf: true,
        price: 179.0,
      ),
      NoteModel(
        id: '14',
        title: 'RRB Group D Science & GK Notes',
        description:
            'Essential Science and General Knowledge notes for RRB Group D examination',
        pdfUrl:
            'https://www.w3.org/TR/WCAG21/wcag21.pdf',
        thumbnailUrl:
            'https://images.unsplash.com/photo-1507146153580-69a1fe6d8aa1?w=400&h=300&fit=crop',
        category: 'Railway',
        teacherName: 'Sunita Reddy',
        createdAt: DateTime.now().subtract(Duration(days: 2)),
        isFree: true,
        isPdf: true,
        price: 0.0,
      ),
      NoteModel(
        id: '15',
        title: 'Railway Apprentice Technical Guide',
        description:
            'Comprehensive technical preparation material for Railway Apprentice examinations',
        pdfUrl:
            'https://www.apache.org/licenses/LICENSE-2.0.pdf',
        thumbnailUrl:
            'https://images.unsplash.com/photo-1581092918056-0c4c3acd3789?w=400&h=300&fit=crop',
        category: 'Railway',
        teacherName: 'Anil Kapoor',
        createdAt: DateTime.now().subtract(Duration(days: 3)),
        isFree: false,
        isPdf: true,
        price: 249.0,
      ),
      NoteModel(
        id: '16',
        title: 'Railway General Knowledge Update',
        description:
            'Latest General Knowledge and current affairs specifically for Railway examinations',
        pdfUrl: 'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf',
        thumbnailUrl:
            'https://images.unsplash.com/photo-1449824913935-59a10b8d2000?w=400&h=300&fit=crop',
        category: 'Railway',
        teacherName: 'Pooja Mishra',
        createdAt: DateTime.now().subtract(Duration(days: 4)),
        isFree: true,
        isPdf: true,
        price: 0.0,
      ),
    ];
  }

  static Future<bool> _requestPermissions() async {
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      
      if (androidInfo.version.sdkInt >= 33) {
        // Android 13+ (API 33+) - Request specific media permissions
        var status = await Permission.photos.request();
        return status.isGranted;
      } else if (androidInfo.version.sdkInt >= 30) {
        // Android 11-12 (API 30-32) - Try MANAGE_EXTERNAL_STORAGE first
        var status = await Permission.manageExternalStorage.request();
        if (!status.isGranted) {
          // Fallback to storage permission
          status = await Permission.storage.request();
        }
        return status.isGranted;
      } else {
        // Android 10 and below (API 29 and below)
        var status = await Permission.storage.request();
        return status.isGranted;
      }
    }
    return true; // iOS doesn't need these permissions for app documents
  }

  static Future<String> downloadPDF(String url, String fileName) async {
    try {
      print('Starting download for: $fileName');
      print('URL: $url');

      // Clean filename - remove special characters but keep spaces and dashes
      String cleanFileName = fileName
          .replaceAll(RegExp(r'[<>:"/\\|?*]'), '') // Remove invalid file characters
          .trim();
      
      if (cleanFileName.isEmpty) {
        cleanFileName = 'downloaded_file';
      }

      // Request permissions first
      bool hasPermission = await _requestPermissions();
      print('Permission granted: $hasPermission');
      
      if (!hasPermission) {
        throw Exception('Storage permission is required to download files');
      }

      String filePath;

      if (Platform.isAndroid) {
        final androidInfo = await DeviceInfoPlugin().androidInfo;
        print('Android SDK: ${androidInfo.version.sdkInt}');

        if (androidInfo.version.sdkInt >= 30) {
          // Android 11+ (API 30+) - Use public Downloads directory
          try {
            // Try the standard Downloads folder first
            Directory downloadsDirectory = Directory('/storage/emulated/0/Download');
            
            if (downloadsDirectory.existsSync()) {
              filePath = '${downloadsDirectory.path}/$cleanFileName.pdf';
              print('Using public Downloads: $filePath');
            } else {
              // Fallback: try Documents folder
              Directory documentsDirectory = Directory('/storage/emulated/0/Documents');
              if (documentsDirectory.existsSync()) {
                filePath = '${documentsDirectory.path}/$cleanFileName.pdf';
                print('Using Documents folder: $filePath');
              } else {
                // Final fallback: app external storage
                Directory? externalDir = await getExternalStorageDirectory();
                filePath = '${externalDir!.path}/Downloads/$cleanFileName.pdf';
                // Create the Downloads subdirectory
                Directory(externalDir.path + '/Downloads').createSync(recursive: true);
                print('Using app external storage: $filePath');
              }
            }
          } catch (e) {
            print('Error accessing Downloads directory: $e');
            // Ultimate fallback
            Directory? externalDir = await getExternalStorageDirectory();
            filePath = '${externalDir!.path}/$cleanFileName.pdf';
          }
        } else {
          // Android 10 and below (API 29 and below)
          try {
            Directory downloadsDirectory = Directory('/storage/emulated/0/Download');
            if (downloadsDirectory.existsSync()) {
              filePath = '${downloadsDirectory.path}/$cleanFileName.pdf';
              print('Using legacy Downloads: $filePath');
            } else {
              Directory? externalDir = await getExternalStorageDirectory();
              String downloadsPath = '${externalDir!.path}/Downloads';
              Directory(downloadsPath).createSync(recursive: true);
              filePath = '$downloadsPath/$cleanFileName.pdf';
              print('Created app Downloads folder: $filePath');
            }
          } catch (e) {
            print('Error with legacy storage: $e');
            Directory? externalDir = await getExternalStorageDirectory();
            filePath = '${externalDir!.path}/$cleanFileName.pdf';
          }
        }
      } else {
        // iOS - Use Documents directory
        Directory documentsDirectory = await getApplicationDocumentsDirectory();
        filePath = '${documentsDirectory.path}/$cleanFileName.pdf';
        print('Using iOS Documents: $filePath');
      }

      print('Final file path: $filePath');

      // Check if file already exists and add number if needed
      String originalFilePath = filePath;
      int counter = 1;
      while (File(filePath).existsSync()) {
        String nameWithoutExtension = cleanFileName;
        filePath = '${originalFilePath.substring(0, originalFilePath.lastIndexOf('/'))}/${nameWithoutExtension}_$counter.pdf';
        counter++;
      }

      // Configure Dio for better download handling
      _dio.options.connectTimeout = Duration(seconds: 30);
      _dio.options.receiveTimeout = Duration(seconds: 30);
      _dio.options.followRedirects = true;
      _dio.options.maxRedirects = 5;

      print('Starting download...');

      // Download file with progress tracking
      await _dio.download(
        url,
        filePath,
        options: Options(
          headers: {
            'User-Agent': 'Mozilla/5.0 (Android 10; Mobile; rv:81.0) Gecko/81.0 Firefox/81.0',
            'Accept': 'application/pdf,application/octet-stream,*/*',
            'Accept-Encoding': 'identity', // Disable compression to avoid issues
          },
          followRedirects: true,
          validateStatus: (status) {
            return status != null && status < 500;
          },
          responseType: ResponseType.bytes, // Ensure binary download
        ),
        onReceiveProgress: (received, total) {
          if (total != -1) {
            double progress = (received / total * 100);
            print('Download progress: ${progress.toStringAsFixed(1)}% ($received/$total bytes)');
          } else {
            print('Downloaded: $received bytes');
          }
        },
      );

      // Verify file was created and has content
      File downloadedFile = File(filePath);
      if (!downloadedFile.existsSync()) {
        throw Exception('Failed to create file at $filePath');
      }

      int fileSize = await downloadedFile.length();
      if (fileSize == 0) {
        await downloadedFile.delete();
        throw Exception('Downloaded file is empty - the PDF might not be accessible');
      }

      // Check if it's actually a PDF (basic check)
      var bytes = await downloadedFile.readAsBytes();
      if (bytes.length < 4 || 
          bytes[0] != 0x25 || bytes[1] != 0x50 || bytes[2] != 0x44 || bytes[3] != 0x46) {
        // File doesn't start with %PDF, might not be a valid PDF
        print('Warning: File might not be a valid PDF');
      }

      print('✅ File downloaded successfully!');
      print('📁 Location: $filePath');
      print('📄 Size: ${(fileSize / 1024).toStringAsFixed(2)} KB');

      return filePath;
    } catch (e) {
      print('❌ Download error: $e');
      // Provide more specific error messages
      if (e.toString().contains('Permission denied')) {
        throw Exception('Permission denied. Please grant storage permission and try again.');
      } else if (e.toString().contains('No space left')) {
        throw Exception('Insufficient storage space on device.');
      } else if (e.toString().contains('Network')) {
        throw Exception('Network error. Please check your internet connection.');
      } else {
        throw Exception('Download failed: ${e.toString()}');
      }
    }
  }
}