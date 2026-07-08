import UIKit
import Combine

@MainActor
class CuponDescuento: ObservableObject {
    
    @Published var codigoCupo: String = ""
    @Published var descuentoAplicadpo: Int = 0
    
    private var cancellable = Set<AnyCancellable>()
    
    init () {
        setCuponDescuento()
    }
    
    private func setCuponDescuento() {
        
        
        $codigoCupo
            .dropFirst()
            .filter { codigo in
                codigo.count > 5
            }
            .flatMap { codigo in
                self.validarCuponDB(codigo: codigo)
            }
            .assign(to: &$descuentoAplicadpo )
//            .store(in: &cancellable)
    }
    
    func validarCuponDB(codigo: String) -> Just<Int> {
        
        print("🌐 Consultando validez del cupón '\(codigo)' en el servidor...")
        
        if codigo.uppercased() == "JONA123" {
            return Just(25)
        } else {
            return Just(0)
        }
       
    }
    
}


let viewModel = CuponDescuento()

//let subscripcion = viewModel.$descuentoAplicadpo
//    .sink { print("💰 El descuento aplicado es del \($0)%") }


//viewModel.codigoCupo = "JONAS12"
//viewModel.codigoCupo = "jona1"
//viewModel.codigoCupo = "JONAS12456"
//viewModel.codigoCupo = "JONAS123"
//viewModel.codigoCupo = "JONA123"
