//
//  GraphTableViewCell.swift
//  ListedApp
//
//  Created by Rahul Bawane on 15/06/23.
//

import UIKit
import Charts

class GraphTableViewCell: UITableViewCell, ChartViewDelegate {

    @IBOutlet weak var chartsView: LineChartView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var rangeBgView: UIView!

    var chartsValue: [ChartDataEntry] = [ChartDataEntry]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUI()
        setChartsUI()
        setChartsData()
    }
    
    func setUI() {
        bgView.layer.cornerRadius = 10
        rangeBgView.layer.borderWidth = 1
        rangeBgView.layer.borderColor = UIColor.gray.cgColor
        rangeBgView.layer.cornerRadius = 5
    }
    
    func setChartsUI() {
        chartsView.rightAxis.enabled = false
        chartsView.legend.enabled = false
        let yAxis = chartsView.leftAxis
        yAxis.labelTextColor = .gray
        yAxis.axisLineColor = .white
        
        let xAxis = chartsView.xAxis
        xAxis.labelPosition = .bottom
        xAxis.granularity = 1
        xAxis.labelTextColor = .gray
        xAxis.axisLineColor = .gray
    }
    
    func setChartsData() {
        let set = LineChartDataSet(entries: chartsValue)
        set.drawCirclesEnabled = false
        set.lineWidth = 2
        set.setColor(.blue)
        let gradientColors = [UIColor.white.cgColor,
                              UIColor.blue.cgColor]
        let gradient = CGGradient(colorsSpace: nil, colors: gradientColors as CFArray, locations: nil)!

        set.fillAlpha = 0.6
        set.fill = LinearGradientFill(gradient: gradient, angle: 90)
        set.drawFilledEnabled = true

        let data = LineChartData(dataSet: set)
        data.setDrawValues(false)
        chartsView.data = data
    }
    
    func setChartsValue(values: [String: Int]?) {
        guard let values = values else {return}
        var count: Double = 0
        var datesArray = [String]()

        for (key, value) in values {
            datesArray.append(key.changeDateFormat(input: "yyyy-MM-dd", output: "MMM-dd"))
            self.chartsValue.append(ChartDataEntry(x: count, y: Double(value)))
            count += 1
        }
        chartsView.xAxis.valueFormatter = IndexAxisValueFormatter(values:datesArray)
        chartsView.xAxis.granularity = 1
        self.setChartsData()
    }
}
