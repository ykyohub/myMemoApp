//
//  TableViewController.swift
//  myMemoApp
//
//  Created by 윤규호 on 12/18/23.
//

import UIKit

struct Todo: Codable{
    let title: String
    let todoContent: String
    let iscompleted: Bool
}
var todoList: [Todo] = [Todo(title: "초기", todoContent: "메모앱 개발", iscompleted: false)]

class TableViewController: UITableViewController, AddProtocol {
    func addList(title: String, content: String) {
        let add = Todo(title: title, todoContent: content, iscompleted: false)
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(add) {
            UserDefaults.standard.set(encoded, forKey: "todoList")
        }
    }
    @IBAction func tappedAddButton(_ sender: Any) {
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "showAddToDo") as? AddViewController else { return }
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBOutlet var listView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        saveList()
        addList()
        loadList()
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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return todoList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        
        cell.textLabel?.text = todoList[indexPath.row].title
        
        return cell
    }
    
    private func saveList() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(todoList) {
            UserDefaults.standard.set(encoded, forKey: "todoList")
        }
    }
    
    private func loadList() {
        guard let storedData = UserDefaults.standard.value(forKey: "todoList"),
              let decodedList = try? JSONDecoder().decode(Todo.self, from: storedData as! Data) else { return }
        
        todoList.append(decodedList)
        print(decodedList)
        
    }
    
    private func addList() {
        let add = Todo(title: "추가 할 일", todoContent: "밥 먹기...", iscompleted: false)
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(add) {
            UserDefaults.standard.set(encoded, forKey: "todoList")
        }
    }
    
    private func deleteList() {
        UserDefaults.standard.removeObject(forKey: "todoList")
        todoList = []
        saveList()
    }
}
