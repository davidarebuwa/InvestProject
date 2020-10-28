import Macaw

 class ChartView: MacawView {
    
    open var completionCallback: (() -> ()) = { }
    
    private var backgroundGroup = Group()
    private var mainGroup = Group()
    private var captionsGroup = Group()
    
    private var barAnimations = [Animation]()
    private let barsValues = [70, 90, 40, 55, 75, 80, 66,45, 82, 21, 43, 89]
    private let barsCaptions = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul","Aug", "Sep", "Oct", "Nov", "Dec"]
    private let barsCount = 12
    private let barsSpacing = 30
    private let barWidth = 20
    private let barHeight = 200
    
    private let emptyBarColor = Color.rgba(r: 138, g: 147, b: 219, a: 0.5)
    private let gradientColor = LinearGradient(degree: 90, from: Color(val: 0xfc0c7e), to: Color(val: 0xffd85e))
    
    private var isDark = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
      
    }
    
     required init?(coder aDecoder: NSCoder) {
        let text = Text(text: "Hello, World!", place: .move(dx: 145, dy: 100))
                super.init(node: text, coder: aDecoder)    }
    
    
    
    private func createScene() {
        let viewCenterX = Double(self.frame.width / 2)
        
        let barsWidth = Double((barWidth * barsCount) + (barsSpacing * (barsCount - 1)))
        let barsCenterX = viewCenterX - barsWidth / 2
        
        backgroundGroup = Group()
        for barIndex in 0...barsCount - 1 {
            let barShape = Shape(
                form: RoundRect(
                    rect: Rect(
                        x: Double(barIndex * (barWidth + barsSpacing)),
                        y: 0,
                        w: Double(barWidth),
                        h: Double(barHeight)
                    ),
                    rx: 5,
                    ry: 5
                ),
                fill: emptyBarColor
            )
            backgroundGroup.contents.append(barShape)
        }
        
        mainGroup = Group()
        for barIndex in 0...barsCount - 1 {
            let barShape = Shape(
                form: RoundRect(
                    rect: Rect(
                        x: Double(barIndex * (barWidth + barsSpacing)),
                        y: Double(barHeight),
                        w: Double(barWidth),
                        h: Double(0)
                    ),
                    rx: 5,
                    ry: 5
                ),
                fill: gradientColor
            )
            mainGroup.contents.append([barShape].group())
        }
        
        backgroundGroup.place = Transform.move(dx: barsCenterX, dy: 90)
        mainGroup.place = Transform.move(dx: barsCenterX, dy: 90)
        
        captionsGroup = Group()
        captionsGroup.place = Transform.move(
            dx: barsCenterX,
            dy: 100 + Double(barHeight)
        )
        for barIndex in 0...barsCount - 1 {
            let text = Text(
                text: barsCaptions[barIndex],
                font: Font(name: "SFUIText-Bold", size: 14),
                fill: Color(val: self.traitCollection.userInterfaceStyle == .dark ?  0xFFFFFF : 0x808080)
            )
            text.align = .mid
            text.place = .move(
                dx: Double((barIndex * (barWidth + barsSpacing)) + barWidth / 2),
                dy: 0
            )
            captionsGroup.contents.append(text)
        }
        
        self.node = [backgroundGroup, mainGroup, captionsGroup].group()
        self.backgroundColor = UIColor.clear
    }
    
    private func createAnimations() {
        barAnimations.removeAll()
        for (index, node) in mainGroup.contents.enumerated() {
            if let group = node as? Group {
                let heightValue = self.barHeight / 100 * barsValues[index]
                let animation = group.contentsVar.animation({ t in
                    let value = Double(heightValue) / 100 * (t * 100)
                    let barShape = Shape(
                        form: RoundRect(
                            rect: Rect(
                                x: Double(index * (self.barWidth + self.barsSpacing)),
                                y: Double(self.barHeight) - Double(value),
                                w: Double(self.barWidth),
                                h: Double(value)
                            ),
                            rx: 5,
                            ry: 5
                        ),
                        fill: self.gradientColor
                    )
                    return [barShape]
                }, during: 0.2, delay: 0).easing(Easing.easeInOut)
                barAnimations.append(animation)
            }
        }
    }
    
    open func play() {
        createScene()
        createAnimations()
        barAnimations.sequence().onComplete {
            self.completionCallback()
        }.play()
    }
    
}
