//
//  TableViewController.swift
//  myMemoApp
//
//  Created by 윤규호 on 12/18/23.
//

import UIKit

struct Todo{
    var title: String
    var todoContent: String
    var iscompleted: Bool
}
var todo1 = Todo(title: "강의 수강", todoContent: "앱개발 종합반 강의 전체 수강 및 TIL 작성 등등...앱개발 종합반 강의 전체 수강 및 TIL 작성 등등...앱개발 종합반 강의 전체 수강 및 TIL 작성 등등...앱개발 종합반 강의 전체 수강 및 TIL 작성 등등...앱개발 종합반 강의 전체 수강 및 TIL 작성 등등...", iscompleted: false)
var todo2 = Todo(title: "메모 앱 초기개발",todoContent: "강의 다 들으면 메모 앱 만들기 과제 진행할 것", iscompleted: false)
var list:[Todo] = [todo1, todo2]

class TableViewController: UITableViewController {

    @IBOutlet var listView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    //좌측 상단 Edit (목록 삭제)
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            list.remove(at: (indexPath as NSIndexPath).row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    //뷰가 노출될 때마다 리스트 데이터 다시 불러옴
    override func viewWillAppear(_ animated: Bool) {
        listView.reloadData()
    }
    
    //Edit 도중, AddViewController 로 이동시 편집중단
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isEditing {
            setEditing(false, animated: true)
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return list.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        
        cell.textLabel?.text = list[indexPath.row].title
        
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "sgDetail" {
            let cell = sender as! UITableViewCell
            let indexPath = self.tableView.indexPath(for: cell)
            let detailView = segue.destination as! DetailViewController
            detailView.receiveItem(list[((indexPath as NSIndexPath?)?.row)!].title, list[((indexPath as NSIndexPath?)?.row)!].todoContent)
        }
    }
    
}
