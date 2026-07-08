//: [Previous](@previous)

import Foundation
import Combine
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

struct ResourcesData: Decodable {
    let characters: String
    let locations: String
    let episodes: String
   
}

func getData () -> AnyPublisher<ResourcesData, Error> {
    
        let url = URL(string: "https://rickandmortyapi.com/api")!
        return URLSession.shared.dataTaskPublisher(for: url)
//            .tryMap{ (data, response) -> Data in
//                guard let httResponse = response as? HTTPURLResponse,
//                      httResponse.statusCode == 200 else {
//                    throw URLError(.badURL)
//                }
//                return data
//            }
    
    // podemos usar el map pero perdemos la modularidad del trymap
            .map(\.data)
    
    
            .decode(type: ResourcesData.self, decoder:  JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
            
    
}

let cancellable = getData()
    .sink { completed in
    switch completed {
    case .finished:
        print("Finished")
    case .failure(let error) :
        print(error)
    }
} receiveValue: { data in
    print(data)
}

//: [Next](@next)
