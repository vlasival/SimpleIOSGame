import SwiftUI

struct CombatLogView: View {
    let log: [CombatLogEntry]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Журнал боя")
                .font(.headline)
                .padding(.bottom, 4)
            
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 4) {
                    ForEach(log.reversed()) { entry in
                        CombatLogEntryView(entry: entry)
                    }
                }
            }
            .frame(maxHeight: 200)
            .background(Color.black.opacity(0.05))
            .cornerRadius(8)
        }
    }
}


#Preview {
    CombatLogView(log: [
        CombatLogEntry(
            attacker: "Герой",
            target: "Гоблин",
            action: "атакует",
            result: "Попадание!",
            damage: 5
        ),
        CombatLogEntry(
            attacker: "Гоблин",
            target: "Герой",
            action: "атакует",
            result: "Промах!"
        ),
        CombatLogEntry(
            attacker: "Герой",
            target: "Герой",
            action: "исцеляется",
            result: "Восстановлено здоровье!"
        )
    ])
    .padding()
}
