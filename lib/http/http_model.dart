/*
 * create by gj
 * Created in 2020/12/15 6:01 下午
 * description: 
 * */
class BannerModel {
  String title;
  int id;
  String url;
  String imagePath;

  BannerModel(this.title, this.id, this.url, this.imagePath);

  BannerModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        id = json['id'],
        url = json['url'],
        imagePath = json['imagePath'];

  Map<String, dynamic> toJson() => {
    'title': title,
    'id': id,
    'url': url,
    'imagePath': imagePath,
  };

  @override
  String toString() {
    StringBuffer sb = new StringBuffer('{');
    sb.write("\"title\":\"$title\"");
    sb.write(",\"id\":$id");
    sb.write(",\"url\":\"$url\"");
    sb.write(",\"imagePath\":\"$imagePath\"");
    sb.write('}');
    return sb.toString();
  }
}
