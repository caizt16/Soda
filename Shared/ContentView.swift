//
//  ContentView.swift
//  Shared
//
//  Created by James on 8/12/22.
//

import SwiftUI
import AVKit

struct Song {
    let title: String
    let artist: String
    let cover: String
}

struct ContentView: View {
//    var images: [String] = ["88rising", "image2"]
    var songs: [Song] = [
        Song(title: "Midsummer Madness", artist: "88rising", cover: "88rising"),
        Song(title: "Little Match Girl", artist: "Masiwei", cover: "masiwei")
    ]
    
    @State var audioPlayer: AVAudioPlayer!
    func play(song: String) {
        let sound = NSDataAsset(name: song)!.data
        self.audioPlayer = try! AVAudioPlayer(data: sound)
        self.audioPlayer.currentTime = 30
        self.audioPlayer.play()
    }

    
    @ObservedObject var countTimer: CountTimer = CountTimer(items: 2, interval: 4.0)
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                VStack {
                    HStack(alignment: .center, spacing: 4) {
                        ForEach(self.songs.indices) { song in
                            LoadingBar(progress: min(max((CGFloat(self.countTimer.progress) - CGFloat(song)), 0.0), 1.0))
                                .frame(width: nil, height: 2, alignment: .leading)
                                .animation(.linear, value: self.countTimer.progress)
                        }
                    }
                    .padding()
                    
                    Text("Next coming up: ")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                    
                    let currentSong = self.songs[Int(self.countTimer.progress)]
                    
                    Image(currentSong.cover)
                        .resizable()
                        .frame(width: 230.0, height: 230.0)
                        .clipShape(Circle())
                        .shadow(radius: 5)
                        .animation(.none, value: self.countTimer.progress)
                        .padding(70)
                
                    Text(currentSong.title)
                        .font(.system(size: 28).weight(.heavy))
                        .padding()
                        .onAppear {
                            play(song: currentSong.title)
                        }
                        .onChange(of: currentSong.title) {
                            play(song: $0)
                        }
                    
                    Text(currentSong.artist)
                        .font(.system(size: 16).weight(.semibold))
                    
                    HStack(spacing: 30) {
                        Image(systemName: "bolt.heart").resizable().scaledToFit()
                        Image(systemName: "music.note.list").resizable().scaledToFit()
                        Image(systemName: "plus.circle").resizable().scaledToFit()
                        Image(systemName: "square.and.arrow.up").resizable().scaledToFit()


                    }
                    .frame(height: 40)
                    .padding()
                    
                }
                
                
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
            .foregroundColor(.white)
            .background(.black)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
