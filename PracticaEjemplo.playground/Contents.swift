import UIKit
import Combine

class RegisterViewModel {
    @Published var usernameInput: String = ""
    @Published var passwordInput: String = ""
    @Published var passwordConfirmationInput: String = ""
    @Published var isFormValid: Bool = false
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        setupValidationPipe()
    }
  
    private func setupValidationPipe() {
        Publishers.CombineLatest3($usernameInput, $passwordInput, $passwordConfirmationInput)
            .map { username, password, confirm in
                
                let isValidUsername = username.count > 3 && !username.contains(" ")

                let ispasswordValid = password.count >= 5
                
                let passwordMatched = password == confirm
                
                return isValidUsername && ispasswordValid && passwordMatched
            }
            .removeDuplicates()
            .assign(to: \.isFormValid, on: self)
        
            .store(in: &cancellables)
        
    }
    
}


let viewModel = RegisterViewModel()

//let subsctiption = viewModel.$isFormValid
//    .sink { isValid in
//        print("Fomulario  valido?: \(isValid ? "si": "no")")
//    }

//print("Ejecutando prueba --------")

// Prueba 1: Datos incompletos
viewModel.usernameInput = "arielramirez123"
viewModel.passwordInput = "secret123"

// Prueba 3: Todo correcto (Debería cambiar a SÍ ✅)
viewModel.passwordConfirmationInput = "secret123"



let newViewModel = RegisterViewModel()
//
//newViewModel.$isFormValid
//    .sink { ivalid in
//        print( "Is Valid: \(ivalid ? "si" : "no")" )
//    }

let subscriptiontow = newViewModel.usernameInput = "jona"
newViewModel.passwordInput = "secret1"
newViewModel.passwordConfirmationInput = "secret1"




