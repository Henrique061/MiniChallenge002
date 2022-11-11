//
//  VectorUtils.swift
//  MiniChallenge002 iOS
//
//  Created by Henrique Batista de Assis on 11/11/22.
//

import Foundation
import CoreGraphics
import SpriteKit

extension CGVector {
    //MARK: CONSTRUTORES
    /**
     * Cria um vetor a partir de um único ponto.
     */
    public init(point: CGPoint) {
        self.init(dx: point.x, dy: point.y)
    }
    
    /**
     *  Cria um vetor entre dois pontos.
     */
    public init(pointA: CGPoint, pointB: CGPoint) {
        self.init(dx: pointB.x - pointA.x, dy: pointB.y - pointA.y)
    }
    
    /**
     * Cria um vetor de tamanho 1 apontando para a direção determinada pelo ângulo em radianos.
     * Ângulo em 0 determina que o vetor apontará para direita.
     */
    public init(radAngle: CGFloat) {
        self.init(dx: cos(radAngle), dy: sin(radAngle))
    }
    
    /**
     * Cria um vetor de tamanho 1 apontando para a direção determinada pelo ângulo em graus.
     * Ângulo em 0 determina que o vetor apontará para direita.
     */
    public init(degAngle: CGFloat) {
        let radAngle: CGFloat = degAngle * .pi / 180
        self.init(dx: cos(radAngle), dy: sin(radAngle))
    }
    
    //MARK: METODOS e VARS
    /**
     * Retorna a magnitude do vetor (comprimento).
     */
    public var magnitude: CGFloat {
        return sqrt(pow(dx, 2) + pow(dy, 2))
    }
    
    /**
     * Retorna a normalização do vetor. Normalizar significa tranformar o vetor em tamanho 1.
     * Usado para quando queremos trabalhar apenas com a direção desse vetor.
     * Caso a magnitude for menor que 0, ele retorna o vetor em 0.
     */
    public var normalized: CGVector {
        return CGVector(dx: dx / magnitude, dy: dy / magnitude)
    }
    
    /**
     * Retorna a angulação entre o vetor implícito e um vetor explícito.
     */
    public func angle(to vector: CGVector) -> CGFloat {
        let dot = self.dx * vector.dx + self.dy * vector.dy
        let det = self.dx * vector.dy - self.dy * vector.dx
        return atan2(det, dot)
    }
    
    //MARK: ARITMETICA
    /**
     * Retorna um novo vetor a partir da soma de dois voetores distintos
     */
    public static func + (left: CGVector, right: CGVector) -> CGVector {
        return CGVector(dx: left.dx + right.dx, dy: left.dy + right.dy)
    }
    
    /**
     * Retorna um novo vetor a partir da subtracao de dois voetores distintos
     */
    public static func - (left: CGVector, right: CGVector) -> CGVector {
        return CGVector(dx: left.dx - right.dx, dy: left.dy - right.dy)
    }
}
