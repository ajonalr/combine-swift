


// el Passth no tiene ningun valor por defecto
// el currentvalue si podemos definirun valor por defecr

import UIKit
import Combine

/*
struct Weather  {
                                        // El Int: es el tipo de valor de salida, y El Error: es el tipo de "error si ocurriera"
    let weatherPublisher = PassthroughSubject<Int, Error>()
    
    func getWeather() {
        weatherPublisher.send(10)
//        weatherPublisher.send(completion: .finished)
        weatherPublisher.send(completion: .failure(URLError(.badURL)))
    
        // como indicamos el completation todo lo que esta debajo ya no se envia
    
        weatherPublisher.send(11)
    }
}

let weather  = Weather()
weather.weatherPublisher.sink { complete in
    switch complete {
    case .failure(let error):
        print("Error \(error)")
    case .finished:
        print("Finished")
    }
} receiveValue: { valueData in
    print("Data recived: \(valueData)")
}


weather.getWeather()
 */

//
//@MainActor
//struct BotApp {
//    var onboardingPublisher = CurrentValueSubject<String, Error>("Example in Combine")
//
//    func startOnboarding() {
//        onboardingPublisher.send("Welcome to the app")
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//            onboardingPublisher.send("Proof")
//        }
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
//            onboardingPublisher.send("Example 2")
//        }
//    }
//}
//
//
//let botApp = BotApp()
//let cancellable = botApp.onboardingPublisher.sink { completedd in
//    print("Complete \(completedd)")
//} receiveValue: { value in
//    print("Valor \(value)")
//}
//botApp.startOnboarding()
