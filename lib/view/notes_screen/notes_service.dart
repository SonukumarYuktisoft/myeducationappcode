import 'package:device_info_plus/device_info_plus.dart';
import 'package:education/view/notes_screen/models/note_model.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class NotesService {
  static final Dio _dio = Dio();

  // Dummy data - Replace with your API call
  // Updated getDummyNotes method with real network images and only free content
  static List<NoteModel> getDummyNotes() {
    return [
      // SSC Notes
      NoteModel(
        id: '1',
        title: 'SSC CGL 2026 Complete Study Guide',
        description:
            'Comprehensive notes covering Quantitative Aptitude, Reasoning, English, and General Awareness for SSC CGL 2026',
        pdfUrl: 'https://www.clickdimensions.com/links/TestPDFfile.pdf',
        thumbnailUrl:
            'https://images.unsplash.com/photo-1434030216411-0b793f4b4173?w=400&h=300&fit=crop',
        category: 'SSC',
        teacherName: 'Rahul Sharma',
        createdAt: DateTime.now().subtract(Duration(days: 1)),
        isFree: true,
        isPdf: true,
      ),
      NoteModel(
        id: '2',
        title: 'SSC CHSL Tier 1 Preparation Notes',
        description:
            'Complete preparation material with previous year questions and practice papers for SSC CHSL Tier 1',
        pdfUrl: 'https://www.clickdimensions.com/links/TestPDFfile.pdf',
        thumbnailUrl:
            'https://images.unsplash.com/photo-1456513080510-7bf3a84b82f8?w=400&h=300&fit=crop',
        category: 'SSC',
        teacherName: 'Priya Singh',
        createdAt: DateTime.now().subtract(Duration(days: 2)),
        isFree: true,
        isPdf: true,
      ),
      NoteModel(
        id: '3',
        title: 'SSC MTS Essential Study Material',
        description:
            'Focused study material covering all topics for SSC Multi Tasking Staff examination',
        pdfUrl:
            'https://www.adobe.com/support/products/enterprise/knowledgecenter/media/c4611_sample_explain.pdf',
        thumbnailUrl:
            'https://images.unsplash.com/photo-1481627834876-b7833e8f5570?w=400&h=300&fit=crop',
        category: 'SSC',
        teacherName: 'Amit Kumar',
        createdAt: DateTime.now().subtract(Duration(days: 3)),
        isFree: true,
        isPdf: true,
      ),
      NoteModel(
        id: '4',
        title: 'SSC Reasoning Quick Formula Guide',
        description:
            'Smart shortcuts and techniques for solving reasoning questions in minimum time',
        pdfUrl:
            'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf',
        thumbnailUrl:
            'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400&h=300&fit=crop',
        category: 'SSC',
        teacherName: 'Neha Gupta',
        createdAt: DateTime.now().subtract(Duration(days: 4)),
        isFree: true,
        isPdf: true,
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
        isFree: true,
        isPdf: true,
      ),
      NoteModel(
        id: '6',
        title: 'SBI Clerk Mains Complete Notes',
        description:
            'Detailed notes for SBI Clerk Mains covering English Language and General Awareness',
        pdfUrl:
            'https://www.adobe.com/support/products/enterprise/knowledgecenter/media/c4611_sample_explain.pdf',
        thumbnailUrl:
            'https://images.unsplash.com/photo-1560472354-b33ff0c44a43?w=400&h=300&fit=crop',
        category: 'Banking',
        teacherName: 'Sanjay Mehta',
        createdAt: DateTime.now().subtract(Duration(days: 2)),
        isFree: true,
        isPdf: true,
      ),
      NoteModel(
        id: '7',
        title: 'RBI Assistant Exam Preparation',
        description:
            'Comprehensive study material for RBI Assistant examination with practice questions',
        pdfUrl:
            'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf',
        thumbnailUrl:
            'https://images.unsplash.com/photo-1586953208448-b95a79798f07?w=400&h=300&fit=crop',
        category: 'Banking',
        teacherName: 'Anjali Desai',
        createdAt: DateTime.now().subtract(Duration(days: 3)),
        isFree: true,
        isPdf: true,
      ),
      NoteModel(
        id: '8',
        title: 'Banking Awareness Current Affairs',
        description:
            'Latest banking current affairs and awareness capsule for all banking examinations',
        pdfUrl: 'https://www.clickdimensions.com/links/TestPDFfile.pdf',
        thumbnailUrl:
            'https://images.unsplash.com/photo-1559526324-4b87b5e36e44?w=400&h=300&fit=crop',
        category: 'Banking',
        teacherName: 'Rajesh Iyer',
        createdAt: DateTime.now().subtract(Duration(days: 4)),
        isFree: true,
        isPdf: true,
      ),

      // UPSC Notes
      NoteModel(
        id: '9',
        title: 'UPSC Prelims General Studies Paper 1',
        description:
            'Complete coverage of GS Paper 1 including History, Geography, Polity, and Economy',
        pdfUrl:
            'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf',
        thumbnailUrl:
            'https://images.unsplash.com/photo-1551836022-d5d88e9218df?w=400&h=300&fit=crop',
        category: 'UPSC',
        teacherName: 'Dr. S. Krishnamurthy',
        createdAt: DateTime.now().subtract(Duration(days: 1)),
        isFree: true,
        isPdf: true,
      ),
      NoteModel(
        id: '10',
        title: 'UPSC Mains Essay Writing Guide',
        description:
            'Comprehensive guide for UPSC Mains Essay paper with sample essays and writing techniques',
        pdfUrl: 'https://www.clickdimensions.com/links/TestPDFfile.pdf',
        thumbnailUrl:
            'https://images.unsplash.com/photo-1455390582262-044cdead277a?w=400&h=300&fit=crop',
        category: 'UPSC',
        teacherName: 'Prof. Meena Sharma',
        createdAt: DateTime.now().subtract(Duration(days: 2)),
        isFree: true,
        isPdf: true,
      ),
      NoteModel(
        id: '11',
        title: 'UPSC Optional Subjects Overview',
        description:
            'Detailed analysis and preparation strategy for popular UPSC optional subjects',
        pdfUrl:
            'https://www.adobe.com/support/products/enterprise/knowledgecenter/media/c4611_sample_explain.pdf',
        thumbnailUrl:
            'https://images.unsplash.com/photo-1521737711867-e3b97375f902?w=400&h=300&fit=crop',
        category: 'UPSC',
        teacherName: 'Dr. A. Khan',
        createdAt: DateTime.now().subtract(Duration(days: 3)),
        isFree: true,
        isPdf: true,
      ),
      NoteModel(
        id: '12',
        title: 'UPSC Monthly Current Affairs Digest',
        description:
            'Comprehensive monthly current affairs compilation for UPSC preparation',
        pdfUrl:
            'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf',
        thumbnailUrl:
            'https://images.unsplash.com/photo-1504711434969-e33886168f5c?w=400&h=300&fit=crop',
        category: 'UPSC',
        teacherName: 'Ravi Verma',
        createdAt: DateTime.now().subtract(Duration(days: 4)),
        isFree: true,
        isPdf: true,
      ),

      // Railway Notes
      NoteModel(
        id: '13',
        title: 'RRB NTPC Mathematics & Reasoning',
        description:
            'Complete Mathematics and Reasoning preparation guide for RRB NTPC examination',
        pdfUrl: 'https://www.clickdimensions.com/links/TestPDFfile.pdf',
        thumbnailUrl:
            'https://images.unsplash.com/photo-1544620347-c4fd4a3d5957?w=400&h=300&fit=crop',
        category: 'Railway',
        teacherName: 'Mohan Das',
        createdAt: DateTime.now().subtract(Duration(days: 1)),
        isFree: true,
        isPdf: true,
      ),
      NoteModel(
        id: '14',
        title: 'RRB Group D Science & GK Notes',
        description:
            'Essential Science and General Knowledge notes for RRB Group D examination',
        pdfUrl:
            'https://www.adobe.com/support/products/enterprise/knowledgecenter/media/c4611_sample_explain.pdf',
        thumbnailUrl:
            'https://images.unsplash.com/photo-1507146153580-69a1fe6d8aa1?w=400&h=300&fit=crop',
        category: 'Railway',
        teacherName: 'Sunita Reddy',
        createdAt: DateTime.now().subtract(Duration(days: 2)),
        isFree: true,
        isPdf: true,
      ),
      NoteModel(
        id: '15',
        title: 'Railway Apprentice Technical Guide',
        description:
            'Comprehensive technical preparation material for Railway Apprentice examinations',
        pdfUrl:
            'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf',
        thumbnailUrl:
            'https://images.unsplash.com/photo-1581092918056-0c4c3acd3789?w=400&h=300&fit=crop',
        category: 'Railway',
        teacherName: 'Anil Kapoor',
        createdAt: DateTime.now().subtract(Duration(days: 3)),
        isFree: true,
        isPdf: true,
      ),
      NoteModel(
        id: '16',
        title: 'Railway General Knowledge Update',
        description:
            'Latest General Knowledge and current affairs specifically for Railway examinations',
        pdfUrl: 'https://www.clickdimensions.com/links/TestPDFfile.pdf',
        thumbnailUrl:
            'https://images.unsplash.com/photo-1449824913935-59a10b8d2000?w=400&h=300&fit=crop',
        category: 'Railway',
        teacherName: 'Pooja Mishra',
        createdAt: DateTime.now().subtract(Duration(days: 4)),
        isFree: true,
        isPdf: true,
      ),
    ];
  }

  static Future<bool> _requestPermissions() async {
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;

      if (androidInfo.version.sdkInt >= 33) {
        // Android 13+ - No need for storage permissions for downloads
        return true;
      } else if (androidInfo.version.sdkInt >= 30) {
        // Android 11-12 - Use MANAGE_EXTERNAL_STORAGE for better access
        var status = await Permission.manageExternalStorage.request();
        if (!status.isGranted) {
          status = await Permission.storage.request();
        }
        return status.isGranted;
      } else {
        // Android 10 and below
        var status = await Permission.storage.request();
        return status.isGranted;
      }
    }
    return true; // iOS doesn't need these permissions
  }

  static Future<String> downloadPDF(String url, String fileName) async {
    try {
      // Clean filename
      String cleanFileName =
          fileName.replaceAll(RegExp(r'[^\w\s-]'), '').trim();
      if (cleanFileName.isEmpty) {
        cleanFileName = 'downloaded_file';
      }

      // Request permissions
      bool hasPermission = await _requestPermissions();
      if (!hasPermission) {
        throw Exception('Storage permission is required to download files');
      }

      String filePath;

      if (Platform.isAndroid) {
        final androidInfo = await DeviceInfoPlugin().androidInfo;

        if (androidInfo.version.sdkInt >= 30) {
          // Android 11+ - Use public Downloads directory
          Directory? downloadsDirectory = Directory(
            '/storage/emulated/0/Download',
          );
          if (!downloadsDirectory.existsSync()) {
            // Fallback to app-specific directory
            downloadsDirectory = await getExternalStorageDirectory();
            filePath = '${downloadsDirectory!.path}/$cleanFileName.pdf';
          } else {
            filePath = '${downloadsDirectory.path}/$cleanFileName.pdf';
          }
        } else {
          // Android 10 and below
          Directory? downloadsDirectory = await getExternalStorageDirectory();
          String downloadsPath = '${downloadsDirectory!.path}/Downloads';
          Directory(downloadsPath).createSync(recursive: true);
          filePath = '$downloadsPath/$cleanFileName.pdf';
        }
      } else {
        // iOS
        Directory documentsDirectory = await getApplicationDocumentsDirectory();
        filePath = '${documentsDirectory.path}/$cleanFileName.pdf';
      }

      // Download file with progress tracking
      await _dio.download(
        url,
        filePath,
        options: Options(
          headers: {
            'User-Agent':
                'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36',
          },
          followRedirects: true,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
        onReceiveProgress: (received, total) {
          if (total != -1) {
            double progress = (received / total * 100);
            print('Download progress: ${progress.toStringAsFixed(0)}%');
          }
        },
      );

      // Verify file was created
      File downloadedFile = File(filePath);
      if (!downloadedFile.existsSync()) {
        throw Exception('Failed to create file at $filePath');
      }

      // Check if file has content
      int fileSize = await downloadedFile.length();
      if (fileSize == 0) {
        throw Exception('Downloaded file is empty');
      }

      print('File downloaded successfully to: $filePath');
      print('File size: ${(fileSize / 1024).toStringAsFixed(2)} KB');

      return filePath;
    } catch (e) {
      print('Download error: $e');
      throw Exception('Download failed: ${e.toString()}');
    }
  }
}
