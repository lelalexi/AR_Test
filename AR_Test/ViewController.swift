//
//  ViewController.swift
//  AR_Test
//
//  Created by Gaston Alexis Garcia Carli on 27/03/2019.
//  Copyright © 2019 Gaston Alexis Garcia Carli. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    var cube = SCNNode()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Show some debug data
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        
        // Turn On the the Auto Ilumination
        sceneView.autoenablesDefaultLighting = true
        
        
    }
    
    private func drawCube(){
        //Creo la primitiva de cubo
        cube = SCNNode(geometry: SCNBox(width: 0.05, height: 0.05, length: 0.05, chamferRadius: 0.0))
        //Le seteo el material para poder aplicar metodos de iluminacion y sombreados
            //seteo el componente difuso
            cube.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
            //seteo componente especular
            cube.geometry?.firstMaterial?.specular.contents = UIColor.white //color de la luz blanca
        //Seteo la posicion de la primitiva en el mundo
        cube.position = SCNVector3(0,0,0)
        //Seteo la animacion de rotacion y luego la agrego a la escena
        let rotateAction = SCNAction.rotate(by: 360.degreesToRadians(), around: SCNVector3(0 ,1 ,0), duration: 8)
        let rotateForever = SCNAction.repeatForever(rotateAction)
        cube.runAction(rotateForever)
        //añado la figura a la scena
        sceneView.scene.rootNode.addChildNode(cube)
        
    }
    
    private func drawPiramid(){
        let piramid = SCNNode(geometry: SCNPyramid(width: 0.1, height: 0.1, length: 0.1) )
        //Le seteo el material para poder aplicar metodos de iluminacion y sombreados
        //seteo el componente difuso
        piramid.geometry?.firstMaterial?.diffuse.contents = UIColor.green
        //seteo componente especular
        piramid.geometry?.firstMaterial?.specular.contents = UIColor.red //color de la luz blanca
        //Seteo la posicion de la primitiva en el mundo
        piramid.position = SCNVector3(0,-0.20,0.30)
        //añado la figura a la scena
        sceneView.scene.rootNode.addChildNode(piramid)
    }
    
    private func drawCatPhotoPlane(){
        //Creo la primitiva del plano
        let plane = SCNNode(geometry: SCNPlane(width: 0.1, height: 0.1))
        //seteo la Cat image al planeo
        plane.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "cat")
        //seteo que haga el render de la imagen de ambos lados
        plane.geometry?.firstMaterial?.isDoubleSided = true
        //Seteo la posicion de la primitiva en el mundo
        plane.position = SCNVector3(-0.2,0,0)
        //Seteo la rotacion del plano
        plane.eulerAngles = SCNVector3( -45.degreesToRadians(), 20.degreesToRadians(), 45.degreesToRadians())
        //añado la figura a la scena
        sceneView.scene.rootNode.addChildNode(plane)
        
    }
    
    func drawOrbtingShip(){
        //obtengo la escena de mi art.scnassets
        let scene = SCNScene(named: "art.scnassets/ship.scn")!
        //obtengo el objeto de la scene a partir de su childNode asociado al nombre "ship"
        let ship = (scene.rootNode.childNode(withName: "ship", recursively: false))!
        //Seteo la posicion y la escala
        ship.position = SCNVector3(0.13,0,0)
        ship.scale = SCNVector3(0.1 ,0.1, 0.1)
        ship.eulerAngles = SCNVector3(0.0, 180.degreesToRadians(), 0.0)
        //lo añado como childNode al cubo rotando
        cube.addChildNode(ship)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
        drawCube()
        drawPiramid()
        drawCatPhotoPlane()
        drawOrbtingShip()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
extension Int {
    func degreesToRadians() -> CGFloat {
        return CGFloat(self) * CGFloat.pi / 180.0
    }
}
