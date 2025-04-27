import 'package:html/dom.dart';
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;
import 'package:link_manager/app_logger.dart';

final class NTKApi {
  static const String _baseUrl = 'https://www.techlib.cz/cs/';

  static Future<int?> getPeopleCount() async {
    

    try {
      final response = await http.get(Uri.parse(_baseUrl));

      if (response.statusCode == 200) {
        Document document = parser.parse(response.body);
        final span = document.querySelector('.panel-body.text-center.lead span');
        final numberText = span?.text.trim();

        if (numberText != null) {
          return int.tryParse(numberText);
        }
      } else {
        AppLogger.logError('Failed to load page: ${response.statusCode}');
      }
    } catch (e) {
      AppLogger.logError('Error fetching people count: $e');
    }
    return null;
  }
}
