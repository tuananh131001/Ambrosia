//
//  NewRestaurantModel.swift
//  Ambrosia
//
//  Created by Nhung Tran on 09/09/2022.
//

import Foundation

final class NewRestaurantModel: ObservableObject {
    @Published var results: [Restaurant] = []
    @Published var hasError  = false
    @Published var error: RestaurantError?

    func fetchRestaurant() {
        hasError = false
        let urlString = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?keyword=restaurant&location=10.73578300%2C106.69093400&radius=1500&type=restaurant&key=AIzaSyBtCts3HUN6SLrVPBY8LLsm4rNnleUtvZY"
//        let urlString = "https://jsonplaceholder.typicode.com/users"
        if let url = URL(string: urlString) {
            URLSession.shared
                .dataTask(with: url) { [weak self] data, response, error in

                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    if let error = error {
                        print ("error")
                    } else {
                        print(data!)
                        let decoder = JSONDecoder()
                        //                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                        if let data = data,
                            let users = try? decoder.decode(NewRestaurant.self, from: data) {
                            print(users)
                            self?.results = users.results
                        }
                        else {
                            print("notthing")
                        }
                    }
                }
            }.resume()

        }

    }
}

extension NewRestaurantModel {
    enum RestaurantError: LocalizedError {
        case custom(error: Error)
        case failedToDecode
        var errorDescription: String? {
            switch self {
            case.failedToDecode:
                return "Failed to decode response"
            case .custom(let error):
                return error.localizedDescription
            }
        }
    }
}
