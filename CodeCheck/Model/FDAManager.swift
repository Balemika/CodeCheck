//
//  FDAManager.swift
//  CodeCheck
//
//  Created by Ņikita Roldugins on 19/03/2022.
//

import Foundation

protocol FDAManagerDelegate {
    func didUpdateAPI(_ FDAManager: FDAManager, api: [Results])
}

struct FDAManager {
    let FDAURL = "https://api.fda.gov/food/enforcement.json?limit="
    var delegate: FDAManagerDelegate?
    
    
    func fetchAPI(limit: Int) {
        let urlString = "\(FDAURL)\(limit)"
        performRequest(with: urlString)
    }
    
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    return
                }
                if let safeData = data {
                    if let api = self.parseJSON(safeData) {
                        self.delegate?.didUpdateAPI(self, api: api)
                    }
                }
            }
            task.resume()
        }
    }
    
    
    // Get data from JSON
    func parseJSON(_ safeData: Data) -> [Results]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(FDAData.self, from: safeData)
            let value = decodedData.results
            return value
        } catch {
            return nil
        }
    }
}


