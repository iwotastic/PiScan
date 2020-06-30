//
//  ContentView.swift
//  PiScan
//
//  Created by Ian Morrill on 6/28/20.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var bluetoothScanner: BluetoothScanner
    
    var body: some View {
        NavigationView {
            if bluetoothScanner.bluetoothReady {
                List(bluetoothScanner.scannedDevices, id: \.name) { device in
                    NavigationLink(destination: DeviceDetailsView(deviceName: device.name).environmentObject(bluetoothScanner)) {
                        VStack(alignment: .leading) {
                            Text(device.name).bold()
                            Text("RSSI: \(device.rssi)")
                        }
                    }
                }
            }else{
                VStack {
                    Image(systemName: "wifi.slash").font(.system(size: 50)).foregroundColor(.red).padding()
                    Text("Bluetooth Unavailable").font(.system(size: 16)).foregroundColor(.red)
                }.navigationTitle("PiScan")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
