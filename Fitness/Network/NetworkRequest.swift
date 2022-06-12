//
//  NetworkRequest.swift
//  Fitness
//
//  Created by Nataliya Lazouskaya on 11.06.22.
//

import Foundation

class NetworkRequest{
    
    static let shared = NetworkRequest()
    private init(){}
    
    func requestData(completion: @escaping(Result<Data, Error>) -> Void){
        
        let key = "7d9421820b3edf24bdd3268dac110cda"
        let latitude = 55.29
        let longitude = 28.48
        
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(key)&units=metric"
        
        guard let url = URL(string: urlString) else { return }// иначе выходим из метода
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let data = data else { return }
                completion(.success(data))
            }
        }
        .resume()
    }
}
