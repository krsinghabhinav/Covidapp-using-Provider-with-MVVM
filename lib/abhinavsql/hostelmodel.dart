class HostelModel {
  final int? id;

  final String? hostelName;
  final String? hostelImage;
  final List<String>? hostelImages; // List of images
  final double? rating;
  final String? description;
  final String? security;
  final String? mobile;
  final String? address;

  HostelModel({
    this.id,
    this.hostelName,
    this.hostelImage,
    this.hostelImages,
    this.rating,
    this.description,
    this.security,
    this.mobile,
    this.address,
  });

  // Convert model to map for storing in the database
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'hostelName': hostelName,
      'hostelImage': hostelImage,
      'hostelImages':
          hostelImages?.join(','), // Store as comma-separated values
      'rating': rating,
      'description': description,
      'security': security,
      'mobile': mobile,
      'address': address,
    };
  }

  // Create a model from map (retrieved from the database)
  factory HostelModel.fromMap(Map<String, dynamic> map) {
    return HostelModel(
      id: map['id'],
      hostelName: map['hostelName'],
      hostelImage: map['hostelImage'],
      hostelImages: map['hostelImages'] != null
          ? (map['hostelImages'] as String).split(',') // Convert back to list
          : null,
      rating: map['rating'] != null ? map['rating'].toDouble() : null,
      description: map['description'],
      security: map['security'],
      mobile: map['mobile'],
      address: map['address'],
    );
  }
}
