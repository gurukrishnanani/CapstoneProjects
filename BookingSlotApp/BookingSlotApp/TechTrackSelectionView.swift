//
//  TechTrackSelectionView.swift
//  BookingSlotApp
//
//  Created by admin on 15/02/25.
//

import SwiftUI

struct TechTrackSelectionView: View {
    @State private var selectedTechTrack = ""
    @State private var availableTechTracks = ["iOS", "Android", "Backend", "Frontend"]

    var body: some View {
        VStack {
            Text("Select Your Tech Track")
                .font(.title)
                .padding()

            Picker("Tech Track", selection: $selectedTechTrack) {
                ForEach(availableTechTracks, id: \.self) { track in
                    Text(track)
                }
            }
            .pickerStyle(WheelPickerStyle())
            .padding()

            Button("Save Tech Track") {
                // Save the selected tech track to the database
            }
            .padding()
        }
        .padding()
        .navigationTitle("Tech Tracks")
    }
}

struct TechTrackSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        TechTrackSelectionView()
    }
}
