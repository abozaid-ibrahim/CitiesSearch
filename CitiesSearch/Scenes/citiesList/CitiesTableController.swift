//
//  AirportsTableController.swift
//  CitiesSearch
//
//  Created by abuzeid on 30.10.20.
//  Copyright © 2020 abuzeid. All rights reserved.
//

import UIKit

final class CitiesTableController: UITableViewController {
    private let viewModel: CitiesViewModelType
    private var dataList: [City] = []

    init(with viewModel: CitiesViewModelType = CitiesViewModel()) {
        self.viewModel = viewModel
        super.init(style: .plain)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bindToViewModel()
        setupSearchBar()
    }
}

// MARK: - Table view data source

extension CitiesTableController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(cell: CityTableCell.self, for: indexPath)
        cell.setData(for: dataList[indexPath.row])
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        AppNavigator.shared.push(.map(dataList[indexPath.row]))
    }
}

// MARK: - UISearchResultsUpdating

extension CitiesTableController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard searchController.isActive else {
            viewModel.searchCanceled()
            return
        }
        guard let text = searchController.searchBar.text else { return }
        viewModel.search(for: text)
    }
}

// MARK: - Private

private extension CitiesTableController {
    func setupSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.isTranslucent = false
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        viewModel.isLoading.subscribe { [weak searchController] isLoading in
            searchController?.searchBar.isLoading = isLoading
        }
    }

    func bindToViewModel() {
        viewModel.citiesList.subscribe { [weak self] data in
            self?.dataList = data
            self?.tableView.reloadData()
        }

        viewModel.error.subscribe { [weak self] error in
            guard let self = self, let msg = error else { return }
            self.show(error: msg)
        }
    }

    func setup() {
        title = "City Finder"
        tableView.tableFooterView = UIView()
        tableView.register(CityTableCell.self, forCellReuseIdentifier: CityTableCell.identifier)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
