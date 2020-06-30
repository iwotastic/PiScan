//
//  DeviceDetailsView.swift
//  PiScan
//
//  Created by Ian Morrill on 6/28/20.
//

import SwiftUI
import CoreBluetooth

struct DeviceDetailsView: View {
    @EnvironmentObject var bluetoothScanner: BluetoothScanner
    var deviceName: String
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "antenna.radiowaves.left.and.right")
                    Text("RSSI").fontWeight(.semibold)
                    Spacer()
                }.foregroundColor(.blue)
                HStack(alignment: .bottom) {
                    Text("\(bluetoothScanner.deviceDictionary[deviceName]!.rssi)").font(.system(size: 28, weight: .bold, design: .rounded))
                    Text("dBm").foregroundColor(.gray)
                }
            }.padding().background(RoundedRectangle(cornerRadius: 15.0, style: .continuous).fill(Color(.secondarySystemBackground)))
        }.padding().navigationTitle(deviceName)
    }
}
