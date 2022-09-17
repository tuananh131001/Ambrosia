// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let title = try? newJSONDecoder().decode(Title.self, from: jsonData)

import Foundation

// MARK: - Title
struct Place: Codable {
    let searchMetadata: SearchMetadata
    let searchParameters: SearchParameters
    let placeResults: PlaceResults

    enum CodingKeys: String, CodingKey {
        case searchMetadata = "search_metadata"
        case searchParameters = "search_parameters"
        case placeResults = "place_results"
    }
}

// MARK: - PlaceResults
struct PlaceResults: Codable {
    let title, placeID, dataID, dataCid: String
    let reviewsLink, photosLink: String
    let gpsCoordinates: GpsCoordinates
    let placeIDSearch: String
    let thumbnail: String
    let rating: Double
    let reviews: Int
    let price: String
    let type: [String]
    let placeResultsDescription: String
    let extensions: [Extension]
    let address: String
    let website: String
    let phone, openState, plusCode: String
    let hours: [Hour]
    let images: [PlaceResultsImage]
    let userReviews: UserReviews
    let peopleAlsoSearchFor: [PeopleAlsoSearchFor]
    let popularTimes: PopularTimes

    enum CodingKeys: String, CodingKey {
        case title
        case placeID = "place_id"
        case dataID = "data_id"
        case dataCid = "data_cid"
        case reviewsLink = "reviews_link"
        case photosLink = "photos_link"
        case gpsCoordinates = "gps_coordinates"
        case placeIDSearch = "place_id_search"
        case thumbnail, rating, reviews, price, type
        case placeResultsDescription = "description"
        case extensions, address, website, phone
        case openState = "open_state"
        case plusCode = "plus_code"
        case hours, images
        case userReviews = "user_reviews"
        case peopleAlsoSearchFor = "people_also_search_for"
        case popularTimes = "popular_times"
    }
}

// MARK: - Extension
struct Extension: Codable {
    let highlights, popularFor, accessibility, offerings: [String]?
    let diningOptions, amenities, atmosphere, crowd: [String]?
    let payments: [String]?

    enum CodingKeys: String, CodingKey {
        case highlights
        case popularFor = "popular_for"
        case accessibility, offerings
        case diningOptions = "dining_options"
        case amenities, atmosphere, crowd, payments
    }
}

// MARK: - GpsCoordinates
struct GpsCoordinates: Codable {
    let latitude, longitude: Double
}

// MARK: - Hour
struct Hour: Codable {
    let friday, saturday, sunday, monday: String?
    let tuesday, wednesday, thursday: String?
}

// MARK: - PlaceResultsImage
struct PlaceResultsImage: Codable {
    let title: String
    let thumbnail: String
}

// MARK: - PeopleAlsoSearchFor
struct PeopleAlsoSearchFor: Codable {
    let searchTerm: String
    let localResults: [LocalResult]

    enum CodingKeys: String, CodingKey {
        case searchTerm = "search_term"
        case localResults = "local_results"
    }
}

// MARK: - LocalResult
struct LocalResult: Codable {
    let position: Int
    let title, dataID, dataCid: String
    let reviewsLink, photosLink: String
    let gpsCoordinates: GpsCoordinates
    let placeIDSearch: String
    let rating: Double
    let reviews: Int
    let thumbnail: String
    let type: [String]

    enum CodingKeys: String, CodingKey {
        case position, title
        case dataID = "data_id"
        case dataCid = "data_cid"
        case reviewsLink = "reviews_link"
        case photosLink = "photos_link"
        case gpsCoordinates = "gps_coordinates"
        case placeIDSearch = "place_id_search"
        case rating, reviews, thumbnail, type
    }
}

// MARK: - PopularTimes
struct PopularTimes: Codable {
    let graphResults: GraphResults
    let liveHash: LiveHash

    enum CodingKeys: String, CodingKey {
        case graphResults = "graph_results"
        case liveHash = "live_hash"
    }
}

// MARK: - GraphResults
struct GraphResults: Codable {
    let sunday, monday, tuesday, wednesday: [Day]
    let thursday, friday, saturday: [Day]
}

// MARK: - Day
struct Day: Codable {
    let time: String
    let busynessScore: Int
    let info: Info?

    enum CodingKeys: String, CodingKey {
        case time
        case busynessScore = "busyness_score"
        case info
    }
}

enum Info: String, Codable {
    case usuallyALittleBusy = "Usually a little busy"
    case usuallyAsBusyAsItGets = "Usually as busy as it gets"
    case usuallyNotBusy = "Usually not busy"
    case usuallyNotTooBusy = "Usually not too busy"
}

// MARK: - LiveHash
struct LiveHash: Codable {
    let info, timeSpent: String

    enum CodingKeys: String, CodingKey {
        case info
        case timeSpent = "time_spent"
    }
}



// MARK: - UserReviews
struct UserReviews: Codable {
    let summary: [Summary]
    let mostRelevant: [MostRelevant]

    enum CodingKeys: String, CodingKey {
        case summary
        case mostRelevant = "most_relevant"
    }
}

// MARK: - MostRelevant
struct MostRelevant: Codable {
    let username: String
    let rating: Int
    let mostRelevantDescription: String
    let images: [MostRelevantImage]
    let date: String

    enum CodingKeys: String, CodingKey {
        case username, rating
        case mostRelevantDescription = "description"
        case images, date
    }
}

// MARK: - MostRelevantImage
struct MostRelevantImage: Codable {
    let thumbnail: String
}

// MARK: - Summary
struct Summary: Codable {
    let snippet: String
}

// MARK: - SearchMetadata
struct SearchMetadata: Codable {
    let id, status: String
    let jsonEndpoint: String
    let createdAt, processedAt: String
    let googleMapsURL: String
    let rawHTMLFile: String
    let totalTimeTaken: Double

    enum CodingKeys: String, CodingKey {
        case id, status
        case jsonEndpoint = "json_endpoint"
        case createdAt = "created_at"
        case processedAt = "processed_at"
        case googleMapsURL = "google_maps_url"
        case rawHTMLFile = "raw_html_file"
        case totalTimeTaken = "total_time_taken"
    }
}

// MARK: - SearchParameters
struct SearchParameters: Codable {
    let engine, type, data, googleDomain: String
    let hl: String

    enum CodingKeys: String, CodingKey {
        case engine, type, data
        case googleDomain = "google_domain"
        case hl
    }
}
