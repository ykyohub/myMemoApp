//
//  TableViewController.swift
//  myMemoApp
//
//  Created by 윤규호 on 12/18/23.
//

import UIKit

struct Todo: Codable{
    var id: Int
    var category: String
    var todoContent: String
    var iscompleted: Bool
}
var todoList: [Todo] = [Todo(id: 0, category: "공부", todoContent: "메모앱 개발", iscompleted: false),
                        Todo(id: 1, category: "공부", todoContent: "앱 강의 수강", iscompleted: false),
                        Todo(id: 2, category: "놀기", todoContent: "풋살", iscompleted: false),
                        Todo(id: 3, category: "놀기", todoContent: "여행", iscompleted: false)]

var sections: [String: [Todo]] = [:]
var userDefault = UserDefaults.standard

class TableViewController: UITableViewController, AddProtocol, EditProtocol {
    
    var delegate: EditProtocol?
    
    @IBAction func tappedAddButton(_ sender: Any) {
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "showAddToDo") as? AddViewController else { return }
        self.navigationController?.pushViewController(nextVC, animated: true)
        nextVC.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sgDetail" {
            let cell = sender as! AddListTableViewCell
            let indexPath = self.tableView.indexPath(for: cell)
            let detailView = segue.destination as! DetailViewController
            detailView.receiveItem(todoList[((indexPath as NSIndexPath?)?.row)!].id, todoList[((indexPath as NSIndexPath?)?.row)!].category, todoList[((indexPath as NSIndexPath?)?.row)!].todoContent)
        
            let detail = Array(sections.keys)[indexPath!.section]
            if let todosInSection = sections[detail] {
                let todo = todosInSection[indexPath!.row]
                detailView.receiveItem(todo.id, todo.category, todo.todoContent)
                print("dudldldldl", todo.id)
            }
            detailView.delegate = self
            
        }
    }
    
    @IBOutlet var listView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSection()
        
        listView.delegate = self
        listView.dataSource = self
    }
    
    func setSection() {
        sections = [:]
        for todo in todoList {
            if sections[todo.category] == nil {
                sections[todo.category] = [todo]
            } else {
                sections[todo.category]?.append(todo)
            }
        }
    }
    
    func addList(category: String, content: String) {
        
        let add = Todo(id: (todoList.last?.id ?? -1) + 1, category: category, todoContent: content, iscompleted: false)
        
        if var existingCategory = sections[category] {
            existingCategory.append(add)
            sections[category] = existingCategory
            todoList.append(add)
        } else {
            sections[category] = [add]
            todoList.append(add)
        }
        
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(todoList) {
            userDefault.set(encoded, forKey: "todoList")
        }
        listView.reloadData()
    }
    
    func editList(id: Int, category: String, content: String) {
        
        todoList[id] = Todo(id: id, category: category, todoContent: content, iscompleted: false)
        setSection()
        
        listView.reloadData()
    }
    
    //뷰가 노출될 때마다 리스트 데이터 다시 불러옴
    override func viewWillAppear(_ animated: Bool) {
        listView.reloadData()
    }
    
    //Edit 도중, AddViewController 로 이동시 편집중단
    override func viewWillDisappear(_ animated: Bool) {
        print(#function)
    }
    
    // 삭제 기능
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let category = Array(sections.keys)[indexPath.section]
            
            if var todosInSection = sections[category] {
                
                let deletedTodo = todosInSection.remove(at: indexPath.row)
                
                if let indexInTodoList = todoList.firstIndex(where: { $0.id == deletedTodo.id }) {
                    todoList.remove(at: indexInTodoList)
                }
                userDefault.removeObject(forKey: "\(deletedTodo.id)")
                sections[category] = todosInSection
                tableView.deleteRows(at: [indexPath], with: .fade)
                if todosInSection.isEmpty {
                    sections.removeValue(forKey: category)
                }
                tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let category = Array(sections.keys)[section]
        return sections[category]?.count ?? 0
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.keys.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Array(sections.keys)[section]
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = listView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! AddListTableViewCell
        
        let category = Array(sections.keys)[indexPath.section]
        if let todosInSection = sections[category] {
            let todo = todosInSection[indexPath.row]
            cell.textLabel?.text = todo.todoContent
            cell.isCompletedSwitch?.isOn = todo.iscompleted
        }
        return cell
    }
}
