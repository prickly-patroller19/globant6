import UIKit

final class MainTableViewController: UITableViewController {
    
    private let tableViewModelController = TableViewModel()
    @IBOutlet private weak var imageView: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pushLoadingView()
        imageView?.image = UIImage(named: "picture")
        configure()
        tableViewModelController.reload = { [weak self] section in
            let sections = IndexSet.init(integer: section)
            self?.tableView.reloadSections(sections, with: .none)
        }
        tableViewModelController.completeDidLoad = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.popLoadingView()
            }
        }
        tableViewModelController.fill()
        tableViewModelController.loadDidFail = { [weak self] in
            DispatchQueue.main.async {
                self?.popLoadingView()
                self?.alertFailure()
            }
        }
    }
    
    private func configure() {
        navigationItem.title = "Title".localized()
        tableView.dataSource = tableViewModelController
        tableView.delegate = tableViewModelController
    }
    
    private func pushLoadingView() {
        let loadingViewController = LoadingViewController()
        navigationController?.pushViewController(loadingViewController, animated: false)
    }
    
    private func popLoadingView() {
        navigationController?.popViewController(animated: false)
    }
    
    private func alertFailure() {
        let alert = UIAlertController(title: "MessageTitle".localized(),
                                      message: "MessageContent".localized(),
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "MessageButton".localized(),
                                      style: .default,
                                      handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
