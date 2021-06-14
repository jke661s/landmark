//
//  SaveLandmarkViewController.swift
//  LandmarkRemark
//
//  Created by Jackie Wang on 13/6/21.
//

import UIKit
 
final class SaveLandmarkViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    // MARK: - Properties
    
    /// The location to be saved.
    private var location: Location!
    
    /// The view model of SaveLandmarkViewController.
    private var viewModel: SaveLandmarkViewModelProviding!
    
    /// The table view.
    private lazy var tableView: UITableView = configure(UITableView(frame: .zero, style: .grouped)) {
        $0.delegate = self
        $0.dataSource = self
        $0.keyboardDismissMode = .onDrag
        $0.register(InputUsernameCell.self,
                    forCellReuseIdentifier: SaveLandmarkCellType.inputUsername.rawValue)
        $0.register(InputDescriptionCell.self,
                    forCellReuseIdentifier: SaveLandmarkCellType.inputDescription.rawValue)
    }
    
    /// The button to save landmark
    private let saveButton: UIButton = configure(UIButton(type: .system)) {
        $0.setTitle(Strings.Title.save, for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.isEnabled = false
        $0.backgroundColor = Colors.disabledButtonBackground
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = CornerRadius.medium
    }
    
    // MARK: - Life cycle
    
    init(location: Location) {
        super.init()
        self.location = location
        viewModel = SaveLandmarkViewModel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupBindings()
    }
    
    // MARK: - Private functions
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        view.addSubview(saveButton)
    }
    
    private func setupConstraints() {
        // save button constraints
        NSLayoutConstraint.activate([
            saveButton.heightAnchor.constraint(equalToConstant: 50),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 14),
            saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -14),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -14)
        ])
        
        // table view constraints
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupBindings() {
        viewModel.isFormValidated.bind { [weak self] isFormValidated in
            guard let self = self, let isFormValidated = isFormValidated else { return }
            self.saveButton.isEnabled = isFormValidated
            self.saveButton.backgroundColor = isFormValidated ?
                Colors.enabledButtonBackground : Colors.disabledButtonBackground
        }
    }
    
    // MARK: - UITableViewDelegate conformance
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        44
    }
    
    // MARK: - UITableViewDataSource conformance
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        viewModel.sections[safe: section]?.title ?? Strings.empty
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.sections[safe: section]?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: viewModel
                                                    .sections[safe: indexPath.section]?
                                                    .items[safe: indexPath.item]?
                                                    .type.rawValue ?? Strings.empty,
                                                 for: indexPath)
        if let cell = cell as? SaveLandmarkCellProviding {
            var itemViewModel = viewModel.sections[safe: indexPath.section]?.items[safe:indexPath.item] ?? SaveLandmarkItemViewModel()
            itemViewModel.delegate = viewModel
            cell.update(viewModel: itemViewModel)
        }
        return cell
    }
}
