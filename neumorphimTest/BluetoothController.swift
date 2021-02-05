//
//  ScanTableViewController.swift
//  BlueDistance
//
//  Created by Travis Raghubans on 6/25/20.
//  Copyright © 2020 Merge Solutions LLC. All rights reserved.
//
//Import statements

import CoreBluetooth
import Darwin
import Foundation
import SwiftUI

// Controller Class
import Foundation
import CoreBluetooth
 
class BluetoothController: NSObject, ObservableObject, CBCentralManagerDelegate {
    
    var manager: CBCentralManager! = nil
    
    @Published var isSwitchedOn = false
 
    @Published var nowPayload: [Now] = []
    
    var riskValueArray: [ColorObject] = []
    let colorCount = ColorObject(green: 0, red: 0)
    
    override init() {
        super.init()
 
        manager = CBCentralManager(delegate: self, queue: nil)
        manager.delegate = self
        
        scanBLEDevices()
        
    }
 
    // MARK: BLE Scanning
    func scanBLEDevices()
    {
//        let testTime = Handler.getLocalTime()
        manager?.scanForPeripherals(withServices: nil, options: nil)
        // stop scanning after T second(s)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0)
        {
            // We calculate Risk Index Values in this function...
            self.stopScanForBLEDevices()
        }
    }
    
    // Stopping the BLE Scan
    func stopScanForBLEDevices()
    {
         // Stop the physical scanning
        manager?.stopScan()
        
        // calc red and greens from a riskindex
        
        let colorCountRed = colorCount.red
        let colorCountGreen = colorCount.green
        
        nowPayload.append(Now(red: colorCountRed, green: colorCountGreen))
        self.riskValueArray.append(self.colorCount)
        
        if(nowPayload.count > 7)
        {
            nowPayload.remove(at: 0)
        }
        
        colorCount.red = 0
        colorCount.green = 0
        
        
        self.scanBLEDevices()
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber)
    {
        //MARK: Calcualte True RSSI
        let trueRSSI = RSSI.intValue

        let distance = findDistance(R1: Int(trueRSSI))
        assignColorOnDistance(distance: distance, counter: colorCount)
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            isSwitchedOn = true
        }
        else {
            isSwitchedOn = false
        }
    }
    
    
    // Returning a color based on RSSI Value *ESTIMATION*
    // Actually gets displayed on phone as Now Page bars
    func assignColorOnDistance(distance: Double, counter: ColorObject)
    {
        if(distance > 5)
        {
            counter.green += 1
//            return UIColor.green
        }
        else
        {
            counter.red += 1
//            return UIColor.red
        }
    }
    
    func findDistance(R1: Int ) -> Double
    {
        // These will adjust in the future
        
        let R = -69     // Assumed Constant
        let E = 2       // Enviorment Var
        
        // let's find distance (roughly) !!
        var d1 = 0.0
        
        // add a statement so that we never return 0
        
        //D1  = (10 ^ (  R   -   R1  ))  /  (10*   E )
        d1 = Double(R) - Double(R1)
        d1 = d1 / (10 * Double(E))
        d1 = pow(10,d1)
        return d1
    }
}

// MARK: Color Object Class
public class ColorObject
{
    // Declared Objects
    var green:      Int = 0
    var red:        Int = 0
    var counter:    Int = 0
    // Add extra outOfBound varaible
    
    // Constructor
    init(green: Int, red: Int)
    {
        self.green  = green
        self.red    = red
    }
}
