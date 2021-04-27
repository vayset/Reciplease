import Foundation

class TimeConverter {
    init(formatter: DateComponentsFormatterProtocol = DateComponentsFormatter()) {
        self.formatter = formatter
    }
    
    private var formatter: DateComponentsFormatterProtocol
    
    func formatTotaltime(_ totalTimeInMinutes: Int) -> String {
        
        guard totalTimeInMinutes < 1440 else {
            return "--"
        }
        
        guard totalTimeInMinutes > 0 else {
            return "--"
        }

        formatter.unitsStyle = .abbreviated
        
        let components = DateComponents(hour: totalTimeInMinutes / 60, minute: totalTimeInMinutes % 60)
        
        let formattedValue = formatter.string(for: components)
        return formattedValue ?? "--"
    }
}


protocol DateComponentsFormatterProtocol {
    var unitsStyle: DateComponentsFormatter.UnitsStyle { get set }
    func string(for obj: Any?) -> String?
}

extension DateComponentsFormatter: DateComponentsFormatterProtocol {

}

