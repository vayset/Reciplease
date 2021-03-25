import Foundation

class TimeConverter {
    func formatTotaltime(_ totalTimeInMinutes: Int) -> String {
        
        guard totalTimeInMinutes < 1440 else {
            return "--"
        }
        
        guard totalTimeInMinutes > 0 else {
            return "--"
        }
        
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .abbreviated
        
        let components = DateComponents(hour: totalTimeInMinutes / 60, minute: totalTimeInMinutes % 60)
        
        let formattedValue = formatter.string(for: components)
        return formattedValue ?? "--"
    }
}
