//: [Previous](@previous)

import Foundation
import Combine

//@MainActor
//func createdUser () -> Future<String, Never>{
//    return Future { promise in
////        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
////            promise(.success("Hola mundo"))
//////            print("Hello Word")
////        }
////
//        // otra forma de hacer casi lo missmo
//
//        Task {
//            try? await Task.sleep(nanoseconds: 5 * 1_000_000_000) // 5 segundos
//            promise(.success("Hola mundo"))
//        }
//
//    }
//}

//let cancellable = createdUser()
//    .sink { complete in
//        print(complete)
//    } receiveValue: { value in
//        print("Valor -> \(value)")
//    }


struct ResourcesDataModel: Decodable {
    let characters: String
    let locations: String
    let episodes: String
}

@MainActor
func getResourcesPromise() -> Future<ResourcesDataModel, Error> { // Cambiado a Error por seguridad
    return Future { promise in
        Task {
            guard let url = URL(string: "https://rickandmortyapi.com/api") else {
                promise(.failure(URLError(.badURL)))
                return
            }
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let dataModel = try JSONDecoder().decode(ResourcesDataModel.self, from: data)
                promise(.success(dataModel))
                
            } catch {
                promise(.failure(error))
            }
        }
    }
}
//
//let cancellable = getResourcesPromise()
//    .sink { completion in
//        if case .failure(let error) = completion {
//            print("Error en la descarga: \(error)")
//        }
//    } receiveValue: { value in
//        print("¡Éxito! Characters URL: \(value)")
//    }


//: [Next](@next)
