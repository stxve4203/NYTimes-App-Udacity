//
//  NYTimesService.swift
//  Last-Udacity-Project
//
//  Created by Stefan Weiss on 19.04.22.
//

import Foundation
import UIKit

class NYTimesService {
    
    func getParametersWithSection() -> [String: Any] {
        
        let parameters = ([
            ParameterKeys.APIKey: Constants.API_KEY
        ] as? [String: Any])!
        return parameters
    }
    
    func getNYTimesURLAndParameters(parameters: [String: Any], selectedCategory: String) -> URL? {
        var components = URLComponents()
        components.scheme = API.Scheme
        components.host = API.Host
        components.path = "/svc/topstories/v2/\(selectedCategory).json"
        
        let queryItems = [URLQueryItem(name: "api-key", value: "pwDZKFUfrxvgjiX5LAq02N5YNsxHncMv")]
        components.queryItems = queryItems
        return components.url
    }
    
    func getRequest<ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, completionHandler: @escaping (ResponseType?, Error?) -> Void) -> URLSessionDataTask {
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completionHandler(nil, error)
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                let responseData = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completionHandler(responseData, nil)
                }
            } catch {
                DispatchQueue.main.async {
                    print(error)
                    completionHandler(nil, error)
                }
            }
        }
        task.resume()
        return task
    }
    
    func getArticlesFromNYTimesAPI(selectedCategory: String, completionHandler: @escaping([Article]?, Error?) -> Void) {
        
        let parameters = getParametersWithSection()
        let url = getNYTimesURLAndParameters(parameters: parameters, selectedCategory: selectedCategory)!
       
        let request = getRequest(url: url, responseType: Articles.self) { data, error in
            guard let data = data else {
                completionHandler(nil, error)
                return
            }
            DispatchQueue.main.async {
                completionHandler(data.results, nil)
            }
            
        }
        }
    
    func getImages(img: String?, completionHandler: @escaping (UIImage?, Error?) -> Void) {
        guard let imageURL = img else {
            completionHandler(nil, nil)
            return
        }
        let url = URL(string: img!)
        let request = URLRequest(url: url!)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let image = UIImage(data: data!) else {
                DispatchQueue.main.async {

                completionHandler(nil, error)
                }
                return
            }
            DispatchQueue.main.async {
                completionHandler(image, nil)

            }
        }
        task.resume()
    }
}
