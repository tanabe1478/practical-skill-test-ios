//
//  HomeModel.swift
//  practical-skill-test-ios
//
//  Created by 田辺信之 on 2019/05/04.
//  Copyright © 2019 田辺信之. All rights reserved.
//

import Foundation
import UIKit

class HomeModel: NSObject, APIRequesting {
    typealias DataObject = Either<Either<ConnectionError, TransformError>, [String: TaskData]?>
    var taskList: TaskList?
    func request(method: HTTPMethodAndPayload, completion: @escaping (DataObject) -> Void) {
        switch method {
        case .get:
            getRequest(completion)
        default:
            return
        }
    }

    //"https://practical-skill-test-ios.firebaseio.com/tasks/-LdvDClk8XwSU8tIPf9y.json?print=pretty"
    private func getRequest(_ completion: @escaping (DataObject) -> Void) {
        TaskData.fetch(
            method: .get,
            apiPath: "https://practical-skill-test-ios.firebaseio.com/tasks/zdvDClk8XwSU8tIPf9y.json?print=pretty") { errorOrResult in
                completion(errorOrResult)

        }
    }

}

extension HomeModel: TaskCellDataSource {}

extension HomeModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let list = taskList?.tasks else { return 0 }
        return list.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let taskList = taskList, !taskList.tasks.isEmpty else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.nibName, for: indexPath) as! TaskCell
        cell.index = indexPath.row
        cell.dataSource = self
        return cell
    }
}
