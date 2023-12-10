import Foundation
import Combine

struct CurrencyDisplayModel: Identifiable {
    var currency: Currency
    
    var id: Int { currency.id }
    
    func getImageURL() -> URL {
        URL.fromRawString(currency.image)
    }
}

class CurrencySelectionViewModel: ObservableObject {
    private var service: CurrencyServiceProtocol
    
    private var subscriptions = Set<AnyCancellable>()
    
    @Published var currencies: [CurrencyDisplayModel] = []
    @Published var state: StateFoo
    @Published var selectedCurrency: Currency?
    
    init(service: CurrencyServiceProtocol) {
        self.service = service
        self.state = .loading
        
        loadData()
    }
    
    func loadData() {
        service.listCurrencies()
            .print("------", to: nil)
            .map { currencies in
                currencies.map { currency in
                    CurrencyDisplayModel(currency: currency)
                }
            }
            .sink { completion in
                if case .failure(let error) = completion {
                    print("----- getCurrencies failed: \(error)")
                }
            } receiveValue: { currencies in
                self.currencies = currencies
                self.state = .loading
            }
            .store(in: &subscriptions)
    }
}
