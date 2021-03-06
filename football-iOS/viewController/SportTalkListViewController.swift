
import Foundation
import UIKit
import RxSwift
import RxCocoa
import Instantiate
import InstantiateStandard

class SportTalkListViewController: UITableViewController,StoryboardInstantiatable{


    
    

 

    private let disposeBag = DisposeBag()
    lazy var viewModel: SportTalkListViewModel = {


        return SportTalkListViewModel()
    }()



    override func viewDidLoad() {
        super.viewDidLoad()
        

        viewModel.viewDidLoad.onNext(())
        self.tableView.delegate = nil
        self.tableView.dataSource = nil
        bindViewModel()
    }

    override func loadView() {
        super.loadView()

        tableView.register(UINib.init(nibName: "SportTalkListCell", bundle: nil), forCellReuseIdentifier: "SportTalkListCell")
        self.tableView.tableFooterView = UIView(frame: .zero)
        tableView.rowHeight = UITableView.automaticDimension
    }
    


    override func viewWillAppear(_ animated: Bool) {
    }

    func bindViewModel() {

        
        viewModel.teams
            .bind(to: tableView.rx.items(cellIdentifier: "SportTalkListCell", cellType: SportTalkListCell.self)) { _, element, cell in
                cell.team = element
            }.disposed(by: disposeBag)

        tableView.rx.modelSelected(Team.self)
            .subscribe(onNext: { team in
                let teamDetailViewController:TeamDetailViewController = TeamDetailViewController.instantiate(with: .init(team: team))
                self.navigationController?.pushViewController(teamDetailViewController, animated: true)
            }).disposed(by: disposeBag)

    }
}



