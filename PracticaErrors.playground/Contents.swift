import UIKit
import Combine
import PlaygroundSupport // 1. Importa esto

// 2. Dile al Playground que no se cierre inmediatamente al leer la última línea
PlaygroundPage.current.needsIndefiniteExecution = true

struct Perfil {
    let nombre: String
    let email: String
}


enum RedError: Error {
    case conexionInestable
}

@MainActor
class ProfileViewMolde: ObservableObject {
    
    @Published var usuarioId: Int = 0
    @Published var nombrePantalla: String = "Cargando..."
    
    private var cancellables = Set<AnyCancellable>()
    
    var simuladordefallos = 0
    
    init () {
        
        setupPerfileProfile()
        
    }
    
    private func setupPerfileProfile () {
        
        $usuarioId
            .dropFirst()
            .flatMap {userID in self.getInfoProfile(id: userID) }
            .retry(2)
            .catch { _ in Just(Perfil(nombre: "Usuario Offline ⚠️", email: "none")) }
            .map{ perfil in String(perfil.nombre + " \n Correo " + perfil.email)  }
            .assign(to: &$nombrePantalla)
        
    }
 
    private func getInfoProfile (id: Int) -> AnyPublisher<Perfil, RedError> {
        
        simuladordefallos += 1
        
        if simuladordefallos <= 2 {
            print("🌐 [Servidor] Intento \(simuladordefallos): Error de red detectado...")
            return Fail(error: RedError.conexionInestable).eraseToAnyPublisher()
        }
        print("🌐 [Servidor] Intento \(simuladordefallos): ¡Conexión exitosa!")
        
        return Just(Perfil( nombre: "Ariel Ramirez", email: "ariel12jona@gmail.com" ) )
            .setFailureType(to: RedError.self )
            .eraseToAnyPublisher()
    }
    
}


let viewModel = ProfileViewMolde()

//let subcripcion = viewModel.$nombrePantalla.sink { print("📺 Pantalla muestra: \n \($0)\n") }


//print("--- Solicitando Perfil del Usuario ---")
//viewModel.usuarioId = 102
//viewModel.usuarioId = 102
//viewModel.usuarioId = 102
