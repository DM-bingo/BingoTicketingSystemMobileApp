class ApiException implements Exception{
final String message;

ApiException(this.message);

@override
String toString() => message;


}

void handleApiResponse(int statusCode, String body){

    if(statusCode >= 200 && statusCode < 300){
      return;
    }else if(statusCode == 401){
      throw ApiException("Niste prijavljeni");
    }else if(statusCode == 403){
      throw ApiException("Nemate dozvolu");
    }else if(statusCode == 500){
      throw ApiException("Greška na serveru");
    }else{
      throw ApiException("Greška: $body");
    }

}