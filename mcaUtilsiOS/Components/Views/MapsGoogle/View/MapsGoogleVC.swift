//
//  MapsGoogleVC.swift
//  MiClaro
//
//  Created by Jonathan Abimael Cruz Orozco on 24/08/17.
//  Copyright © 2017 am. All rights reserved.
//

import UIKit
import GoogleMaps
//import GooglePlacesSearchController
import MapKit
import CoreLocation

/// Esta clase despliega en pantalla la región del mapa de las sucursales del país seleccionado
class MapsGoogleVC: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate, UITextFieldDelegate {

    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var distanceTopConstraint: NSLayoutConstraint!
    let locationManager = CLLocationManager()
    
    let conf = SessionSingleton.sharedInstance.getGeneralConfig()
    var arrayCACInfo: [CacInfo] = []
    var zoom: Float = 15

    internal var viewDetailContain : UIView?
    internal var imgView : UIImageView?
    internal var lblTitulo : UILabel?
    internal var lblCuerpo : UILabel?
    
    private let dataProvider = GoogleDataProvider()
    private let searchRadius: Double = 10000
    
    @IBOutlet weak var searchBar: UITextField!
    
    lazy var placesSearchController: GooglePlacesSearchController = {
        let controller = GooglePlacesSearchController(delegate: self,
                                                      apiKey: googleApiKey,
                                                      placeType: .all
//                                                      coordinate: CLLocationCoordinate2D(latitude: 19.413457, longitude: -99.132712)
            // Optional: radius: 10,
            // Optional: strictBounds: true,
            // Optional: searchBarPlaceholder: "Start typing..."
        )
        //Optional: controller.searchBar.isTranslucent = false
        //Optional: controller.searchBar.barStyle = .black
        //Optional: controller.searchBar.tintColor = .white
        //Optional: controller.searchBar.barTintColor = .black
        controller.searchBar.placeholder = "Encuentra tu Centro de atención"
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initWith(navigationType: navType.supportSectionCenterAttention)
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        let camera = GMSCameraPosition.camera(withLatitude: -33.3932458, longitude: -70.7828948, zoom: 6.0)
        mapView.camera = camera
        mapView?.delegate = self
        
        searchBar.delegate = self
        print(googleApiKey)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        AnalyticsInteractionSingleton.sharedInstance.ADBTrackViewSoporte(viewName: "Soporte|Centros de atencion", message: "")
        self.getPointsForMap(map: mapView)
        self.addHeaderView(nameImage: "icon_seccion_soporte_centros", title: "Centros de atención", subTitle: "Encuentra tu centro de atención más cercano.")
    }
    
    /// Funcion para agregar el encabezado en la sección de soporte
    func addHeaderView(nameImage: String, title: String, subTitle: String) {
        let frameHeader = CGRect(x: 10.0, y: 80.0, width: self.view.frame.width - 10.0 * 2, height: self.view.frame.height * 0.18)
        let header = UIHeaderForm2(frame: frameHeader)
        header.setupElements(imageName: nameImage, title: title, subTitle: subTitle)
        header.backgroundColor = UIColor.white
        self.view.addSubview(header)
        self.distanceTopConstraint.constant = self.view.frame.height * 0.18
        self.distanceTopConstraint.constant = 0
    }
    
    /// Obtiene los puntos a mostrar en el mapa
    /// - Parameter map: Mapa donde se mostraran los puntos de los centros de atención
    func getPointsForMap(map: GMSMapView) {
        
        if conf?.help?.cacInfo != nil {
            let arrayTmp = (conf?.help?.cacInfo)!
            
            for pointCAC in arrayTmp {
                arrayCACInfo.append(pointCAC)
            }
            
            //After get the points, we create the markers
            for markerTmp in arrayCACInfo {
                let placeCAC = PlaceCAC(cacInfo: markerTmp)
                placeCAC.map = map
            }
        }
    }

    /// Creación de la ventana de detalle de cada marcador
    /// - Parameter detail: Objeto del Tipo PlaceCAC para obtener información del centro de atención
    /// - Returns UIView: Custom view para mostrar el detalle del centro de atención con una imagen del lado izquierdo
    func createInfoDetailView(detail: PlaceCAC) -> UIView {
        viewDetailContain = UIView(frame: CGRect(x: 0.0, y: 0.0, width: self.view.frame.width - 20.0, height: 100))

        let paddingX: CGFloat = 5.0
        var paddingY: CGFloat = 3.0
        let widthImg: CGFloat = viewDetailContain!.frame.width * 0.3
        let withLbl: CGFloat = viewDetailContain!.frame.width * 0.7 - paddingX * 2.0
        let heightImg: CGFloat = viewDetailContain!.frame.height - paddingY * 2.0

        imgView = UIImageView(frame: CGRect(x: paddingX, y: paddingY, width: widthImg, height: heightImg))

        lblTitulo = UILabel(frame: CGRect(x:paddingX + widthImg + 2.0, y: paddingY, width: withLbl, height: 20));
        lblTitulo?.text = String(format: "%@", detail.title ?? "");
        lblTitulo?.numberOfLines = 6
        lblTitulo?.textAlignment = .left
        lblTitulo?.textColor = institutionalColors.claroBlackColor
        lblTitulo?.font = UIFont(name: RobotoFontName.RobotoMedium.rawValue, size: 13);
        lblTitulo?.adjustHeighToFit();

        paddingY = paddingY + lblTitulo!.frame.size.height;

        lblCuerpo = UILabel(frame: CGRect(x: paddingX + widthImg + 2.0, y: paddingY, width: withLbl, height: heightImg))
        lblCuerpo?.text = detail.snippet
        lblCuerpo?.numberOfLines = 6
        lblCuerpo?.textAlignment = .left
        lblCuerpo?.textColor = institutionalColors.claroTextColor
        lblCuerpo?.font = UIFont(name: RobotoFontName.RobotoMedium.rawValue, size: 13)
        lblCuerpo?.adjustsFontSizeToFitWidth = true
        lblCuerpo?.lineBreakMode = .byWordWrapping

        viewDetailContain?.addSubview(lblTitulo!);
        viewDetailContain?.addSubview(lblCuerpo!)
        viewDetailContain?.addSubview(imgView!)

        viewDetailContain?.frame.size.height = lblTitulo!.frame.size.height + lblCuerpo!.frame.size.height;
        if(detail.urlImage == ""){
            imgView?.image = UIImage(named: "baseline_image_black")
        }else{
            imgView?.downloadedFrom(link: detail.urlImage);
        }
        
        return viewDetailContain!
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        present(placesSearchController, animated: true, completion: nil)
    }

    //MARK: Google maps delegate
    func mapView(_ mapView: GMSMapView, markerInfoContents marker: GMSMarker) -> UIView? {
        let place = marker as! PlaceCAC
        let myMarker = createInfoDetailView(detail: place);

        return myMarker;
    }

    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {

        return false
    }

    //MARK: Location manager delegate
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.stopUpdatingLocation()

            mapView.isMyLocationEnabled = true
            mapView.settings.myLocationButton = true
//            mapView.padding = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
//            self.moveLocationButton()
            
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 6.0, bearing: 0, viewingAngle: 0)

            locationManager.stopUpdatingLocation()
        }
    }
    
    func moveLocationButton() -> Void{
        for object in mapView.subviews{
            for obj in object.subviews{
                    for view in obj.subviews{
                        if let button = view as? UIButton{
                            let name = button.accessibilityIdentifier
                            if(name == "my_location"){
                                //config a position
                                button.center = self.view.center
                                button.frame = CGRect(x: 50, y: 100.00, width: 50, height: 50)
                            }
                        }
                    }
            }
        }
    }
    
    @IBAction func refreshPlaces(_ sender: Any) {
        present(placesSearchController, animated: true, completion: nil)
        //        fetchNearbyPlaces(coordinate: mapView.camera.target)
    }
    
    func fetchNearbyPlaces(coordinate: CLLocationCoordinate2D) {
        mapView.clear()
        
        dataProvider.fetchPlacesNearCoordinate(coordinate, radius:searchRadius, place:"comida") {
            places in places.forEach {
                let marker = PlaceMarker(place: $0)
                marker.map = self.mapView
            }
        }
    }
    
    func searchPlace(){
        
    }
    
    @IBAction func btnZoomIn(_ sender: Any) {
        zoom = zoom + 1
        self.mapView.animate(toZoom: zoom)
    }
    
    @IBAction func btnZoomOut(_ sender: Any) {
        zoom = zoom - 1
        self.mapView.animate(toZoom: zoom)
    }

}

extension MapsGoogleVC: GooglePlacesAutocompleteViewControllerDelegate {
    func viewController(didAutocompleteWith place: PlaceDetails) {
        print(place.description)
        placesSearchController.isActive = false
        mapView.clear()
        mapView.camera = GMSCameraPosition(target: place.coordinate!, zoom: 6.0, bearing: 0, viewingAngle: 0)
        
        let seachPointCACInfo = CacInfo()
        seachPointCACInfo.address = place.formattedAddress
        seachPointCACInfo.name = place.name
        seachPointCACInfo.coordX = "\(place.coordinate?.latitude ?? 0)"
        seachPointCACInfo.coordY = "\(place.coordinate?.longitude ?? 0)"
        seachPointCACInfo.openingHours = ""
        seachPointCACInfo.urlImage = place.photoUrl

        
        let placeCAC = PlaceCAC(cacInfo: seachPointCACInfo)
        placeCAC.map = mapView
        
    }
}
