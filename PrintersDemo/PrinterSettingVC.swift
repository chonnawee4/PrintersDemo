//
//  PrinterSettingVC.swift
//  PrintersDemo
//
//  Created by Chonnawee Chatcherthaicharoen on 3/15/2560 BE.
//  Copyright © 2560 Chonnawee Chatcherthaicharoen. All rights reserved.
//

import UIKit
import Hero
import RealmSwift

class PrinterSettingVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var addPrinterVC: AddPrinterVC?
    var printers: [DeviceInfo]?
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        printers = Array(getPrintersFromDatabase()).map({result in
            guard let printer = result.printer else {
                return DeviceInfo()
            }
            return printer
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }
    
    func getPrintersFromDatabase() -> Results<Printers> {
        do {
            let realm = try Realm()
            return realm.objects(Printers.self)
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }
    
    @IBAction func addPrinter() {
        addPrinterVC = self.storyboard!.instantiateViewController(withIdentifier: "AddPrinterVC") as? AddPrinterVC
        
        if addPrinterVC != nil {
            Hero.shared.setDefaultAnimationForNextTransition(.pageIn(direction: .up))
            hero_replaceViewController(with: addPrinterVC!)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = printers?.count else {
            return 0
        }
        
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PrinterCell", for: indexPath) as! PrinterCell
        
        guard let printer = printers?[indexPath.row] else {
            return cell
        }
        
        cell.nameLabel.text = printer.name
        cell.addressLabel.text = printer.address
        cell.roleLabel.text = printer.role
        
        return cell
    }
    
}
