//
//  ContentView.swift
//  MyLocation
//
//  Created by Leif on 7/20/22.
//

import CacheStore
import CoreLocation
import LocationCacheStore
import SwiftUI

struct ContentView: View {
    @ObservedObject var store: Store<LocationStoreKey, Void, Void>
    
    var body: some View {
        if let location = store.get(.location, as: CLLocation.self) {
            Text("Location: \(location)")
                .padding()
        } else {
            ProgressView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(
            store: Store<LocationStoreKey, Void, Void>(
                initialValues: [:],
                actionHandler: .none,
                dependency: ()
            )
        )
    }
}
