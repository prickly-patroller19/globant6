
import UIKit
@testable import CVCodeChallenge

final class MainTableViewControllerTestDouble: UITableViewController {
    
    private let tableViewModelController = TableViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewModelController.fill()
    }
}
