import SwiftUI
import LaunchAtLogin

struct ContentView: View {
    @StateObject var appState: AppState

    var body: some View {
        VStack(alignment: .leading) {
            // Resolution configuration section
            Text("Resolution").font(.title2).padding(.bottom, 3)
            HStack() {
                VStack(alignment: .leading) {
                    Text("Width").padding(.bottom, -4)
                    TextField("Width", text: $appState.width)
                }
                VStack(alignment: .leading) {
                    Text("Height").padding(.bottom, -4)
                    TextField("Height", text: $appState.height)
                }
            }.padding(.bottom)
            
            // Activation configuration section
            Text("Activate").font(.title2).padding(.bottom, 3)
            VStack(alignment: .leading) {
                Text("Activate only when one of these apps are in focus.").fixedSize(horizontal: false, vertical: true)

                ForEach(self.appState.games.sorted(by: {$0.value < $1.value}), id: \.key) { key, value in
                    let name = value.components(separatedBy: "/")[1];
                    
                    Toggle(name, isOn: Binding(
                        get: {self.appState.activegames[key] ?? false},
                        set: {value in self.appState.activegames[key] = value}
                    ))
                }
            }
            
            // Launch on login section
            Divider().padding(.vertical, 8)
            LaunchAtLogin.Toggle()
            
            // Quit button
            Divider().padding(.vertical, 8)
            Button(action: {
                NSApplication.shared.terminate(nil)
            }) {
                HStack {
                    Image(systemName: "power")
                    Text("Quit Mouselock")
                }
                .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
        }.padding(30).padding(.top, -5).frame(width: 340)
    }
}
