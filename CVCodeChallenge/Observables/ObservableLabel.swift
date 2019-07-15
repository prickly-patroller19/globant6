import UIKit

final class ObservableLabel: UILabel {
    func bind(to observable: CVObservable<String>) {
        observable.valueChanged =  { [weak self] newValue in
            self?.text = newValue
        }
    }
    
    func bind(to observable: CVObservable<Int>) {
        observable.valueChanged =  { [weak self] newValue in
            guard let unwrappedValue = newValue else { return }
            self?.text = String(describing: unwrappedValue)
        }
    }
}
