//
//  AirportsTableController.swift
//  SchipholApp
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
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Discover"
        view.backgroundColor = .white
        tableView.tableFooterView = ActivityIndicatorFooterView()
        tableView.register(CityTableCell.self, forCellReuseIdentifier: CityTableCell.identifier)
        bindToViewModel()
        viewModel.search(for: "")
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
}

// MARK: - UISearchResultsUpdating

extension CitiesTableController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard searchController.isActive else {
//            viewModel.searchCanceled()
            return
        }
        guard let text = searchController.searchBar.text else { return }
        viewModel.search(for: text)
    }
}

// MARK: - Private

private extension CitiesTableController {
    var indicator: ActivityIndicatorFooterView? {
        return tableView.tableFooterView as? ActivityIndicatorFooterView
    }

    func setupSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
//           viewModel.isSearchLoading
//               .observeOn(MainScheduler.instance)
//               .subscribe(onNext: { [unowned searchController] in
//                   searchController.searchBar.isLoading = $0
//               }).disposed(by: disposeBag)
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    func bindToViewModel() {
        viewModel.citiesList.subscribe { [weak self] data in
            self?.dataList = data
            self?.tableView.reloadData()
        }
        viewModel.isLoading.subscribe { [weak self] isLoading in
            guard let self = self else { return }
            self.tableView.sectionFooterHeight = isLoading ? 80 : 0
            self.indicator?.set(isLoading: isLoading)
        }
        viewModel.error.subscribe { [weak self] error in
            guard let self = self, let msg = error else { return }
            self.show(error: msg)
        }
    }
}
