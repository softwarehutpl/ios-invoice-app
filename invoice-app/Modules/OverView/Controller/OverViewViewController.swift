//
//  OverViewViewController.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 23/10/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import UIKit

enum CellType {
    case date
    case topSummaryView
    case lastInvoices
    case charts
}

class OverViewViewController: BaseViewController {
    
    let celltypes = [CellType.date, CellType.topSummaryView, CellType.lastInvoices, CellType.charts]

    //MARK: - Private
    private let viewModel: OverViewViewModelType
    
    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!{
        didSet {
            tableView.allowsSelection = false
            tableView.separatorStyle = .none
            tableView.showsVerticalScrollIndicator = false
            tableView.showsHorizontalScrollIndicator = false
            tableView.clipsToBounds = true
           }
       }
    
    
    //MARK: - Init
    init(viewModel: OverViewViewModelType) {
        self.viewModel = viewModel
        super.init()
    }
    
    //MARK: - Setup Views
     private func cellRegister() {
         let dateCell = UINib(nibName: DateCell.identyfier, bundle: nil)
         tableView.register(dateCell, forCellReuseIdentifier: DateCell.identyfier)
         let topSummaryCell = UINib(nibName: TopSummaryCell.identyfier, bundle: nil)
         tableView.register(topSummaryCell, forCellReuseIdentifier: TopSummaryCell.identyfier)
         let lastInvoicesCell = UINib(nibName: LastInvoicesCell.identyfier, bundle: nil)
         tableView.register(lastInvoicesCell, forCellReuseIdentifier: LastInvoicesCell.identyfier)
         let chartsCell = UINib(nibName: ChartsCell.identyfier, bundle: nil)
         tableView.register(chartsCell, forCellReuseIdentifier: ChartsCell.identyfier)
     }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        cellRegister()
        title = "Overview"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension OverViewViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 2 {
            return view.frame.height * 0.4
        }
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = celltypes[indexPath.row]
        switch cellType {
        case .date:
            guard let dateCell = tableView.dequeueReusableCell(withIdentifier: DateCell.identyfier, for: indexPath) as? DateCell else {
                fatalError(cellError.showError(cellTitle: DateCell.self, cellID: DateCell.identyfier))
            }
            return dateCell
        case .topSummaryView:
            guard let topSummaryCell = tableView.dequeueReusableCell(withIdentifier: TopSummaryCell.identyfier, for: indexPath) as? TopSummaryCell else { fatalError(cellError.showError(cellTitle: TopSummaryCell.self, cellID: TopSummaryCell.identyfier))
            }
            return topSummaryCell
        case .lastInvoices:
            guard let lastInvoices = tableView.dequeueReusableCell(withIdentifier: LastInvoicesCell.identyfier, for: indexPath) as? LastInvoicesCell else { fatalError(cellError.showError(cellTitle: LastInvoicesCell.self, cellID: LastInvoicesCell.identyfier))
            }
            return lastInvoices
        case .charts:
            guard let chartsCell = tableView.dequeueReusableCell(withIdentifier: ChartsCell.identyfier, for: indexPath) as? ChartsCell else { fatalError(cellError.showError(cellTitle: ChartsCell.self, cellID: ChartsCell.identyfier))
            }
            return chartsCell
        }
    }
}
