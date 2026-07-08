//: [Previous](@previous)

import Foundation
import Combine

/*
let inpublisher = PassthroughSubject<Int, Never>()

let datacancellable = inpublisher
    .map {
        
        // el  "$0" es el valor que esta recibiendo la subscripcion
        String($0)
    }
    .sink { complete  in
    print("Complete \(complete)")
} receiveValue: { value in
    
    // el map lo que hace es converit a strign y como modifica pasa de int a string por ende el string es el valor origonar
    
//    let stringValue = String(value)

    print(" value \(value)")
//    print("Parse \(stringValue)")
}


inpublisher.send(55)
inpublisher.send(32)
 
 */

// tambien podemos ejecudata el publisher directamente

//[32, 35, 66]
//    .publisher
//    .map {
//        String($0)
//    }
//    .sink { value  in
//        print("Origin Value \(value)")
//    }


//: [Next](@next)
