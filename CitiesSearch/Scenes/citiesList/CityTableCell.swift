//
//  AirportTableCell.swift
//  CitiesSearch
//
//  Created by abuzeid on 30.10.20.
//  Copyright © 2020 abuzeid. All rights reserved.
//

import UIKit

final class CityTableCell: UITableViewCell {
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        return label
    }()

    private lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }

    func setData(for city: City) {
        nameLabel.text = city.address
        locationLabel.text = city.location
    }

    private func setup() {
        contentView.addSubview(nameLabel)
        nameLabel.setConstrainsEqualToParent(edge: [.leading, .trailing, .top], with: 12)
        contentView.addSubview(locationLabel)
        locationLabel.setConstrainsEqualToParent(edge: [.leading, .trailing, .bottom], with: 12)
        NSLayoutConstraint.activate([
            nameLabel.bottomAnchor.constraint(equalTo: locationLabel.topAnchor, constant: -8)])
        selectionStyle = .none
    }
}
