import SwiftUI

struct ContentView: View {
    @State private var gameManager = GameManager()
    
    var body: some View {
        GameView(gameManager: gameManager)
    }
}

#Preview {
    ContentView()
}
