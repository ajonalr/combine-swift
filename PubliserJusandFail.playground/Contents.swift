//: [Previous](@previous)

import Foundation
import Combine


struct User {
    let email: String
    let name: String
}


let user: User = .init(email: "ariel12jona@gmail.com", name: "Ariel Ramirez")
//
//var justUser: AnyPublisher<User, Never> {
//    Just(user)
//        .eraseToAnyPublisher()
//}


//justUser.sink { completed in
//    switch completed {
//    case .finished:
//        print("Finish")
//    case .failure(let error):
//        print(error)
//    }
//} receiveValue: { user in
//    print(user)
//}

enum RegisterFormError: String, Error {
    case userExist = "User exist"
    case wrongEmail = "Wrong email"
    case wrongPassword = "Wrong password"
    case unknown = "Unknow"
}

let failPublisher = Fail<User, RegisterFormError>(error: .unknown).eraseToAnyPublisher()

//failPublisher.sink { completed in
//    switch completed {
//    case .finished:
//        print("Finish")
//    case .failure(let error):
//        print(error)
//    }
//} receiveValue: { user in
//    print(user)
//}


func register(user: User) -> AnyPublisher<User, RegisterFormError>{
    
    if user.email == "ariel12jona@gmail.com" {
        return Just(user).setFailureType(to: RegisterFormError.self ).eraseToAnyPublisher()
    } else {
        return Fail(error: RegisterFormError.wrongEmail)
            .eraseToAnyPublisher()
    }
    
}


//let cancellable  = register(user: user)
//    .sink { completed in
//        switch completed {
//           case .finished:
//               print("Finish")
//           case .failure(let error):
//               print(error)
//        }
//    } receiveValue: {  user in
//        print(user)
//    }

//: [Next](@next)
