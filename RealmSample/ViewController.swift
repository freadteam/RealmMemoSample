//
//  ViewController.swift
//  RealmSample
//
//  Created by Ryo Endo on 2018/07/11.
//  Copyright © 2018年 Ryo Endo. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let realm = try! Realm()
    var memoes = [Memo]()
    var selectedMemo: Memo?
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadMemoes()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailViewCOntroller = segue.destination as! DetailViewController
       detailViewCOntroller.passedMemo = selectedMemo
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memoes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = memoes[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedMemo = memoes[indexPath.row]
        performSegue(withIdentifier: "toDetail", sender: nil)
    }
    
    func loadMemoes() {
        //全部
        let allMemo = realm.objects(Memo.self)
        memoes = [Memo]()
        for memo in allMemo {
            self.memoes.append(memo)
        }
        tableView.reloadData()
    }
    
    @IBAction func addMemo() {
        let alert = UIAlertController(title: "コメント", message: "コメントして", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "キャンセル", style: .default) { (action) in
            alert.dismiss(animated: true, completion: nil)
        }
        //okした時の処理
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            alert.dismiss(animated: true, completion: nil)
            let memo = Memo()
            memo.title = alert.textFields![0].text!
            memo.text = alert.textFields![1].text!
            //固有のid
            memo.id = NSUUID().uuidString
            try! self.realm.write {
                self.realm.add(memo)
                self.memoes.append(memo)
            }
            self.loadMemoes()
            self.tableView.reloadData()
        }
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        alert.addTextField { (textField) in
            textField.placeholder = "title"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "text"
        }
        //ipadで必須
        alert.popoverPresentationController?.sourceView = self.view
        let screenSize = UIScreen.main.bounds
        // ここで表示位置を調整
        // xは画面中央、yは画面下部になる様に指定
        alert.popoverPresentationController?.sourceRect = CGRect(x: screenSize.size.width/2, y: screenSize.size.height, width: 0, height: 0)
        self.present(alert, animated: true, completion: nil)
    }
    

}

