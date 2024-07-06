import SwiftUI

struct DesignSystem {
    static let primaryColor = Color(hex: "2C3E50")
    static let secondaryColor = Color(hex: "16A085")
    static let accentColor = Color(hex: "E74C3C")
    static let backgroundColor = Color(hex: "ECF0F1")
    static let textColor = Color(hex: "34495E")
    
    static let titleFont = Font.system(size: 28, weight: .semibold)
    static let bodyFont = Font.system(size: 16)
    static let buttonFont = Font.system(size: 16, weight: .medium)
    
    static let cornerRadius: CGFloat = 12
    static let standardPadding: CGFloat = 16
    
    struct ButtonStyle {
        static func primaryButton(title: String, action: @escaping () -> Void) -> some View {
            Button(action: action) {
                Text(title)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(secondaryColor)
                    .foregroundColor(.white)
                    .cornerRadius(cornerRadius)
                    .font(buttonFont)
            }
        }
        
        static func secondaryButton(title: String, action: @escaping () -> Void) -> some View {
            Button(action: action) {
                Text(title)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.clear)
                    .foregroundColor(primaryColor)
                    .cornerRadius(cornerRadius)
                    .overlay(
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .stroke(primaryColor, lineWidth: 1)
                    )
                    .font(buttonFont)
            }
        }
        
        static func textButton(title: String, action: @escaping () -> Void) -> some View {
            Button(action: action) {
                Text(title)
                    .foregroundColor(primaryColor)
                    .font(buttonFont)
            }
        }
    }
}

struct CustomTextField: View {
    let placeholder: String
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default
    
    var body: some View {
        TextField(placeholder, text: $text)
            .keyboardType(keyboardType)
            .padding()
            .background(Color.white)
            .cornerRadius(DesignSystem.cornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: DesignSystem.cornerRadius)
                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
            )
    }
}

struct ContentCard: View {
    let title: String
    let source: String
    let date: String
    let summary: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(DesignSystem.textColor)
                .lineLimit(2)
            
            Text(source)
                .font(.system(size: 14))
                .foregroundColor(DesignSystem.textColor.opacity(0.7))
            
            Text(date)
                .font(.system(size: 12))
                .foregroundColor(DesignSystem.textColor.opacity(0.5))
            
            Text(summary)
                .font(.system(size: 14))
                .foregroundColor(DesignSystem.textColor)
                .lineLimit(2)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(DesignSystem.cornerRadius)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

// Add other reusable components here (SearchBar, EmptyStateView, LoadingView, ToastNotification, SettingsRow)

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
