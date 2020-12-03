//
//  ViewController.swift
//  ObvsDemo
//
//  Created by Harlan Kellaway on 12/2/20.
//

import Obvs
import UIKit

class ViewController: UIViewController {

    private let dateTimeViewModel = DateTimeViewModel()
    private var disposeBag = DisposeBag()

    private var dateTimeLabel = UILabel()
    private var saveTimeButton = UIButton()
    private var savedTimesTextView = UITextView()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupBindings()
    }

    private func setupBindings() {
        dateTimeViewModel
            .formattedDateTime
            .bind(to: \.text, on: dateTimeLabel)
            .disposed(by: &disposeBag)

        dateTimeViewModel
            .saveFormattedDateTime
            .subscribe { [weak self] newValue, _ in
                self?.savedTimesTextView.text.append(newValue)
            }
            .disposed(by: &disposeBag)
    }

    private func setupUI() {
        dateTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(dateTimeLabel)
        NSLayoutConstraint.activate([
            dateTimeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 64),
            dateTimeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ])

        saveTimeButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(saveTimeButton)
        saveTimeButton.setTitle("Save current time", for: .normal)
        saveTimeButton.backgroundColor = .systemTeal
        NSLayoutConstraint.activate([
            saveTimeButton.leadingAnchor.constraint(equalTo: dateTimeLabel.leadingAnchor),
            saveTimeButton.topAnchor.constraint(equalTo: dateTimeLabel.bottomAnchor, constant: 16)
        ])
        saveTimeButton.addTarget(self, action: #selector(didTapSaveTimeButton), for: .touchUpInside)

        savedTimesTextView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(savedTimesTextView)
        savedTimesTextView.isEditable = false
        NSLayoutConstraint.activate([
            savedTimesTextView.leadingAnchor.constraint(equalTo: saveTimeButton.leadingAnchor),
            savedTimesTextView.topAnchor.constraint(equalTo: saveTimeButton.bottomAnchor, constant: 16),
            savedTimesTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            savedTimesTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    @objc private func didTapSaveTimeButton() {
        dateTimeViewModel.didTapSaveTimeButton()
    }

}

