//: [Previous](@previous)

//import Foundation
//import Combine
//
//enum SwiftError : Error {
//    case errorSTrinToInt
//}
//
//func mapStringToNumber(with stringValue: String) throws -> Int {
//    guard let result = Int(stringValue) else {
//        throw SwiftError.errorSTrinToInt
//    }
//    return result
//}
//
//let strinPublisher  = PassthroughSubject<String, SwiftError>()
//
//
//
//strinPublisher
//    .tryMap { value in
//        try mapStringToNumber(with: value)
//    }
//    .retry(3)
//    .sink { completed in
//    print(completed)
//} receiveValue: { value in
////    print(value)
//}
//
//strinPublisher.send("35")
//strinPublisher.send("cincuenta")
//
//strinPublisher.send("40")
//strinPublisher.send("cincuenta")
//strinPublisher.send("cincuenta")
//
//strinPublisher.send("90")
