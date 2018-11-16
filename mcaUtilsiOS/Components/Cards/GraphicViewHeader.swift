//
//  GraphicViewHeader.swift
//  MiClaro
//
//  Created by Jonathan Abimael Cruz Orozco on 06/12/17.
//  Copyright © 2017 am. All rights reserved.
//

import UIKit
import Cartography

class GraphicViewHeader: UIView {

    //Visual elements
    var imgHeader: UIImageView!
    var vwLinea : UIView!
    var lblTitle: BlackTitleLabel!
    var graphicArc: ArcProgressView!
    var lblPorcentaje : BlackBodyLabel!
    var lblDataDisponible: BlackBodyLabel!
    var lblDataMB: BlackTitleLabel!
    var lblDate: BlackBodyLabel!
    var lblLastUpdated : BlackBodyLabel!
    var lblDatosConsumidos : BlackBodyLabel!
    var activity: UIActivityIndicatorView!
    var account : ServiceAccount?

    var overlay : UIView!
    var lblCargando : BlackTitleLabel!

    var idx : Int!
    
    //Constants
    private let padding: CGFloat = 10.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    /// init
    /// Parameter frame: dimensiones de view contenedor
    /// Parameter accountData: cuenta a mostrar
    /// Parameter emptyView: para ocultar todos los componentes del View contenedor
    /// Parameter idxServie: index del servicio
    init(frame: CGRect, accountData : ServiceAccount, emptyView: Bool, idxService : Int) {
        super.init(frame: frame)
        if emptyView {
            self.initEmptyView()
            self.account = nil;
            self.idx = 0;
        }else {
            self.account = accountData;
            self.idx = idxService;
            self.initInterfaceView()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /// Iniciar los componentes visuales para la gráfica
    func initInterfaceView() {
        self.backgroundColor = institutionalColors.claroWhiteColor
        let imgDimension: CGFloat = 24.0

        overlay = UIView(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height));
        overlay.backgroundColor = institutionalColors.claroWhiteColor;

        lblCargando = BlackTitleLabel();
        lblCargando.backgroundColor = UIColor.clear;
        lblCargando.textColor = institutionalColors.claroBlackColor
        lblCargando.textAlignment = .center
        lblCargando.font = UIFont(name: RobotoFontName.RobotoRegular.rawValue, size: CGFloat(16.0))
        lblCargando.text = "Actualizando...";

        activity = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray);
        activity.startAnimating();
        overlay.addSubview(activity);
        overlay.addSubview(lblCargando)
        
        imgHeader = UIImageView(frame: CGRect(x: padding, y: 10.0, width: imgDimension, height: imgDimension))
        imgHeader.image = UIImage(named: "icon_detalle_24px")

        lblTitle = BlackTitleLabel()
        lblTitle.frame = CGRect(x: 0, y: 10.0, width: self.bounds.width, height: imgDimension)
        lblTitle.backgroundColor = UIColor.clear
        lblTitle.textColor = institutionalColors.claroTitleColor
        lblTitle.textAlignment = .center
        lblTitle.font = UIFont(name: RobotoFontName.RobotoRegular.rawValue, size: CGFloat(16.0))
        lblTitle.sizeToFit()

        vwLinea = UIView(frame: CGRect(x: 10, y: 10, width: 10, height: 10));
        vwLinea.backgroundColor = institutionalColors.claroRedColor;

        graphicArc = ArcProgressView()
        graphicArc.trackWidth = 20
        graphicArc.startPoint = 0
        graphicArc.fillPercentage = 0;
        graphicArc.frame = CGRect(x: 2 * padding, y: imgHeader.frame.maxY, width: self.bounds.width * 0.5 - padding * 2.0, height: 60.0)
        graphicArc.backgroundColor = UIColor.clear

        lblPorcentaje = BlackBodyLabel();
        lblPorcentaje.backgroundColor = UIColor.clear
        lblPorcentaje.textColor = institutionalColors.claroBlueColor
        lblPorcentaje.textAlignment = .center
        lblPorcentaje.font = UIFont(name: RobotoFontName.RobotoRegular.rawValue, size: CGFloat(18.0))

        lblDataDisponible = BlackBodyLabel()
        lblDataDisponible.frame = CGRect(x: graphicArc.frame.maxX + padding, y: imgHeader.frame.maxY, width: 150.0, height: 20.0)
        lblDataDisponible.textColor = institutionalColors.claroLightGrayColor
        lblDataDisponible.textAlignment = .center
        lblDataDisponible.font = UIFont(name: RobotoFontName.RobotoRegular.rawValue, size: CGFloat(14.0))
        
        lblDataMB = BlackTitleLabel()
        lblDataMB.frame = CGRect(x: lblDataDisponible.frame.minX, y: lblDataDisponible.frame.maxY + 10.0, width: lblDataDisponible.bounds.width, height: 20.0)
        lblDataMB.textColor = institutionalColors.claroBlackColor
        lblDataMB.textAlignment = .center
        lblDataMB.font = UIFont(name: RobotoFontName.RobotoMedium.rawValue, size: CGFloat(20.0))

        lblDate = BlackBodyLabel()
        lblDate.frame = CGRect(x: lblDataDisponible.frame.minX, y: lblDataMB.frame.maxY + 10.0, width: lblDataDisponible.bounds.width, height: 20.0)
        lblDate.textColor = institutionalColors.claroLightGrayColor
        lblDate.textAlignment = .center
        lblDate.font = UIFont(name: RobotoFontName.RobotoRegular.rawValue, size: CGFloat(14.0))

        lblLastUpdated = BlackBodyLabel();
        lblLastUpdated.frame = CGRect(x: lblDataDisponible.frame.minX, y: lblDate.frame.maxY + 10.0, width: lblDataDisponible.bounds.width, height: 20.0)
        lblLastUpdated.textColor = institutionalColors.claroLightGrayColor;
        lblLastUpdated.textAlignment = .left;
        lblLastUpdated.numberOfLines = 0;
        lblLastUpdated.font = UIFont(name: RobotoFontName.RobotoRegular.rawValue, size: CGFloat(14.0))

        lblDatosConsumidos = BlackBodyLabel();
        lblDatosConsumidos.textColor = institutionalColors.claroLightGrayColor;
        lblDatosConsumidos.textAlignment = .center;
        lblDatosConsumidos.font = UIFont(name: RobotoFontName.RobotoLight.rawValue, size: CGFloat(14.0))

        self.addSubview(imgHeader)
        self.addSubview(lblTitle)
        self.addSubview(vwLinea)
        self.addSubview(graphicArc)
        graphicArc.addSubview(lblPorcentaje)
        self.addSubview(lblDataDisponible)
        self.addSubview(lblDataMB)
        self.addSubview(lblDate)
        self.addSubview(lblLastUpdated)
        self.addSubview(lblDatosConsumidos)

        self.addSubview(overlay);
        self.bringSubview(toFront: overlay);

        UIView.animate(withDuration: 2) {
            self.activity.stopAnimating()
            self.overlay.isHidden = true;
        }

        constrain(self, overlay, activity, lblCargando) { (bkg, ov, act, carga) in
            ov.top == bkg.top
            ov.leading == bkg.leading
            ov.trailing == bkg.trailing
            ov.bottom == bkg.bottom

            act.center == bkg.center
            carga.top == act.bottom
            carga.leading == bkg.leading
            carga.trailing == bkg.trailing
        }

        constrain(self, imgHeader, lblTitle, vwLinea) { (bkg, img, lbl, linea) in
            lbl.centerX == bkg.centerX
            lbl.top == bkg.top + 32
            img.trailing == lbl.leading - 10
            img.top == bkg.top + 32
            img.centerY == lbl.centerY
            lbl.height == img.height
            linea.height == 2
            linea.top == lbl.bottom + 16
            linea.centerX == lbl.centerX
            linea.width == 100
        }

        constrain(self, vwLinea, graphicArc, lblDataDisponible, lblDatosConsumidos) { (bkg, linea, grafica, disponible, consumidos) in
            grafica.top == linea.bottom + 16
            grafica.leading >= bkg.leading + 10
            grafica.trailing <= disponible.leading - 20
            disponible.top == linea.bottom + 16
            grafica.centerX == bkg.centerX / 2
            consumidos.top == grafica.bottom + 5
            grafica.width == consumidos.width
            consumidos.centerX == grafica.centerX
        }

        constrain(self, lblDatosConsumidos, lblDataDisponible, lblDataMB, lblDate) { (bkg, consumidos, disponible, mb, vence) in
            disponible.leading == bkg.centerX
            //mb.leading == disponible.leading
            mb.leading == bkg.centerX
            //vence.leading == disponible.leading
            vence.leading == bkg.centerX
            consumidos.bottom == vence.bottom

            mb.top == disponible.bottom + 10
            mb.height == 25
            vence.top == mb.bottom + 10

        }

        constrain(self, graphicArc, lblPorcentaje) { (bkg, grafica, porcentaje) in
            porcentaje.centerX == grafica.centerX
            porcentaje.bottom == grafica.bottom
            porcentaje.leading == grafica.leading
            porcentaje.trailing == grafica.trailing
        }
        
        constrain(self, lblDate, lblLastUpdated) { (bkg, vence, upd) in
            vence.trailing == bkg.trailing - 10
            upd.top == vence.bottom + 2
            //upd.leading == vence.leading
            upd.leading == bkg.centerX 
            upd.trailing == vence.trailing
            
        }
        print("LBLLASTUPDATE \(lblLastUpdated.frame)")
        self.updateHeightView(newHeight: lblLastUpdated.frame.maxY + 100.0)
        
        self.setInformation()
    }
    /// Crear una vista vacía en caso de no existir información y mostrar un leyenda notificando al usuario
    func initEmptyView() {
        let frameWarning = CGRect(x: padding, y: 10.0, width: self.bounds.width - (padding * 4.0), height: 30.0)
        let warning = WarningView()
        warning.frame = frameWarning
        self.addSubview(warning)
        warning.setup()
        
        self.updateHeightView(newHeight: warning.frame.maxY + 10.0)
    }
    /// Actualizar la altura del view contenedor
    /// Parameter newHeight: nueva altura del view
    private func updateHeightView(newHeight: CGFloat) {
        let heightContentView = newHeight//heightContentView + newHeight
        print("HEIGHT GRAPHIC VIEW \(heightContentView)")
        self.frame = CGRect(x: padding, y: self.frame.origin.y, width: self.bounds.width - (padding * 2.0), height: heightContentView)
        
    }
    /// Obtener altura del view contenedor
    func getHeightGraphicView() -> CGFloat {
        return self.bounds.height
    }
    
    /// Obtener titulo amostrar
    /// return String: titulo a mostrar
    func getTitleByLOB() -> String {
        if self.account?.account?.lineOfBusiness == "2" {
            return SessionSingleton.sharedInstance.getGeneralConfig()?.translations?.data?.generales?.paidBeforePre ?? "Vence el:"
        }
        //return SessionSingleton.sharedInstance.getGeneralConfig()?.translations?.data?.generales?.paidBefore ?? "Antes del:"
        return SessionSingleton.sharedInstance.getGeneralConfig()?.translations?.data?.generales?.paidBeforePre ?? "Vence el:"
    }
    /// Establecer la información a mostrar
    func setInformation() {
        let currentData = self.account?.detailServices?.detailPlan?[safe: idx]?.retrieveConsumptionDetailInformation?.serviceUsage?.first(where: {$0.serviceType?.uppercased() == "INTERNET" });
        
        if let comsuptionMonth = SessionSingleton.sharedInstance.getGeneralConfig()?.translations?.data?.generales?.monthUse {
            lblTitle.text = comsuptionMonth
        } else {
            lblTitle.text = "Consumo del mes"
        }
        if let dataAvailable = SessionSingleton.sharedInstance.getGeneralConfig()?.translations?.data?.mobile?.internetAvailable {
            lblDataDisponible.text = dataAvailable
        } else {
          lblDataDisponible.text = "Datos disponibles"
        }
        //lblTitle.text = "Consumo del mes"
        //lblDataDisponible.text = "Datos disponibles"
        lblDataDisponible.textColor = institutionalColors.claroTextColor
        lblDataDisponible.adjustsFontSizeToFitWidth = true
        let myDateTmp = currentData?.serviceFeatureUsage?.first?.serviceUsagePeriod?.endDate ?? ""
        let myDate = convertStringToDate(stringDate: myDateTmp)
        let myDateString = getStringDate(date: myDate)
        
        /*if let paidBefore = SessionSingleton.sharedInstance.getGeneralConfig()?.translations?.data?.generales?.paidBefore {
            lblDate.text = String(format: "\(paidBefore):               %@", myDateString)
        } else {
            lblDate.text = String(format: "Vencimiento:               %@", myDateString)
        }*/
        
        lblDate.text = String(format: "%@ %@", getTitleByLOB(), myDateString)
        
        //lblDate.text = String(format: "Vencimiento:               %@", myDateString)
        lblDate.textColor = institutionalColors.claroTextColor
        
        lblDatosConsumidos?.text = SessionSingleton.sharedInstance.getGeneralConfig()?.translations?.data?.mobile?.internetUsed ?? "Datos consumidos"
        lblDatosConsumidos?.adjustsFontSizeToFitWidth = true;
        lblDatosConsumidos.textColor = institutionalColors.claroTextColor
        lblLastUpdated.textColor = institutionalColors.claroTextColor
        lblLastUpdated.text = String(format: "Última actualización:\n%@", getStringDateTime(date: SessionSingleton.sharedInstance.getLastRefreshDate() ?? Date()))
        let cantidad = Int(currentData?.serviceFeatureUsage?.first?.featureUsage?.quantity ?? 0.0) ?? 0
        let total = Int(currentData?.serviceFeatureUsage?.first?.serviceFeatureUsageLimit?.quantity ?? 0.0) ?? 0
        if -1 == total {
            lblPorcentaje.isHidden = true;
            lblDatosConsumidos.text = "ILIMITADO";
            lblDatosConsumidos.adjustsFontSizeToFitWidth = true
            lblDatosConsumidos.textColor = institutionalColors.claroTextColor
            lblDatosConsumidos.font = UIFont(name: RobotoFontName.RobotoBold.rawValue, size: CGFloat(20.0))
            lblDatosConsumidos.isHidden = false
            lblDataDisponible.text = SessionSingleton.sharedInstance.getGeneralConfig()?.translations?.data?.mobile?.internetUsed ?? "Datos consumidos"
            lblDataDisponible.textColor = institutionalColors.claroTextColor
            lblDataDisponible.adjustsFontSizeToFitWidth = true;
            //lblDate.isHidden = true;
            
            lblDataMB.text = String(format: "%@ %@",
                                    currentData?.serviceFeatureUsage?.first?.featureUsage?.quantity ?? "",
                                    currentData?.serviceFeatureUsage?.first?.featureUsage?.unit?.uppercased() ?? "")
            graphicArc.showGraph = false;
            if 0 != total {
                graphicArc.fillPercentage = 100.0 * CGFloat(cantidad) / CGFloat(total)
            } else {
                graphicArc.fillPercentage = 0.0;
            }
        } else if 0 == total {
            graphicArc.isHidden = false;
            graphicArc.showGraph = true;
            lblDate.isHidden = false;
            lblDatosConsumidos.isHidden = true;
            lblDataDisponible.text = SessionSingleton.sharedInstance.getGeneralConfig()?.translations?.data?.mobile?.internetUsed ?? "Datos consumidos"
            lblDataDisponible.textColor = institutionalColors.claroTextColor
            lblDataDisponible.adjustsFontSizeToFitWidth = true;
            
            lblDataMB.text = String(format: "%@ %@",
                                    String(format: "%d", cantidad),
                                    currentData?.serviceFeatureUsage?.first?.featureUsage?.unit?.uppercased() ?? "")
        } else if total > 0 {
            graphicArc.isHidden = false;
            graphicArc.showGraph = true;
            lblDatosConsumidos.isHidden = false;
            lblDate.isHidden = false;
            let myDateTmp = currentData?.serviceFeatureUsage?.first?.serviceUsagePeriod?.endDate ?? ""
            let myDate = convertStringToDate(stringDate: myDateTmp)
            let myDateString = getStringDate(date: myDate)
            /*
            if let paidBefore = SessionSingleton.sharedInstance.getGeneralConfig()?.translations?.data?.generales?.paidBefore {
                lblDate.text = String(format: "\(paidBefore):               %@", myDateString)
            } else {
                lblDate.text = String(format: "Vencimiento:               %@", myDateString)
            }*/
            lblDate.text = String(format: "%@ %@", getTitleByLOB(), myDateString)
            //lblDate.text = String(format: "Vencimiento:              %@", myDateString)
            lblDate.textColor = institutionalColors.claroTextColor
            let monto : Int = total - cantidad;
            lblDataMB.text = currentData?.serviceFeatureUsage?.first?.featureReminder?.unit?.uppercased() ?? ""
            lblDataMB.text = String(format: "%@ %@",
                                    String(format: "%d", monto),
                                    currentData?.serviceFeatureUsage?.first?.featureReminder?.unit?.uppercased() ?? "")

            if 0 != total {
                graphicArc.fillPercentage = 100.0 * CGFloat(cantidad) / CGFloat(total)
            } else {
                graphicArc.fillPercentage = 0.0;
            }
            lblPorcentaje.text = String(format: "%2.2f", graphicArc.fillPercentage / 100)
        }
        lblPorcentaje.text = String(format: "%d %%", Int(graphicArc.fillPercentage));
        
        lblDate.textAlignment = .left
        lblLastUpdated.textAlignment = .left
        
        constrain(lblDate, lblLastUpdated) { (vence, upd) in
            vence.height == lblDate.needAdjustLabel().newHeight
            //upd.height == lblLastUpdated.needAdjustLabel().newHeight
        }
        //lblDate.adjustHeighToFit()
        //lblLastUpdated.adjustHeighToFit()
        //self.updateHeightView(newHeight: lblLastUpdated.frame.maxY + 100.0)
    }
    
    //MARK: Activity indicator
    /// iniciar loader de carga
    func startActivity() {
        let activityDimension: CGFloat = 30.0
        self.backgroundColor = institutionalColors.claroLightGrayColor.withAlphaComponent(0.4)
        self.activity = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        self.activity.frame = CGRect(x: self.bounds.width / 2 - (activityDimension / 2), y: self.bounds.height / 2 - (activityDimension / 2), width: activityDimension, height: activityDimension)
        
        self.addSubview(self.activity)
        self.activity.startAnimating()
    }
    /// Detener loader de carga
    func stopActivity() {
        if (self.activity != nil) {
            self.activity.stopAnimating()
            self.activity.removeFromSuperview()
        }
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
