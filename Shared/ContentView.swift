//
//  ContentView.swift
//  Shared
//
//  Created by James on 8/12/22.
//

import SwiftUI

struct ContentView: View {
    var images: [String] = ["image1", "image2"]
    @ObservedObject var countTimer: CountTimer = CountTimer(items: 2, interval: 4.0)
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                Image(self.images[Int(self.countTimer.progress)])
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: nil, alignment: .center)
                    .animation(.none, value: self.countTimer.progress)
                
                HStack(alignment: .center, spacing: 4) {
                    ForEach(self.images.indices) { image in
                        LoadingBar(progress: min(max((CGFloat(self.countTimer.progress) - CGFloat(image)), 0.0), 1.0))
                            .frame(width: nil, height: 2, alignment: .leading)
                            .animation(.linear, value: self.countTimer.progress)
                    }
                }
                .padding()
                
                HStack(alignment: .center, spacing: 0) {
                    Rectangle()
                        .foregroundColor(.clear)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            self.countTimer.advancePage(by: -1)
                        }
                    Rectangle()
                        .foregroundColor(.clear)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            self.countTimer.advancePage(by: 1)
                        }
                }
                .onAppear() {
                    self.countTimer.start()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
