class PostResponse {
  PostResponse({
     this.data,
     this.errorCode,
     this.message,
     this.requestId,
     this.status,
     this.success,
  });

  final Data? data;
  final String? errorCode;
  final dynamic message;
  final dynamic requestId;
  final String? status;
  final bool? success;

  PostResponse copyWith({
    Data? data,
    String? errorCode,
    dynamic message,
    dynamic requestId,
    String? status,
    bool? success,
  }) {
    return PostResponse(
      data: data ?? this.data,
      errorCode: errorCode ?? this.errorCode,
      message: message ?? this.message,
      requestId: requestId ?? this.requestId,
      status: status ?? this.status,
      success: success ?? this.success,
    );
  }

  factory PostResponse.fromJson(Map<String, dynamic> json){
    return PostResponse(
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
      errorCode: json["errorCode"],
      message: json["message"],
      requestId: json["requestId"],
      status: json["status"],
      success: json["success"],
    );
  }

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
    "errorCode": errorCode,
    "message": message,
    "requestId": requestId,
    "status": status,
    "success": success,
  };

}

class Data {
  Data({
     this.content,
     this.pageable,
     this.last,
     this.totalElements,
     this.totalPages,
     this.first,
     this.size,
     this.number,
     this.sort,
     this.numberOfElements,
     this.empty,
  });

  final List<Content>? content;
  final Pageable? pageable;
  final bool? last;
  final int? totalElements;
  final int? totalPages;
  final bool? first;
  final int? size;
  final int? number;
  final Sort? sort;
  final int? numberOfElements;
  final bool? empty;

  Data copyWith({
    List<Content>? content,
    Pageable? pageable,
    bool? last,
    int? totalElements,
    int? totalPages,
    bool? first,
    int? size,
    int? number,
    Sort? sort,
    int? numberOfElements,
    bool? empty,
  }) {
    return Data(
      content: content ?? this.content,
      pageable: pageable ?? this.pageable,
      last: last ?? this.last,
      totalElements: totalElements ?? this.totalElements,
      totalPages: totalPages ?? this.totalPages,
      first: first ?? this.first,
      size: size ?? this.size,
      number: number ?? this.number,
      sort: sort ?? this.sort,
      numberOfElements: numberOfElements ?? this.numberOfElements,
      empty: empty ?? this.empty,
    );
  }

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      content: json["content"] == null ? [] : List<Content>.from(json["content"]!.map((x) => Content.fromJson(x))),
      pageable: json["pageable"] == null ? null : Pageable.fromJson(json["pageable"]),
      last: json["last"],
      totalElements: json["totalElements"],
      totalPages: json["totalPages"],
      first: json["first"],
      size: json["size"],
      number: json["number"],
      sort: json["sort"] == null ? null : Sort.fromJson(json["sort"]),
      numberOfElements: json["numberOfElements"],
      empty: json["empty"],
    );
  }

  Map<String, dynamic> toJson() => {
    "content": content?.map((x) => x.toJson()).toList(),
    "pageable": pageable?.toJson(),
    "last": last,
    "totalElements": totalElements,
    "totalPages": totalPages,
    "first": first,
    "size": size,
    "number": number,
    "sort": sort?.toJson(),
    "numberOfElements": numberOfElements,
    "empty": empty,
  };

}

class Content {
  Content({
     this.id,
     this.userId,
     this.fullName,
     this.imageProfile,
     this.content,
     this.status,
     this.placeId,
     this.placeName,
     this.placeContentType,
     this.detailLink,
     this.postSharedId,
     this.topic,
     this.topicName,
     this.likeCount,
     this.commentCount,
     this.shareCount,
     this.reportCount,
     this.createdAt,
     this.isFollower,
     this.isLike,
     this.contentType,
     this.thumbnail,
     this.url,
     this.postShare,
  });

  final int? id;
  final int? userId;
  final String? fullName;
  final String? imageProfile;
  final String? content;
  final int? status;
  final String? placeId;
  final String? placeName;
  final String? placeContentType;
  final String? detailLink;
  final int? postSharedId;
  final int? topic;
  final String? topicName;
  final int? likeCount;
  final int? commentCount;
  final int? shareCount;
  final int? reportCount;
  final int? createdAt;
  final int? isFollower;
  final int? isLike;
  final int? contentType;
  final String? thumbnail;
  final List<String>? url;
  final Content? postShare;

  Content copyWith({
    int? id,
    int? userId,
    String? fullName,
    String? imageProfile,
    String? content,
    int? status,
    String? placeId,
    String? placeName,
    String? placeContentType,
    String? detailLink,
    int? postSharedId,
    int? topic,
    String? topicName,
    int? likeCount,
    int? commentCount,
    int? shareCount,
    int? reportCount,
    int? createdAt,
    int? isFollower,
    int? isLike,
    int? contentType,
    String? thumbnail,
    List<String>? url,
    Content? postShare,
  }) {
    return Content(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      fullName: fullName ?? this.fullName,
      imageProfile: imageProfile ?? this.imageProfile,
      content: content ?? this.content,
      status: status ?? this.status,
      placeId: placeId ?? this.placeId,
      placeName: placeName ?? this.placeName,
      placeContentType: placeContentType ?? this.placeContentType,
      detailLink: detailLink ?? this.detailLink,
      postSharedId: postSharedId ?? this.postSharedId,
      topic: topic ?? this.topic,
      topicName: topicName ?? this.topicName,
      likeCount: likeCount ?? this.likeCount,
      commentCount: commentCount ?? this.commentCount,
      shareCount: shareCount ?? this.shareCount,
      reportCount: reportCount ?? this.reportCount,
      createdAt: createdAt ?? this.createdAt,
      isFollower: isFollower ?? this.isFollower,
      isLike: isLike ?? this.isLike,
      contentType: contentType ?? this.contentType,
      thumbnail: thumbnail ?? this.thumbnail,
      url: url ?? this.url,
      postShare: postShare ?? this.postShare,
    );
  }

  factory Content.fromJson(Map<String, dynamic> json){
    return Content(
      id: json["id"],
      userId: json["userId"],
      fullName: json["fullName"],
      imageProfile: json["imageProfile"],
      content: json["content"],
      status: json["status"],
      placeId: json["placeId"],
      placeName: json["placeName"],
      placeContentType: json["placeContentType"],
      detailLink: json["detailLink"],
      postSharedId: json["postSharedId"],
      topic: json["topic"],
      topicName: json["topicName"],
      likeCount: json["likeCount"],
      commentCount: json["commentCount"],
      shareCount: json["shareCount"],
      reportCount: json["reportCount"],
      createdAt: json["createdAt"],
      isFollower: json["isFollower"],
      isLike: json["isLike"],
      contentType: json["contentType"],
      thumbnail: json["thumbnail"],
      url: json["url"] == null ? [] : List<String>.from(json["url"]!.map((x) => x)),
      postShare: json["postShare"] == null ? null : Content.fromJson(json["postShare"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "fullName": fullName,
    "imageProfile": imageProfile,
    "content": content,
    "status": status,
    "placeId": placeId,
    "placeName": placeName,
    "placeContentType": placeContentType,
    "detailLink": detailLink,
    "postSharedId": postSharedId,
    "topic": topic,
    "topicName": topicName,
    "likeCount": likeCount,
    "commentCount": commentCount,
    "shareCount": shareCount,
    "reportCount": reportCount,
    "createdAt": createdAt,
    "isFollower": isFollower,
    "isLike": isLike,
    "contentType": contentType,
    "thumbnail": thumbnail,
    "url": url?.map((x) => x).toList(),
    "postShare": postShare?.toJson(),
  };

}

class Pageable {
  Pageable({
     this.pageNumber,
     this.pageSize,
     this.sort,
     this.offset,
     this.paged,
     this.unpaged,
  });

  final int? pageNumber;
  final int? pageSize;
  final Sort? sort;
  final int? offset;
  final bool? paged;
  final bool? unpaged;

  Pageable copyWith({
    int? pageNumber,
    int? pageSize,
    Sort? sort,
    int? offset,
    bool? paged,
    bool? unpaged,
  }) {
    return Pageable(
      pageNumber: pageNumber ?? this.pageNumber,
      pageSize: pageSize ?? this.pageSize,
      sort: sort ?? this.sort,
      offset: offset ?? this.offset,
      paged: paged ?? this.paged,
      unpaged: unpaged ?? this.unpaged,
    );
  }

  factory Pageable.fromJson(Map<String, dynamic> json){
    return Pageable(
      pageNumber: json["pageNumber"],
      pageSize: json["pageSize"],
      sort: json["sort"] == null ? null : Sort.fromJson(json["sort"]),
      offset: json["offset"],
      paged: json["paged"],
      unpaged: json["unpaged"],
    );
  }

  Map<String, dynamic> toJson() => {
    "pageNumber": pageNumber,
    "pageSize": pageSize,
    "sort": sort?.toJson(),
    "offset": offset,
    "paged": paged,
    "unpaged": unpaged,
  };

}

class Sort {
  Sort({
     this.sorted,
     this.empty,
     this.unsorted,
  });

  final bool? sorted;
  final bool? empty;
  final bool? unsorted;

  Sort copyWith({
    bool? sorted,
    bool? empty,
    bool? unsorted,
  }) {
    return Sort(
      sorted: sorted ?? this.sorted,
      empty: empty ?? this.empty,
      unsorted: unsorted ?? this.unsorted,
    );
  }

  factory Sort.fromJson(Map<String, dynamic> json){
    return Sort(
      sorted: json["sorted"],
      empty: json["empty"],
      unsorted: json["unsorted"],
    );
  }

  Map<String, dynamic> toJson() => {
    "sorted": sorted,
    "empty": empty,
    "unsorted": unsorted,
  };

}
