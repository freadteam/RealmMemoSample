//
//  DetailViewController.swift
//  RealmSample
//
//  Created by Ryo Endo on 2018/07/12.
//  Copyright © 2018年 Ryo Endo. All rights reserved.
//

import UIKit
import RealmSwift

class DetailViewController: UIViewController {
    
    let realm = try! Realm()
    var passedMemo: Memo!
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var textTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleTextField.text = passedMemo.title
        textTextField.text = passedMemo.text
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func trashButton(_ sender: Any) {
        if let selectedMemo = realm.objects(Memo.self).filter("id like '\(passedMemo.id)'").first {
            try! realm.write {
                realm.delete(selectedMemo)
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @IBAction func refreshButton(_ sender: Any) {
        if let selectedMemo = realm.objects(Memo.self).filter("id like '\(passedMemo.id)'").first {
            try! realm.write {
                selectedMemo.title = titleTextField.text!
                selectedMemo.text = textTextField.text!
            }
        }
    }
    
}
