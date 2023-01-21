//
//  GameScene.swift
//  MiniChallenge002 Shared
//
//  Created by Henrique Batista de Assis on 11/11/22.
//

import SpriteKit

class GameScene: SKScene {
    
    
    fileprivate var label : SKLabelNode?
    fileprivate var spinnyNode : SKShapeNode?
    public var cont: Int = 0
    public var score: Int = 0

    class func newGameScene() -> GameScene {
      
        guard let scene = SKScene(fileNamed: "GameScene") as? GameScene else {
            print("Failed to load GameScene.sks")
            abort()
        }    // Set the scale mode to scale to fit the window
        scene.scaleMode = .resizeFill
        
        return scene
    }
   

     lazy var texto: SKLabelNode = {
       var texto = SKLabelNode(fontNamed: "Party Confetti")
        texto.fontSize = CGFloat(100)
        texto.zPosition = 0
        texto.fontColor = SKColor.black
        texto.horizontalAlignmentMode = .center
        texto.verticalAlignmentMode = .center
         
        texto.text = ("\(cont)")
         return texto
    }()
    
 
   lazy var contador: SKLabelNode = {
        var label = SKLabelNode(fontNamed: "Party Confetti")
        label.fontSize = CGFloat(100)
        label.zPosition = 0
        label.fontColor = SKColor.magenta
        label.horizontalAlignmentMode = .left
        label.verticalAlignmentMode = .center
        label.text = "\(counterStartValue)"
        return label
    }()
    var counter = 0
    var counterTime = Timer()
    var counterStartValue = 60
    
    var isGameOver = false
    
    //start
    override func didMove(to view: SKView) {
      
        backgroundColor = .white
        self.scaleMode = .resizeFill
       
        texto.position = CGPoint(x: self.size.width * 0.79, y: self.size.height * 0.28)
        addChild(texto)
        
        contador.position = CGPoint(x: self.size.width * 0.1, y: self.size.height * 0.9)
        addChild(contador)
        
  
        counter = counterStartValue
        startCounter()
        
        let botaoRemove = ButtonPrefab(positionPoint: CGPoint(x: self.size.width * 0.8, y: self.size.height * 0.15), spriteSize: CGSize(width: 150, height: 170), labelText: "", fontSize: 0, textureName: "triangulo 2",  buttonType: .withoutAnim, action: {
            self.removeScore()
            self.texto.text = ("\(self.cont)")

        })
  
        let botaoAdd = ButtonPrefab(positionPoint: CGPoint(x: self.size.width * 0.8, y: self.size.height * 0.4), spriteSize: CGSize(width: 150, height: 170), labelText: "", fontSize: 0, textureName: "triangulo 1",  buttonType: .withoutAnim, action: {
            self.addScore()
            self.texto.text=("\(self.cont)")
   
        })
        
        let botaoOk = ButtonPrefab(positionPoint: CGPoint(x: self.size.width * 0.7, y: self.size.height * 0.25) , spriteSize: CGSize(width: 285, height: 300), labelText: "", fontSize: 0, textureName: "ok",  buttonType: .withoutAnim, action: {
            
            let transition:SKTransition = SKTransition.fade(withDuration: 1)
            let scene:SKScene = GameOver(size: self.size)
            self.view?.presentScene(scene, transition: transition)
            
        })
        
        self.addChild(botaoAdd)
        self.addChild(botaoRemove)
        self.addChild(botaoOk)
    }
    
    public func addScore(){
        self.cont += 1
    }
    
    public func removeScore(){
        self.cont -= 1
    }
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    func startCounter(){
        counterTime = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(decrementCounter), userInfo: nil, repeats: true)
    }
    @objc func decrementCounter(){
        if !isGameOver{
            counter -= 1
           contador.text = "\(counter)"
            let minutos = counter/60
            let segundos = counter % 60
            let minutoTexto = minutos < 10 ? "0\(minutos)" : "\(minutos)"
            let segundosTexto = segundos < 10 ? "0\(segundos)" : "\(segundos)"
            
            contador.text = "\(minutoTexto):\(segundosTexto)"
           
            }
        if counter <= 0{
            isGameOver = true
        }
    }
}
