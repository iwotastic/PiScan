//
//  BluetoothScanner.swift
//  PiScan
//
//  Created by Ian Morrill on 6/28/20.
//

import SwiftUI
import CoreBluetooth

struct BLEDevice {
    var name: String
    var rssi: Int
    var peripheral: CBPeripheral
}

class BluetoothScanner: NSObject, ObservableObject, CBCentralManagerDelegate {
    @Published var bluetoothReady = false
    @Published var scannedDevices: [BLEDevice] = []
    @Published var deviceDictionary: [String: BLEDevice] = [:]
    
    var centralManager: CBCentralManager
    
    override init() {
        centralManager = CBCentralManager()
        
        super.init()
        
        centralManager.delegate = self
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            bluetoothReady = true
            centralManager.scanForPeripherals(withServices: nil, options: [CBCentralManagerScanOptionAllowDuplicatesKey: true])
        }else{
            bluetoothReady = false
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        if let peripheralName = peripheral.name {
            deviceDictionary[peripheralName] = BLEDevice(name: peripheralName, rssi: RSSI.intValue, peripheral: peripheral)
            scannedDevices = deviceDictionary.keys.map { key in
                deviceDictionary[key]!
            }
        }
    }
}
