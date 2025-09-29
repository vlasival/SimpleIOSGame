import SwiftUI

// MARK: - Name Input View
// Экран ввода имени персонажа и выбора уровня сложности
// Первый экран, который видит пользователь при запуске игры
struct NameInputView: View {
    @Binding var playerName: String
    @Binding var selectedDifficulty: DifficultyLevel
    let onStart: () -> Void
    
    var body: some View {
        VStack(spacing: 24) {
            // MARK: - Header Section
            // Заголовок с иконкой и приветственным текстом
            VStack(spacing: 16) {
                Image(systemName: "gamecontroller.fill")
                    .font(.system(size: 60))
                    .foregroundColor(.blue)
                
                Text("Добро пожаловать в игру!")
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                
                Text("Введите имя вашего персонажа и выберите сложность")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
            
            // MARK: - Input Section
            // Поля ввода и выбора параметров игры
            VStack(spacing: 20) {
                // Поле ввода имени персонажа
                VStack(alignment: .leading, spacing: 8) {
                    Text("Имя персонажа")
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    TextField("Введите имя", text: $playerName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .font(.headline)
                }
                
                // Выбор уровня сложности
                VStack(alignment: .leading, spacing: 12) {
                    Text("Уровень сложности")
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    VStack(spacing: 8) {
                        ForEach(DifficultyLevel.allCases, id: \.self) { difficulty in
                            DifficultySelectionCard(
                                difficulty: difficulty,
                                isSelected: selectedDifficulty == difficulty
                            ) {
                                selectedDifficulty = difficulty
                            }
                        }
                    }
                }
                
                // Кнопка начала игры
                Button(action: {
                    onStart()
                }) {
                    Text("Начать игру")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(playerName.isEmpty ? Color.gray : Color.blue)
                        .cornerRadius(12)
                }
                .disabled(playerName.isEmpty)
            }
            .padding(.horizontal, 40)
        }
        .padding()
    }
}

// MARK: - Preview
// Предварительный просмотр для разработки
#Preview {
    NameInputView(
        playerName: .constant("Герой"),
        selectedDifficulty: .constant(.normal)
    ) {
        print("Start game")
    }
}
