
  final String baseurl="https://task_manager_server-ef8njrh-muhsin-p.globeapp.dev";


Uri buildBaseUrl(String endPoint) {
  Uri url = Uri.parse(endPoint);
  if (!endPoint.startsWith('http')) url = Uri.parse('$baseurl$endPoint');


  return url;
}