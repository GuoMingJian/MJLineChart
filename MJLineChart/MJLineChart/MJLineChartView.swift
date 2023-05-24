//
//  MJLineChartView.swift
//  MJLineChart
//
//  欢迎大家用我的折线图项目，建议与意见欢迎交流：微信（15899670225），QQ（1339601489）
//  简书：https://www.jianshu.com/p/3d6321dbeb8b
//  GitHub：https://github.com/GuoMingJian/MJLineChart
//
//  Created by 郭明健 on 2023/5/20.
//

import UIKit

/// 折线图初始化配置
struct MJLineChartConfiguration {
    /// Y轴 最大值
    public var yMax: Double = 100
    /// Y轴 最小值
    public var yMin: Double = 0
    /// Y轴 分段数量
    public var ySegmentCount: Int = 4
    /// Y轴 单位 (格式：xx/xx)
    public var yUnit: String = "单位/°F"
    public var yShortUnit: String = "°F"
    /// Y轴 文本显示样式（如 => ”10, 20, 30“）
    public var yAxisTextFormat: String = "%.0f"
    /// X轴 最小值
    public var xMin: Double = 0
    /// X轴 最大值
    public var xMax: Double = 24
    /// X轴 分段数量
    public var xSegmentCount: Int = 8
    /// X轴 单位
    public var xUnit: String = "单位/h"
    public var xShortUnit: String = "h"
    /// X轴 文本显示样式（如 => ”3:00, 6:00, 9:00“）
    public var xAxisTextFormat: String = "%.0f:00"
    //----------------------------------//
    /// X、Y轴 文本颜色
    public var axisTextColor: UIColor = .gray
    /// X、Y轴 文本字体
    public var axisTextFont: UIFont = UIFont.systemFont(ofSize: 8)
    /// 折线颜色
    public var chartLineColor: UIColor = UIColor(red: 26/255, green: 135/255, blue: 254/255, alpha: 1)
    /// 折线粗细度（默认：2）
    public var chartLineThickness: CGFloat = 1.2
    /// 锚点半径
    public var pointRadius: CGFloat = 2
    /// 正常锚点颜色（默认与折线一致）
    public var normalPointColor: UIColor = UIColor(red: 26/255, green: 135/255, blue: 254/255, alpha: 1)
    /// 报警锚点颜色（如无此业务可设置颜色与 normalPointColor 一致）
    public var alarmPointColor: UIColor = .red
    /// 选中锚点颜色
    public var selectedPointColor: UIColor = .red
    /// 是否显示锚点文字
    public var isShowPointText: Bool = true
    /// X轴 Y轴 坐标轴粗细度（默认：1）
    public var xyAxisLineThickness: CGFloat = 1
    /// X轴 Y轴 坐标轴刻度线长度（默认：1.5）
    public var xyAxisSegmentWidth: CGFloat = 1.5
    /// X、Y轴 轴线 & 刻度 颜色
    public var axisLineColor: UIColor = .gray.withAlphaComponent(0.3)
    /// X轴 Y轴 文本与轴间距
    public var xAxisTextOffset: CGFloat = 5
    //-----------------Y轴-----------------//
    /// 是否显示Y轴线、刻度
    public var isShowYAxisLine: Bool = true
    /// Y轴 总宽度
    public var yAxisViewWidth: CGFloat = 35
    /// Y轴 顶部留白长度
    public var ySegmentTopSpace: CGFloat = 30
    /// Y轴 单位颜色
    public var yUnitColor: UIColor = .gray
    /// 是否显示 Y轴 分段辅助线（默认显示）
    public var isShowYAxisSupportLine: Bool = true
    /// Y轴 分段辅助线颜色
    public var ySegmentColor: UIColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
    /// 是否显示 Y轴 刻度线
    public var isShowYAxisSegment: Bool = true
    /// 超过最大值前缀（eg: Over 88°F）
    public var maxAlarmPrefix: String = "Over"
    /// 超过最小值前缀（eg: Below 18°F）
    public var minAlarmPrefix: String = "Below"
    /// 是否显示 Y轴 ”报警线“
    public var isShowYAxisAlarmLine: Bool = true
    /// Y轴 ”报警线“ 最大数值
    public var yAxisAlarmLineMaxValue: Double = 80
    /// Y轴 ”报警线“ 最小数值
    public var yAxisAlarmLineMinValue: Double = 20
    /// Y轴 ”报警线“ 颜色
    public var yAxisAlarmLineColor: UIColor = .red
    /// Y轴 ”报警线“ 粗细度
    public var yAxisAlarmLineThickness: CGFloat = 0.5
    /// 长按虚线颜色
    public var longPressColor: UIColor = .gray
    /// 长按时 是否在顶部显示数据
    public var isShowLongPressTopText: Bool = false
    /// 长按时 是否动态移动显示数据
    public var isShowLongPressMoveText: Bool = true
    /// 长按顶部文本字体
    public var longPressTextFont: UIFont = UIFont.systemFont(ofSize: 12)
    //-----------------X轴-----------------//
    /// 是否显示X轴线、刻度
    public var isShowXAxisLine: Bool = true
    /// X轴 单位颜色
    public var xUnitColor: UIColor = .gray
    /// X轴 刻度间距
    public var xSegmentSpace: CGFloat = 38
    /// X轴 最末尾刻度留白长度(如果要显示X轴单位则适当增加该值)
    public var xLastSegmentSpace: CGFloat = 50
    /// X轴 刻度朝向（默认朝下）
    public var xSegmentToBottom: Bool = true
}

struct MJLineChartLineSource {
    /// 锚点源数据:X轴
    public var xValue: String = ""
    /// 锚点源数据:Y轴
    public var yValue: String = ""
    
    /// 锚点在X轴按比例换算后的值
    public var xAxisValue: Double = 0
    /// 锚点在Y轴按比例换算后的值
    public var yAxisValue: Double = 0
}

class MJLineChartView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.delegate = self
        scrollView.bounces = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private var xAxisView: XAxisView = XAxisView(frame: .zero)
    private var yAxisView: YAxisView = YAxisView(frame: .zero)
    
    // MARK: -
    
    /// 长按 Block
    public var longPressPointIndexBlock: ((_ pointIndex: Int) -> Void)?
    
    // MARK: -
    /// 折线图配置
    private var configuration: MJLineChartConfiguration = MJLineChartConfiguration()
    /// 折线图：宽
    private var chartWidth: CGFloat = 0
    /// 折线图：高
    private var chartHeight: CGFloat = 0
    /// 长按移动距离
    private var moveDistance: CGFloat = 0
    
    // MARK: - Public
    public func setupLineChartView(frame: CGRect,
                                   configuration: MJLineChartConfiguration) {
        self.frame = frame
        self.chartWidth = frame.size.width
        self.chartHeight = frame.size.height
        self.configuration = configuration
        //
        setupXAxisView()
        setupYAxisView()
        
        // 长按手势
        let longPress: UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressAction(_:)))
        longPress.minimumPressDuration = 0.3
        self.xAxisView.addGestureRecognizer(longPress)
    }
    
    /// 开始画线
    public func addLine(values: [MJLineChartLineSource]) {
        self.xAxisView.addLine(values: values)
    }
    
    // MARK: - Actions
    /// 长按
    @objc private func longPressAction(_ longPress: UILongPressGestureRecognizer) {
        if longPress.state == .changed || longPress.state == .began {
            let location = longPress.location(in: xAxisView)
            
            var x = location.x - scrollView.contentOffset.x
            if scrollView.contentOffset.x > 0 {
                x += configuration.xSegmentSpace
            }
            let y = location.y
            
            let screenPoint = CGPointMake(x, y)
            
            if abs(location.x - moveDistance) > 0 {
                moveDistance = location.x
                xAxisView.screenPoint = screenPoint
                xAxisView.isLongPress = true
            }
        }
        
        if longPress.state == .ended {
            moveDistance = 0
            xAxisView.isLongPress = false
        }
    }
    
    // MARK: - Private
    /// 创建 X轴
    private func setupXAxisView() {
        scrollView.frame = CGRect(x: configuration.yAxisViewWidth, y: 0, width: chartWidth - configuration.yAxisViewWidth, height: chartHeight)
        self.addSubview(scrollView)
        
        let xAxisRect = CGRect(x: 0, y: 0, width: CGFloat(configuration.xSegmentCount + 1) * configuration.xSegmentSpace + configuration.xLastSegmentSpace, height: chartHeight)
        self.xAxisView.setupXAxis(frame: xAxisRect, configuration: configuration)
        
        self.xAxisView.longPressPointIndexBlock = { pointIndex in
            if self.longPressPointIndexBlock != nil {
                self.longPressPointIndexBlock!(pointIndex)
            }
        }
        
        scrollView.addSubview(self.xAxisView)
        scrollView.contentSize = self.xAxisView.frame.size
    }
    
    /// 创建 Y轴
    private func setupYAxisView() {
        let yAxisRect = CGRect(x: 0, y: 0, width: configuration.yAxisViewWidth, height: chartHeight)
        self.yAxisView.setupYAxis(frame: yAxisRect, configuration: configuration)
        
        self.addSubview(self.yAxisView)
    }
}

extension MJLineChartView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.xAxisView.didScrollContentOffset = scrollView.contentOffset
    }
}

// MARK: - XAxisView
class XAxisView: UIView {
    // MARK: -
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 长按 Block
    public var longPressPointIndexBlock: ((_ pointIndex: Int) -> Void)?
    
    public var isLongPress: Bool = false {
        didSet {
            if self.isShowPointText {
                configuration.isShowPointText = !isLongPress
            }
            self.setNeedsDisplay()
        }
    }
    public var screenPoint: CGPoint = .zero
    /// 滑动 Point
    public var didScrollContentOffset: CGPoint = .zero
    
    // MARK: -
    /// 折线图配置
    private var configuration: MJLineChartConfiguration!
    /// XAxisView 宽
    private var chartWidth: CGFloat = 0
    /// XAxisView 高
    private var chartHeight: CGFloat = 0
    
    /// 实际X轴每段数值
    private var xSegmentValue: Double = 0
    /// 实际Y轴每段数值
    private var ySegmentValue: Double = 0
    /// Y轴高度
    private var yAxisHeight: CGFloat = 0
    /// Y轴 X轴 交界点（point.x）
    private var crossingPointY: CGFloat = 0
    
    private var topMargin: CGFloat = 0
    private var bottomMargin: CGFloat = 0
    
    private var textAttributedString: Dictionary<NSAttributedString.Key, Any> = [:]
    private var unitAttributedString: Dictionary<NSAttributedString.Key, Any> = [:]
    
    private var totalLines: [[MJLineChartLineSource]] = []
    private var totalLinesPoint: [[CGPoint]] = []
    /// 绘制多条折线时，第一条为ChartLineColor，其余的由数组颜色取余循环。
    private var linesColorArray: [UIColor] = [
        UIColor(red: 252/255, green: 45/255, blue: 46/255, alpha: 1),
        UIColor(red: 253/255, green: 133/255, blue: 8/255, alpha: 1),
        UIColor(red: 232/255, green: 89/255, blue: 150/255, alpha: 1),
        UIColor(red: 102/255, green: 179/255, blue: 161/255, alpha: 1),
        UIColor(red: 65/255, green: 161/255, blue: 191/255, alpha: 1),
        UIColor(red: 251/255, green: 45/255, blue: 47/255, alpha: 1),
    ]
    // 长按相关标记 属性
    private var currentLongPressX: CGFloat?
    private var lastPointIndex: Int = -1
    private var isShowPointText: Bool = true
    
    // MARK: -
    public func setupXAxis(frame: CGRect,
                           configuration: MJLineChartConfiguration) {
        self.frame = frame
        self.chartWidth = frame.size.width
        self.chartHeight = frame.size.height
        self.configuration = configuration
        self.isShowPointText = configuration.isShowPointText
        
        totalLines.removeAll()
    }
    
    /// 开始画线
    public func addLine(values: [MJLineChartLineSource]) {
        totalLines.append(values)
        self.setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        drawXAxisLine()
    }
    
    /// X轴线
    private func drawXAxisLine() {
        textAttributedString = [NSAttributedString.Key.font: configuration.axisTextFont, NSAttributedString.Key.foregroundColor: configuration.axisTextColor]
        unitAttributedString = [NSAttributedString.Key.font: configuration.axisTextFont, NSAttributedString.Key.foregroundColor: configuration.xUnitColor]
        
        topMargin = getTopMargin()
        bottomMargin = topMargin + configuration.xAxisTextOffset
        yAxisHeight = chartHeight - topMargin - bottomMargin
        
        xSegmentValue = (configuration.xMax - configuration.xMin) / Double(configuration.xSegmentCount)
        ySegmentValue = (configuration.yMax - configuration.yMin) / Double(configuration.ySegmentCount)
        crossingPointY = chartHeight - bottomMargin
        
        if configuration.isShowXAxisLine {
            // X轴
            drawXAxis()
            // 刻度
            drawXAxisSegment()
            // X轴单位
            drawXAxisUnit()
        }
        // 刻度对应的文本
        drawXAxisText()
        // Y轴分段辅助线
        drawYAxisSupportLine()
        // 画折线
        drawLineChart()
        // Y轴报警线
        drawYAxisAlarmLine()
        // 绘制长按虚线
        drawLongPressDashLine()
    }
    
    /// 根据多个点画线
    private func drawLines(points: [CGPoint],
                           lineColor: UIColor) {
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        
        context.addLines(between: points)
        context.setStrokeColor(lineColor.cgColor)
        context.setLineWidth(configuration.chartLineThickness)
        context.strokePath()
    }
    
    /// Y轴顶部单位文本高度
    private func getTopMargin() -> CGFloat {
        let textSize = "x".size(withAttributes: unitAttributedString)
        return textSize.height
    }
    
    /// X轴
    private func drawXAxis() {
        let startPoint = CGPoint(x: 0, y: crossingPointY)
        let endPoint = CGPoint(x: chartWidth, y: startPoint.y)
        drawLine(startPoint: startPoint, endPoint: endPoint, lineColor: configuration.axisLineColor, lineWidth: configuration.xyAxisLineThickness)
    }
    
    /// 刻度
    private func drawXAxisSegment() {
        for index in 0..<configuration.xSegmentCount + 1 {
            if configuration.xyAxisSegmentWidth > 0 {
                let x: CGFloat = CGFloat(index + 1) * configuration.xSegmentSpace
                let y: CGFloat = crossingPointY
                let startPoint = CGPoint(x: x, y: y)
                var endPoint: CGPoint = .zero
                if configuration.xSegmentToBottom {
                    endPoint = CGPoint(x: x, y: y + (configuration.xyAxisSegmentWidth + configuration.xyAxisLineThickness))
                } else {
                    endPoint = CGPoint(x: x, y: y - (configuration.xyAxisSegmentWidth + configuration.xyAxisLineThickness))
                }
                drawLine(startPoint: startPoint, endPoint: endPoint, lineColor: configuration.axisLineColor, lineWidth: configuration.xyAxisLineThickness)
            }
        }
    }
    
    /// 刻度对应的文本以及单位
    private func drawXAxisText() {
        for index in 0..<configuration.xSegmentCount + 1 {
            // X轴文本
            let xCurrentSegmentValue: Double = configuration.xMin + xSegmentValue * Double(index)
            let xSegmentText = String(format: configuration.xAxisTextFormat, xCurrentSegmentValue)
            let textSize = xSegmentText.size(withAttributes: textAttributedString)
            let x: CGFloat = CGFloat(index + 1) * configuration.xSegmentSpace - textSize.width / 2
            let y: CGFloat = crossingPointY + configuration.xAxisTextOffset
            let textRect = CGRect(x: x, y: y, width: textSize.width, height: textSize.height)
            (xSegmentText as NSString).draw(in: textRect, withAttributes: textAttributedString)
        }
    }
    
    /// X轴单位
    private func drawXAxisUnit() {
        let unitSize = configuration.xUnit.size(withAttributes: unitAttributedString)
        if configuration.xUnit.count > 0 {
            let x = chartWidth - unitSize.width - configuration.xAxisTextOffset
            let y: CGFloat = crossingPointY + configuration.xAxisTextOffset
            let textRect = CGRect(x: x, y: y, width: unitSize.width, height: unitSize.height)
            (configuration.xUnit as NSString).draw(in: textRect, withAttributes: unitAttributedString)
        }
    }
    
    /// Y轴分段辅助线
    private func drawYAxisSupportLine() {
        if configuration.isShowYAxisSupportLine {
            for index in 0..<configuration.ySegmentCount + 1 {
                let x: CGFloat = 0
                let value: Double = configuration.yMin + Double(index) * ySegmentValue
                let yValue: Double = (1 - abs(value - configuration.yMin) / (configuration.yMax - configuration.yMin)) * (yAxisHeight - configuration.ySegmentTopSpace)
                let y: CGFloat = topMargin + configuration.ySegmentTopSpace + CGFloat(yValue)
                let startPoint = CGPoint(x: x, y: y)
                let endPoint = CGPoint(x: chartWidth, y: y)
                if index != 0 {
                    drawLine(startPoint: startPoint, endPoint: endPoint, lineColor: configuration.ySegmentColor, lineWidth: configuration.xyAxisLineThickness)
                }
            }
        }
    }
    
    /// 画折线
    private func drawLineChart() {
        totalLinesPoint.removeAll()
        var lineColor = configuration.chartLineColor
        
        for (index, line) in totalLines.enumerated() {
            if index != 0 {
                let colorIndex = index % linesColorArray.count
                lineColor = linesColorArray[colorIndex]
            }
            var linePoints: [CGPoint] = []
            // Line
            for (index, item) in line.enumerated() {
                let x: CGFloat = getXAxisValue(data: item.xAxisValue)
                let y: CGFloat = getYAxisValue(data: item.yAxisValue)
                let point: CGPoint = CGPoint(x: x, y: y)
                
                linePoints.append(point)
                
                if index == line.count - 1 {
                    drawLines(points: linePoints, lineColor: lineColor)
                    totalLinesPoint.append(linePoints)
                }
            }
            // Point
            var pointTextFrame: CGRect = .zero
            for (index, item) in line.enumerated() {
                let point = linePoints[index]
                let isAlarm = isAlarm(value: item.yAxisValue)
                let pointColor: UIColor = isAlarm ? configuration.alarmPointColor : configuration.normalPointColor
                drawCircle(startPoint: point, radius: configuration.pointRadius, color: pointColor)
                if configuration.isShowPointText {
                    // Point Text
                    var tempAttribute: Dictionary<NSAttributedString.Key, Any> = [:]
                    if isAlarm {
                        tempAttribute = [NSAttributedString.Key.font: configuration.axisTextFont, NSAttributedString.Key.foregroundColor: configuration.alarmPointColor]
                    } else {
                        tempAttribute = textAttributedString
                    }
                    let pointText = removeZero(value: item.yAxisValue)
                    let textSize = pointText.size(withAttributes: tempAttribute)
                    let x: CGFloat = point.x - textSize.width / 2
                    let y: CGFloat = point.y - configuration.xAxisTextOffset - textSize.height
                    let currentTextFrame = CGRect(x: x, y: y, width: textSize.width, height: textSize.height)
                    let maxX = CGRectGetMaxX(pointTextFrame)
                    let minY = CGRectGetMinY(pointTextFrame)
                    let isXAxisOverlap: Bool = maxX > currentTextFrame.origin.x
                    let iSYAxisOverlap: Bool = abs(minY - currentTextFrame.origin.y) < textSize.height
                    if isXAxisOverlap, iSYAxisOverlap {
                        // print("MJLineChart ==> 有重叠，index【\(index)】，value【\(pointText)】不绘制")
                    } else {
                        (pointText as NSString).draw(in: currentTextFrame, withAttributes: tempAttribute)
                        pointTextFrame = currentTextFrame
                    }
                }
            }
        }
    }
    
    /// Y轴报警线
    private func drawYAxisAlarmLine() {
        if configuration.isShowYAxisAlarmLine, configuration.yAxisAlarmLineThickness > 0 {
            // Max
            drawYAxisAlarmLineWithData(configuration.yAxisAlarmLineMaxValue, isAlarmMax: true)
            // Min
            drawYAxisAlarmLineWithData(configuration.yAxisAlarmLineMinValue, isAlarmMax: false)
        }
    }
    
    /// Y轴报警线
    private func drawYAxisAlarmLineWithData(_ value: Double,
                                            isAlarmMax: Bool) {
        var x: CGFloat = 0
        var y = getYAxisValue(data: value)
        
        if isAlarmMax {
            if value > getMaxYAxisValue() {
                print("MJLineChart ==> 报警线数值：\(value) 超过Y轴最大值：\(getMaxYAxisValue())")
                return
            }
        } else {
            if value < configuration.yMin {
                print("MJLineChart ==> 报警线数值：\(value) 低于Y轴最小值：\(configuration.yMin)")
                return
            }
        }
        
        let startPoint = CGPoint(x: x, y: y)
        let endPoint = CGPoint(x: chartWidth, y: y)
        drawLine(startPoint: startPoint, endPoint: endPoint, lineColor: configuration.yAxisAlarmLineColor, lineWidth: configuration.yAxisAlarmLineThickness, isLineDash: true)
        // alarm text
        let alarmString = "\(value)\(configuration.yShortUnit)"
        let alarmAttributedString = [NSAttributedString.Key.font: configuration.axisTextFont, NSAttributedString.Key.foregroundColor: configuration.alarmPointColor]
        let alarmSize = alarmString.size(withAttributes: alarmAttributedString)
        x = startPoint.x + configuration.xAxisTextOffset
        y = endPoint.y - configuration.xAxisTextOffset - alarmSize.height
        if y < alarmSize.height + configuration.xAxisTextOffset {
            y = endPoint.y + configuration.xAxisTextOffset
        }
        let textRect = CGRect(x: x, y: y, width: alarmSize.width, height: alarmSize.height)
        (alarmString as NSString).draw(in: textRect, withAttributes: alarmAttributedString)
    }
    
    /// 绘制长按虚线
    private func drawLongPressDashLine() {
        if isLongPress {
            if currentLongPressX != nil {
                drawLongPressNearestLine(x: currentLongPressX!, color: configuration.longPressColor)
                //
                drawLongPressText(index: lastPointIndex)
                drawLongPressPoint(index: lastPointIndex)
            }
            var currentScreenPointX = screenPoint.x + didScrollContentOffset.x
            if didScrollContentOffset.x > 0 {
                currentScreenPointX -= configuration.xSegmentSpace
            }
            
            //
            let isOverstepX: Bool = currentScreenPointX < configuration.xSegmentSpace
            let isOverstepY: Bool = currentScreenPointX > configuration.xSegmentSpace * CGFloat(configuration.xSegmentCount + 1)
            if isOverstepX || isOverstepY {
                // currentLongPressX = nil
                // return
            }
            
            // Find Point
            let result: FindLongpressPoint = findPointInLines(x: currentScreenPointX)
            // print("已找到长按屏幕所在的折线：")
            // print("折线下标：\(result.lineIndex)，点下标：\(result.pointIndex)")
            
            if longPressPointIndexBlock != nil, lastPointIndex != result.pointIndex {
                lastPointIndex = result.pointIndex
                longPressPointIndexBlock!(result.pointIndex)
            }
            
            if let line = totalLinesPoint.first {
                let point = line[result.pointIndex]
                
                if currentLongPressX == nil {
                    currentLongPressX = point.x
                    drawLongPressNearestLine(x: currentLongPressX!, color: configuration.longPressColor)
                    //
                    drawLongPressText(index: lastPointIndex)
                    drawLongPressPoint(index: lastPointIndex)
                } else {
                    if currentLongPressX != point.x {
                        currentLongPressX = point.x
                        self.setNeedsDisplay()
                    }
                }
            }
        } else {
            currentLongPressX = nil
            lastPointIndex = -1
        }
    }
    
    /// 根据x画长按线
    private func drawLongPressNearestLine(x: CGFloat,
                                          color: UIColor) {
        let startPoint = CGPoint(x: x, y: topMargin)
        let endPoint = CGPoint(x: startPoint.x, y: startPoint.y + yAxisHeight)
        drawLine(startPoint: startPoint, endPoint: endPoint, lineColor: color, lineWidth: configuration.yAxisAlarmLineThickness, isLineDash: true)
    }
    
    /// 绘制长按 X轴 Y轴 对应的数据
    private func drawLongPressText(index: Int) {
        var xValue: String = ""
        var yValue: String = ""
        var alarmValue: String?
        // PS：暂时只处理一条折线的情况
        if let line = totalLines.first, index < line.count {
            let data = line[index]
            xValue = data.xValue
            yValue = removeZero(value: data.yAxisValue)
            if let doubleYValue: Double = Double(yValue) {
                if doubleYValue >= configuration.yAxisAlarmLineMaxValue {
                    alarmValue = "\(configuration.maxAlarmPrefix) \(configuration.yAxisAlarmLineMaxValue)\(configuration.yShortUnit)"
                }
                if doubleYValue <= configuration.yAxisAlarmLineMinValue {
                    alarmValue = "\(configuration.minAlarmPrefix) \(configuration.yAxisAlarmLineMinValue)\(configuration.yShortUnit)"
                }
            }
            yValue.append(configuration.yShortUnit)
            
            // ------- //
            if configuration.isShowLongPressMoveText {
                //
                let viewSize = LongPressView.getViewSize()
                let xOffset: CGFloat = 40
                let yOffset: CGFloat = 20
                let screenWidth = UIScreen.main.bounds.size.width
                
                var x = currentLongPressX! + xOffset
                if chartWidth + configuration.yAxisViewWidth > screenWidth {
                    if x > screenWidth - configuration.yAxisViewWidth - viewSize.width + didScrollContentOffset.x {
                        x = currentLongPressX! - xOffset - viewSize.width
                    }
                } else {
                    if x > chartWidth - viewSize.width {
                        x = currentLongPressX! - xOffset - viewSize.width
                    }
                }
                var y = screenPoint.y + yOffset
                if y < topMargin {
                    y = topMargin
                }
                if y > crossingPointY - viewSize.height  {
                    y = crossingPointY - viewSize.height
                }
                let longPressRect: CGRect = CGRect(x: x, y: y, width: viewSize.width, height: viewSize.height)
                let longPressView = LongPressView(frame: longPressRect)
                longPressView.setupLongPressView(xValue: xValue, yValue: yValue, alarmValue: alarmValue)
                
                let image: UIImage = longPressView.screenshotsImage()
                image.draw(in: longPressRect)
            }
            
            if configuration.isShowLongPressTopText {
                var text = "\(xValue) , \(yValue)"
                if let alarmValue = alarmValue {
                    text.append("  (\(alarmValue))")
                }
                let alarmAttributedString = [NSAttributedString.Key.font: configuration.longPressTextFont, NSAttributedString.Key.foregroundColor: configuration.alarmPointColor]
                let normalAttributedString = [NSAttributedString.Key.font: configuration.longPressTextFont, NSAttributedString.Key.foregroundColor: configuration.chartLineColor]
                let textSize = text.size(withAttributes: normalAttributedString)
                
                let screenWidth = UIScreen.main.bounds.size.width
                let x = (screenWidth - configuration.yAxisViewWidth - textSize.width) / 2 + didScrollContentOffset.x * 1
                let y: CGFloat = 0
                
                let isAlarm = isAlarm(value: data.yAxisValue)
                let textRect = CGRect(x: x, y: y, width: textSize.width, height: textSize.height)
                (text as NSString).draw(in: textRect, withAttributes: isAlarm ? alarmAttributedString : normalAttributedString)
            }
        }
    }
    
    /// 长按 锚点变大
    private func drawLongPressPoint(index: Int) {
        if let line = totalLines.first, index < line.count {
            let data = line[index]
            let isAlarm = isAlarm(value: data.yAxisValue)
            
            if let pointLine = totalLinesPoint.first, index < pointLine.count {
                let point = pointLine[index]
                let radius: CGFloat = configuration.pointRadius + 1
                let pointColor: UIColor = isAlarm ? configuration.alarmPointColor : configuration.normalPointColor
                drawCircle(startPoint: point, radius: radius, color: pointColor)
            }
        }
    }
    
    private func isAlarm(value: Double) -> Bool {
        let isAlarm = value >= configuration.yAxisAlarmLineMaxValue || value <= configuration.yAxisAlarmLineMinValue
        return isAlarm
    }
    
    struct FindLongpressPoint {
        // 长按时默认只处理第一条折线
        // var lineIndex: Int = 0
        var pointIndex: Int = 0
        var minX: CGFloat = CGFLOAT_MAX
    }
    
    /// 根据长按屏幕点，找寻最近点
    private func findPointInLines(x: CGFloat) -> FindLongpressPoint {
        // PS: 未处理多条线存在相同Y点
        var result: FindLongpressPoint = FindLongpressPoint()
        // var currentLineIndex: Int = 0
        var currentPointIndex: Int = 0
        
        // for (lineIndex, line) in totalLinesPoint.enumerated() {
        if let line = totalLinesPoint.first {
            for (pointIndex, point) in line.enumerated() {
                result.minX = min(abs(x - point.x), result.minX)
                if abs(x - point.x) <= result.minX {
                    // currentLineIndex = lineIndex
                    currentPointIndex = pointIndex
                }
            }
        }
        // }
        
        // result.lineIndex = currentLineIndex
        result.pointIndex = currentPointIndex
        
        return result
    }
    
    /// 根据数值返回对应Y轴坐标
    private func getYAxisValue(data: Double) -> CGFloat {
        let topMargin = topMargin
        let ySegmentHeight: CGFloat = (yAxisHeight - configuration.ySegmentTopSpace) / CGFloat(configuration.ySegmentCount)
        let yValue: Double = yAxisHeight - (data - configuration.yMin) / ySegmentValue * ySegmentHeight
        let y = topMargin + CGFloat(yValue)
        return y
    }
    
    /// 根据数值返回对应X轴坐标
    private func getXAxisValue(data: Double) -> CGFloat {
        let xMin = configuration.xMin - xSegmentValue
        let x: Double = abs(data - xMin) / (configuration.xMax - configuration.xMin) * (chartWidth - configuration.xSegmentSpace - configuration.xLastSegmentSpace)
        return x
    }
    
    /// 获取Y轴最大值
    private func getMaxYAxisValue() -> CGFloat {
        let ySegmentHeight: CGFloat = (yAxisHeight - configuration.ySegmentTopSpace) / CGFloat(configuration.ySegmentCount)
        let maxData = yAxisHeight / ySegmentHeight * ySegmentValue + configuration.yMin
        return maxData
    }
    
    /// 根据X轴数值画Y轴虚线
    private func drawYAxisDashLine(data: Double) {
        let x = getXAxisValue(data: data)
        let startPoint = CGPoint(x: x, y: topMargin)
        let endPoint = CGPoint(x: x, y: startPoint.y + yAxisHeight)
        drawLine(startPoint: startPoint, endPoint: endPoint, lineColor: configuration.yAxisAlarmLineColor, lineWidth: configuration.yAxisAlarmLineThickness, isLineDash: true)
    }
    
    /// 画线
    private func drawLine(startPoint: CGPoint,
                          endPoint: CGPoint,
                          lineColor: UIColor,
                          lineWidth: CGFloat,
                          isLineDash: Bool = false) {
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        
        let path = CGMutablePath()
        path.move(to: startPoint)
        path.addLine(to: endPoint)
        
        context.addPath(path)
        context.setStrokeColor(lineColor.cgColor)
        context.setLineWidth(lineWidth)
        
        if isLineDash {
            let lengths: [CGFloat] = [5]
            context.setLineDash(phase: 1, lengths: lengths)
        }
        context.strokePath()
    }
    
    /// 画圆点
    private func drawCircle(startPoint: CGPoint,
                            radius: CGFloat,
                            color: UIColor) {
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        
        context.setFillColor(color.cgColor)
        context.addArc(center: startPoint, radius: radius, startAngle: 0, endAngle: 2 * .pi, clockwise: false)
        context.fillPath()
    }
    
    /// 祛除多余的零
    private func removeZero(value: Double) -> String {
        let numberString = String(format: "%f", value)
        
        if numberString.contains(".") {
            var outNumber = numberString
            var i = 1
            while i < numberString.count {
                if outNumber.hasSuffix("0") {
                    outNumber.remove(at: outNumber.index(before: outNumber.endIndex))
                    i = i + 1
                } else {
                    break
                }
            }
            if outNumber.hasSuffix(".") {
                outNumber.remove(at: outNumber.index(before: outNumber.endIndex))
            }
            return outNumber
        } else {
            return numberString
        }
    }
}

// MARK: - YAxisView
class YAxisView: UIView {
    /// 折线图配置
    private var configuration: MJLineChartConfiguration!
    /// YAxisView 宽
    private var chartWidth: CGFloat = 0
    /// YAxisView 高
    private var chartHeight: CGFloat = 0
    
    /// 实际Y轴每段数值
    private var ySegmentValue: Double = 0
    /// Y轴高度
    private var yAxisHeight: CGFloat = 0
    /// X轴 Y轴 交界点 (point.x)
    private var crossingPointX: CGFloat = 0
    
    private var topMargin: CGFloat = 0
    private var bottomMargin: CGFloat = 0
    
    private var textAttributedString: Dictionary<NSAttributedString.Key, Any> = [:]
    private var unitAttributedString: Dictionary<NSAttributedString.Key, Any> = [:]
    
    // MARK: -
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupYAxis(frame: CGRect,
                           configuration: MJLineChartConfiguration) {
        self.frame = frame
        self.chartWidth = frame.size.width
        self.chartHeight = frame.size.height
        self.configuration = configuration
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        drawYAxisLine()
    }
    
    /// Y轴线
    private func drawYAxisLine() {
        textAttributedString = [NSAttributedString.Key.font: configuration.axisTextFont, NSAttributedString.Key.foregroundColor: configuration.axisTextColor]
        unitAttributedString = [NSAttributedString.Key.font: configuration.axisTextFont, NSAttributedString.Key.foregroundColor: configuration.yUnitColor]
        
        topMargin = getTopMargin()
        bottomMargin = topMargin + configuration.xAxisTextOffset
        
        yAxisHeight = chartHeight - topMargin - bottomMargin
        ySegmentValue = (configuration.yMax - configuration.yMin) / Double(configuration.ySegmentCount)
        
        crossingPointX = chartWidth - configuration.xyAxisLineThickness * 0.5
        
        if configuration.isShowYAxisLine {
            // Y轴
            drawYAxis()
            // 刻度
            drawYAxisSegment()
            // Y轴单位
            drawYAxisUnit()
        }
        // 刻度对应的文本
        drawYAxisText()
    }
    
    /// Y轴顶部单位文本高度
    private func getTopMargin() -> CGFloat {
        let textSize = "y".size(withAttributes: unitAttributedString)
        return textSize.height
    }
    
    /// Y轴
    private func drawYAxis() {
        let startPoint = CGPoint(x: crossingPointX, y: topMargin)
        let endPoint = CGPoint(x: startPoint.x, y: chartHeight - bottomMargin)
        drawLine(startPoint: startPoint, endPoint: endPoint, lineColor: configuration.axisLineColor, lineWidth: configuration.xyAxisLineThickness)
    }
    
    /// 刻度
    private func drawYAxisSegment() {
        for index in 0..<configuration.ySegmentCount + 1 {
            if configuration.isShowYAxisSegment, configuration.xyAxisSegmentWidth > 0 {
                let x: CGFloat = crossingPointX
                let value: Double = configuration.yMin + Double(index) * ySegmentValue
                let yValue: Double = (1 - abs(value - configuration.yMin) / (configuration.yMax - configuration.yMin)) * (yAxisHeight - configuration.ySegmentTopSpace)
                let y: CGFloat = topMargin + configuration.ySegmentTopSpace + CGFloat(yValue)
                let startPoint = CGPoint(x: x, y: y)
                let endPoint = CGPoint(x: x - (configuration.xyAxisSegmentWidth + configuration.xyAxisLineThickness), y: y)
                if index != 0 {
                    drawLine(startPoint: startPoint, endPoint: endPoint, lineColor: configuration.axisLineColor, lineWidth: configuration.xyAxisLineThickness)
                }
            }
        }
    }
    
    /// 刻度对应的文本
    private func drawYAxisText() {
        for index in 0..<configuration.ySegmentCount + 1 {
            // x
            let yCurrentSegmentValue: Double = configuration.yMin + ySegmentValue * Double(index)
            let ySegmentText = String(format: configuration.yAxisTextFormat, yCurrentSegmentValue)
            let textSize = ySegmentText.size(withAttributes: textAttributedString)
            let x = crossingPointX - configuration.xyAxisLineThickness - configuration.xAxisTextOffset - textSize.width
            // y
            let value: Double = configuration.yMin + Double(index) * ySegmentValue
            let yValue: Double = (1 - abs(value - configuration.yMin) / (configuration.yMax - configuration.yMin)) * (yAxisHeight - configuration.ySegmentTopSpace)
            let y: CGFloat = topMargin + configuration.ySegmentTopSpace + CGFloat(yValue) - textSize.height / 2
            // 刻度文本
            let textRect = CGRect(x: x, y: y, width: textSize.width, height: textSize.height)
            (ySegmentText as NSString).draw(in: textRect, withAttributes: textAttributedString)
        }
    }
    
    /// Y轴单位
    private func drawYAxisUnit() {
        if configuration.yUnit.count > 0 {
            let unitSize = configuration.yUnit.size(withAttributes: unitAttributedString)
            let x = crossingPointX - configuration.xyAxisLineThickness - unitSize.width
            let y: CGFloat = 0
            let textRect = CGRect(x: x, y: y, width: unitSize.width, height: unitSize.height)
            (configuration.yUnit as NSString).draw(in: textRect, withAttributes: unitAttributedString)
        }
    }
    
    /// 画线
    private func drawLine(startPoint: CGPoint,
                          endPoint: CGPoint,
                          lineColor: UIColor,
                          lineWidth: CGFloat) {
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        
        let path = CGMutablePath()
        path.move(to: startPoint)
        path.addLine(to: endPoint)
        
        context.addPath(path)
        context.setStrokeColor(lineColor.cgColor)
        context.setLineWidth(lineWidth)
        context.strokePath()
    }
}

class LongPressView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var bgImageView: UIImageView = {
        let imageView: UIImageView = UIImageView(frame: CGRectZero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var xValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.numberOfLines = 0
        label.font = textFont
        return label
    }()
    
    private lazy var yValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.numberOfLines = 0
        label.font = textFont
        return label
    }()
    
    private lazy var alarmLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .red
        label.numberOfLines = 0
        label.font = textFont
        return label
    }()
    
    // MARK: -
    public var backgroundImageName: String = "longPressBG" {
        didSet {
            bgImageView.image = UIImage(named: backgroundImageName)
        }
    }
    
    public var textFont: UIFont = UIFont.systemFont(ofSize: 10) {
        didSet {
            xValueLabel.font = textFont
            yValueLabel.font = textFont
            alarmLabel.font = textFont
        }
    }
    
    // MARK: -
    static func getViewSize() -> CGSize {
        return CGSize(width: 88, height: 62)
    }
    
    public func setupLongPressView(xValue: String,
                                   yValue: String,
                                   alarmValue: String?) {
        xValueLabel.text = xValue
        yValueLabel.text = yValue
        if let alarmValue: String = alarmValue {
            alarmLabel.text = alarmValue
        }
        setupViews()
    }
    
    private func setupViews() {
        bgImageView.image = UIImage(named: backgroundImageName)
        
        addSubview(bgImageView)
        bgImageView.addSubview(xValueLabel)
        bgImageView.addSubview(yValueLabel)
        bgImageView.addSubview(alarmLabel)
        //
        bgImageView.frame = self.bounds
        //
        var text = xValueLabel.text ?? ""
        let x: CGFloat = 15
        var y: CGFloat = 3
        if alarmLabel.text == nil {
            y = 15
        } else {
            yValueLabel.textColor = alarmLabel.textColor
        }
        var size = text.boundingRect(with: bgImageView.frame.size, font: textFont)
        var rect: CGRect = CGRect(x: x, y: y, width: size.width, height: size.height)
        xValueLabel.frame = rect
        //
        text = yValueLabel.text ?? ""
        y = CGRectGetMaxY(rect) + 5
        size = text.boundingRect(with: bgImageView.frame.size, font: textFont)
        rect = CGRect(x: x, y: y, width: size.width, height: size.height)
        yValueLabel.frame = rect
        //
        text = alarmLabel.text ?? ""
        y = CGRectGetMaxY(rect) + 5
        size = text.boundingRect(with: bgImageView.frame.size, font: textFont)
        rect = CGRect(x: x, y: y, width: size.width, height: size.height)
        alarmLabel.frame = rect
    }
    
    /// 获取控件截图
    public func screenshotsImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}

// MARK: - extension String
extension String {
    func boundingRect(with constrainedSize: CGSize,
                      font: UIFont,
                      lineSpacing: CGFloat? = nil) -> CGSize {
        let attribute = NSMutableAttributedString(string: self)
        let range = NSRange(location: 0, length: attribute.length)
        attribute.addAttributes([NSAttributedString.Key.font: font], range: range)
        if lineSpacing != nil {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = lineSpacing!
            attribute.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: range)
        }
        
        let rect = attribute.boundingRect(with: constrainedSize, options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil)
        var size = rect.size
        
        if let currentLineSpacing = lineSpacing {
            // 文本的高度减去字体高度小于等于行间距，判断为当前只有1行
            let spacing = size.height - font.lineHeight
            if spacing <= currentLineSpacing && spacing > 0 {
                size = CGSize(width: size.width, height: font.lineHeight)
            }
        }
        
        return size
    }
    
    func boundingRect(with constrainedSize: CGSize,
                      font: UIFont,
                      lineSpacing: CGFloat? = nil,
                      lines: Int) -> CGSize {
        if lines < 0 {
            return .zero
        }
        
        let size = boundingRect(with: constrainedSize, font: font, lineSpacing: lineSpacing)
        if lines == 0 {
            return size
        }
        
        let currentLineSpacing = (lineSpacing == nil) ? (font.lineHeight - font.pointSize) : lineSpacing!
        let maximumHeight = font.lineHeight * CGFloat(lines) + currentLineSpacing * CGFloat(lines - 1)
        if size.height >= maximumHeight {
            return CGSize(width: size.width, height: maximumHeight)
        }
        
        return size
    }
}
