//
//  ViewController.swift
//  realm
//
//  Created by air on 3/15/25.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var memoTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveButtonClicked(_ sender: UIButton) {
        guard let name = nameTextField.text,
              let memo = memoTextField.text else {
            return
        }
        nameTextField.text = nil
        memoTextField.text = nil
        
        do {
            let realm = try Realm()
            let todo = Todo(name: name, memo: memo)
            try realm.write {
                realm.add(todo)
            }
            let todos = realm.objects(Todo.self)
            print(todos.map { ($0.name, $0.memo) })
        } catch {
            print(error)
        }
    }
    
}

// 01. 객체 모델 정의
class Todo: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var name: String = ""
    @Persisted var memo: String = ""
    
    convenience init(name: String, memo: String) {
        self.init()
        self.name = name
        self.memo = memo
    }
}
