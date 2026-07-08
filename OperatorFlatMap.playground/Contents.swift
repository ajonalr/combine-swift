//: [Previous](@previous)

import Foundation
import Combine


struct User {
    let email: String
    let name: String
}

enum RegisterFormError: String, Error {
    case userExists = "User already exists"
    case emailExisit = "Email already exists"
    case passwordIsWeak = "Password is too weak"
    case unknown = "Unknown error"
}


let user: User  = .init(email: "ariel12jona@gmail.com", name: "Ariel Ramirez")


func registerUser(user: User) -> AnyPublisher<User, RegisterFormError>{
    
    if user.email == "ariel12jona@gmail.com" {
        return Just(user).setFailureType(to: RegisterFormError.self ).eraseToAnyPublisher()
    } else {
        return Fail(error: RegisterFormError.emailExisit)
            .eraseToAnyPublisher()
    }
    
}


func save(user: User) -> AnyPublisher<Bool, RegisterFormError>{
    
    if user.name == "Ariel Ramirez123" {
        return Just(true).setFailureType(to: RegisterFormError.self ).eraseToAnyPublisher()
    } else {
        return Fail(error: RegisterFormError.unknown)
            .eraseToAnyPublisher()
    }
    
}


//registerUser(user: user)
//    .flatMap{ user in
//        save(user: user)
//    }
//    .catch({ _ in
//        Just(false)
//    })
//    .sink { completed in
//        switch completed {
//        case .finished:
//            print(completed)
//        case .failure (let error):
//            print(error)
//        }
//    } receiveValue: { user in
//            print("Final \(user)")
//    }

//: [Next](@nex
