//
//  APIService.swift
//  RaceApp
//
//  Created by James Abanto on 15/7/2024.
//

import Foundation

protocol APIManageable {
    func request<T: Codable>(
        url: URL?,
        headers: [String:String]?,
        method: HTTPMethod,
        body: Dictionary<String, Any>?) async throws -> T
}

extension APIManageable {
    func request<T: Codable>(
        url: URL?,
        headers: [String:String]? = nil,
        method: HTTPMethod = .get,
        body: Dictionary<String, Any>? = nil) async throws -> T {
            guard let url = url else {
                throw APIError.invalidURL
            }
            var request = URLRequest(url: url)
            request.httpMethod = method.rawValue
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let response = response as? HTTPURLResponse,
                  response.statusCode == 200 else {
                throw APIError.invalidResponse
            }
            
            return try JSONDecoder().decode(T.self, from: data)
        }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

enum APIError: Error {
    case invalidResponse
    case invalidURL
}
