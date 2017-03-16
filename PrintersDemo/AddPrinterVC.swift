//
//  AddPrinterVC.swift
//  PrintersDemo
//
//  Created by Chonnawee Chatcherthaicharoen on 3/15/2560 BE.
//  Copyright © 2560 Chonnawee Chatcherthaicharoen. All rights reserved.
//

import UIKit
import Hero

class AddPrinterVC: UIViewController, Epos2DiscoveryDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var brandTextField: UITextField!
    @IBOutlet weak var roleTextField: UITextField!
    
    var deviceList: [DeviceInfo]?
    var printerSettingVC: PrinterSettingVC?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.layer.borderColor = UIColor.lightGray.cgColor
        collectionView.layer.borderWidth = 0.4
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if (!animated) {
            deviceList = [DeviceInfo]()
            
            DispatchQueue.global(qos: .background).async {
                self.startStarDiscovery()
            }
            
            startEpsonDiscovery()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        stopEpsonDiscovery()
    }
    
    func startEpsonDiscovery() {
        let filterOption = Epos2FilterOption()
        filterOption.broadcast = "255.255.255.255"
        filterOption.portType = EPOS2_PORTTYPE_ALL.rawValue
        filterOption.deviceModel = EPOS2_MODEL_ALL.rawValue
        filterOption.deviceType = EPOS2_TYPE_ALL.rawValue
        
        let result = Epos2Discovery.start(filterOption, delegate: self)
        if result != EPOS2_SUCCESS.rawValue {
            print("Error on start")
            return
        }
    }
    
    func stopEpsonDiscovery() {
        var result: Epos2ErrorStatus = EPOS2_SUCCESS
        
        result = Epos2ErrorStatus(rawValue: Epos2Discovery.stop())
        
        if result != EPOS2_SUCCESS {
            print("Error on stop")
            return
        }
    }
    
    func startStarDiscovery() {
        var searchPrinterResult = [PortInfo]()
        searchPrinterResult = SMPort.searchPrinter() as! [PortInfo]
        
        for portInfo: PortInfo in searchPrinterResult {
            let device = DeviceInfo()
            device.name = portInfo.modelName
            device.address = portInfo.portName
            device.brand = "Star"
            
            deviceList?.append(device)
        }
        print("Device List: %@", deviceList!)
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
        
    }
    
    func onDiscovery(_ deviceInfo: Epos2DeviceInfo!) {
        let device = DeviceInfo()
        device.name = deviceInfo.deviceName
        device.address = deviceInfo.ipAddress
        device.brand = "Epson"
        deviceList?.append(device)
        collectionView.reloadData()
        
        print("Device List: %@", deviceList!)
    }
    
    @IBAction func back() {
        printerSettingVC = self.storyboard!.instantiateViewController(withIdentifier: "PrinterSettingVC") as? PrinterSettingVC
        
        if printerSettingVC != nil {
            Hero.shared.setDefaultAnimationForNextTransition(.pageOut(direction: .down))
            hero_replaceViewController(with: printerSettingVC!)
        }
    }
    
    @IBAction func add() {
        guard let name = nameTextField.text, let address = addressTextField.text, let brand = brandTextField.text, let role = roleTextField.text else {
            return
        }
        let device = DeviceInfo()
        device.name = name
        device.address = address
        device.brand = brand
        device.role = role
        
        let printers = Printers()
        printers.printer = device
        printers.save()
        
        self.back()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let deviceList = deviceList else {
            return 0
        }
        return deviceList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PrinterItem", for: indexPath) as! PrinterItem
        if let device: DeviceInfo = deviceList?[indexPath.row] {
            cell.address.text = device.address
            cell.imageView.image = device.brand == "Epson" ? #imageLiteral(resourceName: "epson") : #imageLiteral(resourceName: "star")
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        if let device: DeviceInfo = deviceList?[indexPath.row] {
            nameTextField.text = device.name
            addressTextField.text = device.address
            brandTextField.text = device.brand
        }
    }
}

