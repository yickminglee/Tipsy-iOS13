
import Foundation

struct BillSplittingBrain {
    var billSplitted: BillSplitted?
    
    func pctToFloat(pctText: String) -> Float {
        return (Float(pctText.replacingOccurrences(of: "%", with: "")) ?? 0.1) / 100
    }
    
    mutating func splitBill(billTotalText: String, tipPctText: String, nPeople: Double) {
        let tipPct = pctToFloat(pctText: tipPctText)
        let billPerPerson = (Float(billTotalText) ?? 0) * (1+tipPct) / Float(nPeople)
        
        let billPerPersonFormatted = String(format: "%.2f", billPerPerson)
        let nPeopleFormatted = String(format: "%.0f", nPeople)
        let setting = "\(billTotalText) split between \(nPeopleFormatted) people, with \(tipPctText) tip."
        
        billSplitted = BillSplitted(billPerPerson: billPerPersonFormatted, setting: setting)
    }
    
    func getBillPerPerson() -> String {
        return billSplitted?.billPerPerson ?? "0"
    }
    
    func getSetting() -> String {
        return billSplitted?.setting ?? "No setting."
    }
    
}
