//
//  ViewController.swift
//  Swift_MJLineChart
//
//  Created by 郭明健 on 2023/5/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        addLineChart()
    }

    private func addLineChart() {
        let height: CGFloat = 200
        let width: CGFloat = view.frame.width
        let y: CGFloat = (view.frame.height - height) / 2
        let x: CGFloat = 0
        let rect = CGRect(x: x, y: y, width: width, height: height)
        //
        let chartView = MJLineChartView(frame: .zero)
        var configuration = MJLineChartConfiguration()
        configuration.yMin = 0
        configuration.yMax = 100
        configuration.ySegmentCount = 5
        configuration.xMin = 0
        configuration.xMax = 24
        configuration.xSegmentCount = 8
        configuration.yAxisAlarmLineMaxValue = 88
        configuration.yAxisAlarmLineMinValue = 19
        chartView.setupLineChartView(frame: rect, configuration: configuration)
        view.addSubview(chartView)
        
        var pointArray: [MJLineChartLineSource] = []
        var point: MJLineChartLineSource = MJLineChartLineSource()
        
        point.xAxisValue = 0
        point.yAxisValue = 20
        point.xValue = "0:00"
        pointArray.append(point)
        
        point.xAxisValue = 0.58
        point.yAxisValue = 21
        point.xValue = "0:35"
        pointArray.append(point)
        
        point.xAxisValue = 0.9
        point.yAxisValue = 22.57
        point.xValue = "0:54"
        pointArray.append(point)
        
        point.xAxisValue = 1.5
        point.yAxisValue = 23
        point.xValue = "1:30"
        pointArray.append(point)
        
        point.xAxisValue = 2.5
        point.yAxisValue = 18
        point.xValue = "2:30"
        pointArray.append(point)
        
        point.xAxisValue = 3
        point.yAxisValue = 40
        point.xValue = "3:00"
        pointArray.append(point)
        
        point.xAxisValue = 3.5
        point.yAxisValue = 36
        point.xValue = "3:30"
        pointArray.append(point)
        
        point.xAxisValue = 6
        point.yAxisValue = 60
        point.xValue = "6:00"
        pointArray.append(point)
        
        point.xAxisValue = 6.5
        point.yAxisValue = 53
        point.xValue = "6:30"
        pointArray.append(point)
        
        point.xAxisValue = 9
        point.yAxisValue = 100
        point.xValue = "9:00"
        pointArray.append(point)
        
        point.xAxisValue = 12
        point.yAxisValue = 80
        point.xValue = "12:00"
        pointArray.append(point)
        
        point.xAxisValue = 15
        point.yAxisValue = 35
        point.xValue = "15:00"
        pointArray.append(point)
        
        point.xAxisValue = 18
        point.yAxisValue = 20
        point.xValue = "18:00"
        pointArray.append(point)
        
        point.xAxisValue = 19
        point.yAxisValue = 75
        point.xValue = "19:00"
        pointArray.append(point)
        
        point.xAxisValue = 20
        point.yAxisValue = 75
        point.xValue = "20:00"
        pointArray.append(point)
        
        point.xAxisValue = 21
        point.yAxisValue = 88
        point.xValue = "21:00"
        pointArray.append(point)
        
        point.xAxisValue = 22
        point.yAxisValue = 34
        point.xValue = "22:00"
        pointArray.append(point)
        
        point.xAxisValue = 23
        point.yAxisValue = 12
        point.xValue = "23:00"
        pointArray.append(point)
        
        point.xAxisValue = 23.5
        point.yAxisValue = 97
        point.xValue = "23:30"
        pointArray.append(point)
        
        point.xAxisValue = 24
        point.yAxisValue = 87
        point.xValue = "24:00"
        pointArray.append(point)
        
        chartView.addLine(values: pointArray)
        
        chartView.longPressPointIndexBlock = { pointIndex in
            print("currentPoint Index ==> \(pointIndex)")
        }

//        var pointArray2: [MJLineChartLineSource] = []
//        var point2: MJLineChartLineSource = MJLineChartLineSource()
//
//        point2.xAxisValue = 0
//        point2.yAxisValue = 15
//        pointArray2.append(point2)
//
//        point2.xAxisValue = 3
//        point2.yAxisValue = 20
//        pointArray2.append(point2)
//
//        point2.xAxisValue = 6
//        point2.yAxisValue = 30
//        pointArray2.append(point2)
//
//        point2.xAxisValue = 9
//        point2.yAxisValue = 10
//        pointArray2.append(point2)
//
//        point2.xAxisValue = 12
//        point2.yAxisValue = 90
//        pointArray2.append(point2)
//
//        chartView.addLine(values: pointArray2)
    }
}

