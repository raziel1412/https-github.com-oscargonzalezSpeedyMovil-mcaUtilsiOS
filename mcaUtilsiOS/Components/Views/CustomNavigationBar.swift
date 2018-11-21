//
//  CustomNavigationBar.swift
//  MiClaro
//
//  Created by Mauricio Javier Perez Flores on 26/07/17.
//  Copyright © 2017 am. All rights reserved.
//
import UIKit
import Cartography

/// Esta clase permite realizar customizaciones del Navigation Bar a partir de los parámetros proporcionados en el constructor

extension UIViewController  {
/*
/// Tipo de NavigationBar
    enum navType {
        case login
        case register
        case onlinePayment
        case reloadBalance
        case terms
        case home
        case recoveryPassword
        case addPrePaid
        case addPrePaidCode
        case support
        case editPerfil
        case supportLogged
        case supportNoLogged
        case supportSectionReportError
        case supportSectionSuggestion
        case supportSectionSendEmail
        case supportSectionAboutme
        case menuBoleta
        case boleta
        case sendTicket
        case supportSectionCenterAttention
        case serviceAccount
        case requestChangePlan
        case successChangePlan
        case hiring
        case hiringWeb
        case digitalBorn
        case completeRegister
        case sucursalVirtual
        case centrosAyuda
        case servicioTecnico
        case citasCAC
        case citasAgendCAC
        case horasCAC
        case packages
        case packagesDetail
    }
    struct GlobalStruct {
        static var strNavType = ""
    }

    /// El constructor permite customizar el NavigationBar dependiendo del valor de navigationType
    /// -param:
    ///     - navigationType : enum navType
    func initWith(navigationType: navType, backToMain: Bool = false) {
        
        GlobalStruct.strNavType = ""
        
        let logoId = -1;
        let fuente = UIFont(name: RobotoFontName.RobotoMedium.rawValue, size: CGFloat(18));
        let conf = SessionSingleton.sharedInstance.getGeneralConfig();
        let backArrow = UIImage(named: "ico_back");
        
        var titleCentrosA = ""
        var titleSucursal = ""
        
        if let optionsSupport = SessionSingleton.sharedInstance.getGeneralConfig()?.helpOnlineDynamicOptions?.options{
            
//            optionsSupport.sort(by: {Int($0.orderOption ?? "0")! < Int($1.orderOption ?? "0")!})
            for options in optionsSupport{
                if options.codeOption == "helpCenter"{
                    titleCentrosA = options.nameOption ?? "Centros de Ayuda"
                }
                if options.codeOption == "sucVirtual"{
                    titleSucursal = options.nameOption ?? "Sucursal Virtual"
                }
            }
        }
        
        switch navigationType {
        case .login:
            self.navigationController?.setNavigationBarHidden(true, animated: true)
            if (nil == self.navigationController?.view.viewWithTag(logoId)) {
                //self.navigationController?.view.addSubview(imageview)
            }
            break;

        case .register:
            setupGenericNavigationBar(conf?.translations?.data?.registro?.header ?? "")
            if backToMain {
                setupGenericNavigationBar(conf?.translations?.data?.registro?.header ?? "", action: #selector(goBackFromLateralMenu))
            }

            break
            
        case .home:
            break;

        case .onlinePayment:
            let customView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 32, height: 44.0))
            let button = UIButton.init(type: .custom)
            button.setBackgroundImage(backArrow, for: .normal)
            button.addTarget(self, action: #selector(goBackFromLateralMenu), for: .touchUpInside)
            button.frame = CGRect(x: 0.0, y: 5.0, width: 32.0, height: 32.0)
            customView.addSubview(button)
            let marginX = CGFloat(button.frame.origin.x + button.frame.size.width + 20)
            let label = UILabel()
            label.text = conf?.translations?.data?.billingPayment?.header
            label.textColor = institutionalColors.claroRedColor
            label.textAlignment = NSTextAlignment.left
            label.frame = CGRect(x: marginX, y: 0.0, width: self.view.frame.width - marginX, height: 0.35 * 44)
            label.font = fuente;
            label.backgroundColor = UIColor.clear
            self.navigationItem.titleView = label

            let leftButton = UIBarButtonItem(customView: customView)
            self.navigationItem.leftBarButtonItem = leftButton

            let iconImage = UIImageView(image: UIImage(named: "ico_logo"))
            iconImage.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width * 0.144, height: 44.0)
            iconImage.contentMode = .scaleAspectFit
            iconImage.clipsToBounds = true

            let rightButton = UIBarButtonItem(customView: iconImage)
            self.navigationItem.rightBarButtonItem = rightButton
            break;

        case .reloadBalance:
            let customView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 32, height: 44.0))
            let button = UIButton.init(type: .custom)
            button.setBackgroundImage(backArrow, for: .normal)
            button.addTarget(self, action: #selector(goBackFromLateralMenu), for: .touchUpInside)
            button.frame = CGRect(x: 0.0, y: 5.0, width: 32.0, height: 32.0)
            customView.addSubview(button)
            let marginX = CGFloat(button.frame.origin.x + button.frame.size.width + 20)
            let label = UILabel(frame: CGRect(x: marginX, y: 0.0, width: 300, height: 44.0))
            label.text = NSLocalizedString("reloadBalance", comment: "")
            label.textColor = institutionalColors.claroRedColor
            label.textAlignment = NSTextAlignment.left
            label.font = fuente;
            label.backgroundColor = UIColor.clear
            label.frame = CGRect(x: button.frame.maxX, y: 0.0, width: self.view.frame.width - button.frame.maxX, height: 0.35 * 44)
            self.navigationItem.titleView = label
            let leftButton = UIBarButtonItem(customView: customView)
            self.navigationItem.leftBarButtonItem = leftButton
            
            let iconImage = UIImageView(image: UIImage(named: "ico_logo"))
            iconImage.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width * 0.144, height: 44.0)
            iconImage.contentMode = .scaleAspectFit
            iconImage.clipsToBounds = true

            let rightButton = UIBarButtonItem(customView: iconImage)
            self.navigationItem.rightBarButtonItem = rightButton
            break;

        case .terms:
            GlobalStruct.strNavType = "T&C"
            if backToMain == true {
                setupGenericNavigationBar(conf?.translations?.data?.generales?.termsAndConditions ?? "", action: #selector(goBackFromLateralMenu))
            } else {
                setupGenericNavigationBar(conf?.translations?.data?.generales?.termsAndConditions ?? "")
                AnalyticsInteractionSingleton.sharedInstance.ADBTrackCustomLink(viewName: "Recuperar contrasena|Terminos y condiciones:Cerrar")//NO
            }
            break
            
        case .recoveryPassword:
            setupGenericNavigationBar(conf?.translations?.data?.passwordRecovery?.header ?? "")
            break
            
        case .addPrePaid:
            setupGenericNavigationBar(conf?.translations?.data?.addService?.header ?? "", action: #selector(goBackFromLateralMenu))
            break
            
        case .addPrePaidCode:
            setupGenericNavigationBar(conf?.translations?.data?.addService?.header ?? "")
            break
            
        case .support:
            let attributes = [NSFontAttributeName: UIFont.fontAwesome(ofSize: 20),
                              NSForegroundColorAttributeName : institutionalColors.claroRedColor] as [String: Any]
            let menuButton = UIBarButtonItem();
            menuButton.style = .plain;
            menuButton.setTitleTextAttributes(attributes, for: .normal)
            menuButton.setTitleTextAttributes(attributes, for: .selected)
            menuButton.image = UIImage(named: "ico_")
            menuButton.target = self;
            menuButton.action = #selector(self.openMenu);
            self.navigationItem.setLeftBarButton(menuButton, animated: true);
            
            let marginX = CGFloat(32 + 20)
            
            let label = UILabel(frame: CGRect(x: marginX, y: 12.0, width: 180.0, height: 21))
            label.text = conf?.translations?.data?.help?.header
            label.textColor = institutionalColors.claroRedColor
            label.textAlignment = NSTextAlignment.left
            label.font = fuente;
            label.backgroundColor = UIColor.clear
            label.frame = CGRect(x: 0, y: 0.0, width: self.view.frame.width - 40 * 2, height: 0.35 * 44)
            self.navigationItem.titleView = label

            self.navigationController?.setNavigationBarHidden(false, animated: true)
            if let bkg = self.navigationController?.view.viewWithTag(logoId){
                bkg.removeFromSuperview();
            }
            break;

        case .hiring:
            let attributes = [NSFontAttributeName: UIFont.fontAwesome(ofSize: 20),
                              NSForegroundColorAttributeName : institutionalColors.claroRedColor] as [String: Any]
            let menuButton = UIBarButtonItem();
            menuButton.style = .plain;
            menuButton.setTitleTextAttributes(attributes, for: .normal)
            menuButton.setTitleTextAttributes(attributes, for: .selected)
            menuButton.image = UIImage(named: "ico_hamburger");
            menuButton.tintColor = institutionalColors.claroRedColor;
            menuButton.target = self;
            menuButton.action = #selector(openMenu);
            self.navigationItem.setLeftBarButton(menuButton, animated: true);
            
            let label = UILabel();
            label.text = SessionSingleton.sharedInstance.getGeneralConfig()?.translations?.data?.click2BuyTexts?.click2BuyHeader ?? ""
            label.textColor = institutionalColors.claroRedColor
            label.textAlignment = NSTextAlignment.left
            label.font = fuente;
            label.backgroundColor = UIColor.clear
            label.frame = CGRect(x: 0, y: 0.0, width: self.view.frame.width - 40 * 2, height: 0.35 * 44)
            self.navigationItem.titleView = label
            
            let iconImage = UIImageView(image: UIImage(named: "ico_logo"))
            iconImage.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width * 0.144, height: 44.0)
            iconImage.contentMode = .scaleAspectFit
            iconImage.clipsToBounds = true
            let rightButton = UIBarButtonItem(customView: iconImage)
            self.navigationItem.rightBarButtonItem = rightButton
            break;
            
        case .hiringWeb:
            setupGenericNavigationBar( SessionSingleton.sharedInstance.getGeneralConfig()?.translations?.data?.click2BuyTexts?.click2BuyHeader ?? "", action: #selector(goBackFromLateralMenu))

        case .menuBoleta:
            let attributes = [NSFontAttributeName: UIFont.fontAwesome(ofSize: 20),
                              NSForegroundColorAttributeName : institutionalColors.claroRedColor] as [String: Any]
            let menuButton = UIBarButtonItem();
            menuButton.style = .plain;
            menuButton.setTitleTextAttributes(attributes, for: .normal)
            menuButton.setTitleTextAttributes(attributes, for: .selected)
            menuButton.image = UIImage(named: "ico_hamburger");
            menuButton.tintColor = institutionalColors.claroRedColor;
            menuButton.target = self;
            menuButton.action = #selector(openMenu);
            self.navigationItem.setLeftBarButton(menuButton, animated: true);
            
            let label = UILabel();
            label.text = conf?.translations?.data?.billing?.header ?? ""
            label.textColor = institutionalColors.claroRedColor
            label.textAlignment = NSTextAlignment.left
            label.font = fuente;
            label.backgroundColor = UIColor.clear
            label.frame = CGRect(x: 0, y: 0.0, width: self.view.frame.width - 40 * 2, height: 0.35 * 44)
            self.navigationItem.titleView = label
            
            let iconImage = UIImageView(image: UIImage(named: "ico_logo"))
            iconImage.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width * 0.144, height: 44.0)
            iconImage.contentMode = .scaleAspectFit
            iconImage.clipsToBounds = true
            let rightButton = UIBarButtonItem(customView: iconImage)
            self.navigationItem.rightBarButtonItem = rightButton
            break;
            
        case .boleta:
            setupGenericNavigationBar(conf?.translations?.data?.billing?.header ?? "", action: #selector(goBackToRoot))
            break;
            
        case .serviceAccount:
            let attributes = [NSFontAttributeName: UIFont.fontAwesome(ofSize: 20),
                              NSForegroundColorAttributeName : institutionalColors.claroRedColor] as [String: Any]
            let menuButton = UIBarButtonItem();
            menuButton.style = .plain;
            menuButton.setTitleTextAttributes(attributes, for: .normal)
            menuButton.setTitleTextAttributes(attributes, for: .selected)
            menuButton.image = UIImage(named: "ico_hamburger");
            menuButton.tintColor = institutionalColors.claroRedColor;
            menuButton.target = self;
            menuButton.action = #selector(openMenu);
            self.navigationItem.setLeftBarButton(menuButton, animated: true);
            
            let label = UILabel();
            label.text = conf?.translations?.data?.generales?.myService ?? ""
            label.textColor = institutionalColors.claroRedColor
            label.textAlignment = NSTextAlignment.left
            label.font = fuente;
            label.backgroundColor = UIColor.clear
            label.frame = CGRect(x: 0, y: 0.0, width: self.view.frame.width - 40 * 2, height: 0.35 * 44)
            self.navigationItem.titleView = label
            
            let iconImage = UIImageView(image: UIImage(named: "ico_logo"))
            iconImage.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width * 0.144, height: 44.0)
            iconImage.contentMode = .scaleAspectFit
            iconImage.clipsToBounds = true
            let rightButton = UIBarButtonItem(customView: iconImage)
            self.navigationItem.rightBarButtonItem = rightButton
            break;

        case .sendTicket:
            setupGenericNavigationBar(conf?.translations?.data?.billing?.header ?? "");
            break;

        case .editPerfil:
            let attributes = [NSFontAttributeName: UIFont.fontAwesome(ofSize: 20),
             NSForegroundColorAttributeName : institutionalColors.claroRedColor] as [String: Any]
             let menuButton = UIBarButtonItem();
             menuButton.style = .plain;
             menuButton.setTitleTextAttributes(attributes, for: .normal)
             menuButton.setTitleTextAttributes(attributes, for: .selected)
             menuButton.image = UIImage(named: "ico_hamburger");
             menuButton.tintColor = institutionalColors.claroRedColor;
             menuButton.target = self;
             menuButton.action = #selector(openMenu);
             self.navigationItem.setLeftBarButton(menuButton, animated: true);
             
             let label = UILabel();
             label.text = conf?.translations?.data?.profile?.header ?? ""
             label.textColor = institutionalColors.claroRedColor
             label.textAlignment = NSTextAlignment.left
             label.font = fuente;
             label.backgroundColor = UIColor.clear
             label.frame = CGRect(x: 0, y: 0.0, width: self.view.frame.width - 40 * 2, height: 0.35 * 44)
             self.navigationItem.titleView = label
             
             let iconImage = UIImageView(image: UIImage(named: "ico_logo"))
             iconImage.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width * 0.144, height: 44.0)
             iconImage.contentMode = .scaleAspectFit
             iconImage.clipsToBounds = true
             let rightButton = UIBarButtonItem(customView: iconImage)
             self.navigationItem.rightBarButtonItem = rightButton
            break;
            
        case .digitalBorn:
            let attributes = [NSFontAttributeName: UIFont.fontAwesome(ofSize: 20),
                              NSForegroundColorAttributeName : institutionalColors.claroRedColor] as [String: Any]
            let menuButton = UIBarButtonItem();
            menuButton.style = .plain;
            menuButton.setTitleTextAttributes(attributes, for: .normal)
            menuButton.setTitleTextAttributes(attributes, for: .selected)
            menuButton.image = UIImage(named: "ico_hamburger");
            menuButton.tintColor = institutionalColors.claroRedColor;
            menuButton.target = self;
//            menuButton.action = #selector(openMenu);
//            menuButton.isEnabled = false
            self.navigationItem.setLeftBarButton(menuButton, animated: true);
            
            let label = UILabel();
            label.text = conf?.translations?.data?.profile?.header ?? ""
            label.textColor = institutionalColors.claroRedColor
            label.textAlignment = NSTextAlignment.left
            label.font = fuente;
            label.backgroundColor = UIColor.clear
            label.frame = CGRect(x: 0, y: 0.0, width: self.view.frame.width - 40 * 2, height: 0.35 * 44)
            self.navigationItem.titleView = label
            
            let iconImage = UIImageView(image: UIImage(named: "ico_logo"))
            iconImage.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width * 0.144, height: 44.0)
            iconImage.contentMode = .scaleAspectFit
            iconImage.clipsToBounds = true
            let rightButton = UIBarButtonItem(customView: iconImage)
            self.navigationItem.rightBarButtonItem = rightButton
            break;
            
        case .completeRegister:
            let menuButton = UIBarButtonItem();
            menuButton.style = .plain;
            menuButton.image = UIImage(named: "ico_back");
            menuButton.tintColor = institutionalColors.claroRedColor;
            menuButton.target = self;
            menuButton.action = #selector(regresar);
            self.navigationItem.setLeftBarButton(menuButton, animated: true);
            
            let label = UILabel();
            label.text = conf?.translations?.data?.profile?.header ?? ""
            label.textColor = institutionalColors.claroRedColor
            label.textAlignment = NSTextAlignment.left
            label.font = fuente;
            label.backgroundColor = UIColor.clear
            label.frame = CGRect(x: 0, y: 0.0, width: self.view.frame.width - 40 * 2, height: 0.35 * 44)
            self.navigationItem.titleView = label
            
            let iconImage = UIImageView(image: UIImage(named: "ico_logo"))
            iconImage.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width * 0.144, height: 44.0)
            iconImage.contentMode = .scaleAspectFit
            iconImage.clipsToBounds = true
            let rightButton = UIBarButtonItem(customView: iconImage)
            self.navigationItem.rightBarButtonItem = rightButton
            break;
            
        case .supportLogged:
            /*let user = SessionSingleton.sharedInstance.getCurrentSession()
            let nameUser = String(format: "%@ %@", SessionSingleton.sharedInstance.getGeneralConfig()?.translations?.data?.generales?.commonHeader ?? "",
                                  user?.retrieveProfileInformationResponse?.personalDetailsInformation?.accountUserFirstName ?? "");*/
            let headerTitle = conf?.translations?.data?.help?.title ?? "Soporte"

            let attributes = [NSFontAttributeName: UIFont.fontAwesome(ofSize: 20),
                              NSForegroundColorAttributeName : institutionalColors.claroRedColor] as [String: Any]
            let menuButton = UIBarButtonItem();
            menuButton.style = .plain;
            menuButton.setTitleTextAttributes(attributes, for: .normal)
            menuButton.setTitleTextAttributes(attributes, for: .selected)
            menuButton.image = UIImage(named: "ico_hamburger");
            menuButton.target = self;
            menuButton.action = #selector(openMenu);
            menuButton.tintColor = institutionalColors.claroRedColor;
            self.navigationItem.setLeftBarButton(menuButton, animated: true);
            
            let ancho = CGFloat(44.0);
            let imgMiClaro = UIImage(named: "ico_logo");
            let vwClaro = UIImageView(image: imgMiClaro);
            vwClaro.frame = CGRect(x: 0, y: 0, width: ancho, height: ancho);
            vwClaro.contentMode = .scaleAspectFit;
            if #available(iOS 9.0, *) {
                vwClaro.widthAnchor.constraint(equalToConstant: ancho).isActive = true
                vwClaro.heightAnchor.constraint(equalToConstant: ancho).isActive = true;
            };
            let menuClaro = UIBarButtonItem(customView: vwClaro);
            self.navigationItem.setRightBarButton(menuClaro, animated: true);
            let label = UILabel();
            label.text = headerTitle
            label.textColor = institutionalColors.claroRedColor
            label.textAlignment = NSTextAlignment.left
            label.font = fuente;
            label.backgroundColor = UIColor.clear
            label.frame = CGRect(x: 0, y: 0.0, width: self.view.frame.width - 40 * 2, height: 0.35 * 44)
            self.navigationItem.titleView = label

            self.navigationController?.setNavigationBarHidden(false, animated: true)
            if let bkg = self.navigationController?.view.viewWithTag(logoId){
                bkg.removeFromSuperview();
            }
            break
            
        case .supportNoLogged:
            setupGenericNavigationBar(conf?.translations?.data?.help?.title ?? "Soporte")
            break
            
        case .supportSectionReportError:
            //let headerTitle = conf?.translations?.data?.help?.reportBugHeader ?? ""
            //self.navigationBarSendEmail(headerTitle: headerTitle, hiddeBtnRight: false)
            setupGenericNavigationBar(conf?.translations?.data?.help?.reportBug ?? "")
            break
        case .supportSectionSuggestion:
            //let headerTitle = conf?.translations?.data?.help?.suggestionsHeader ?? ""
            //self.navigationBarSendEmail(headerTitle: headerTitle, hiddeBtnRight: false)
            setupGenericNavigationBar(conf?.translations?.data?.help?.suggestions ?? "")
            break
        case .supportSectionSendEmail:
            //let headerTitle = conf?.translations?.data?.help?.emailHeader ?? ""
            //self.navigationBarSendEmail(headerTitle: headerTitle, hiddeBtnRight: false)
            setupGenericNavigationBar(conf?.translations?.data?.help?.header ?? "")
            break
        case .supportSectionAboutme:
            //let headerTitle = conf?.translations?.data?.help?.about ?? ""
            //self.navigationBarSendEmail(headerTitle: conf?.translations?.data?.help?.header ?? "", hiddeBtnRight: true)
            setupGenericNavigationBar(conf?.translations?.data?.help?.about ?? "")
            break
        case .sucursalVirtual:
            //let headerTitle = conf?.translations?.data?.help?.about ?? ""
            //self.navigationBarSendEmail(headerTitle: conf?.translations?.data?.help?.header ?? "", hiddeBtnRight: true)
            setupGenericNavigationBar(titleSucursal)
            break
        case .centrosAyuda:
            setupGenericNavigationBar(titleCentrosA)
            break
        case .servicioTecnico:
            setupGenericNavigationBar(conf?.webViews?[0].descriptionField ?? "Servicio Técnico", action: #selector(goBackFromLateralMenu))
            
        case .citasCAC:
            setupGenericNavigationBar((conf?.translations?.data?.cacDatesTexts?.cacDatesViewDatesHeader ?? "Ver Citas Agendadas"), action: #selector(goBackFromLateralMenu))
        case .citasAgendCAC:
            setupGenericNavigationBar("Agendar Citas", action: #selector(goBackFromLateralMenu))
        case .horasCAC:
            setupGenericNavigationBar((conf?.translations?.data?.cacDatesTexts?.cacDatesHeader ?? "Agendar Hora"), action: #selector(goBackFromLateralMenu))
            
        case .supportSectionCenterAttention:
            //let headerTitle = conf?.translations?.data?.help?.cacHeader ?? ""
            //self.navigationBarSendEmail(headerTitle: headerTitle, hiddeBtnRight: true)
            setupGenericNavigationBar(conf?.translations?.data?.help?.cacHeader ?? "")
            break
        case .requestChangePlan, .successChangePlan:
            let customView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 32, height: 44.0))
            let button = UIButton.init(type: .custom)
            button.setBackgroundImage(backArrow, for: .normal)
            button.addTarget(self, action: #selector(goBackFromLateralMenu), for: .touchUpInside)
            button.frame = CGRect(x: 0.0, y: 5.0, width: 32.0, height: 32.0)
            customView.addSubview(button)
            let marginX = CGFloat(button.frame.origin.x + button.frame.size.width + 20)
            let label = UILabel()
            label.text = conf?.translations?.data?.updatePlan?.updatePlanHeader ?? ""
            label.textColor = institutionalColors.claroRedColor
            label.textAlignment = NSTextAlignment.left
            label.frame = CGRect(x: marginX, y: 0.0, width: self.view.frame.width - marginX, height: 0.35 * 44)
            label.font = fuente;
            label.backgroundColor = UIColor.clear
            self.navigationItem.titleView = label

            let leftButton = UIBarButtonItem(customView: customView)
            self.navigationItem.leftBarButtonItem = leftButton

            let iconImage = UIImageView(image: UIImage(named: "ico_logo"))
            iconImage.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width * 0.144, height: 44.0)
            iconImage.contentMode = .scaleAspectFit
            iconImage.clipsToBounds = true

            let rightButton = UIBarButtonItem(customView: iconImage)
            self.navigationItem.rightBarButtonItem = rightButton
            break;
        case .packages:
            let attributes = [NSFontAttributeName: UIFont.fontAwesome(ofSize: 20),
                              NSForegroundColorAttributeName : institutionalColors.claroRedColor] as [String: Any]
            let menuButton = UIBarButtonItem();
            menuButton.style = .plain;
            menuButton.setTitleTextAttributes(attributes, for: .normal)
            menuButton.setTitleTextAttributes(attributes, for: .selected)
            menuButton.image = UIImage(named: "ico_hamburger");
            menuButton.tintColor = institutionalColors.claroRedColor;
            menuButton.target = self;
            menuButton.action = #selector(openMenu);
            self.navigationItem.setLeftBarButton(menuButton, animated: true);
            
            let label = UILabel();
            label.text = conf?.translations?.data?.buyBagsTexts?.buyBagsHeader ?? "Comprar Bolsas"
            label.textColor = institutionalColors.claroRedColor
            label.textAlignment = NSTextAlignment.left
            label.font = fuente;
            label.backgroundColor = UIColor.clear
            label.frame = CGRect(x: 0, y: 0.0, width: self.view.frame.width - 40 * 2, height: 0.35 * 44)
            self.navigationItem.titleView = label
            
            let iconImage = UIImageView(image: UIImage(named: "ico_logo"))
            iconImage.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width * 0.144, height: 44.0)
            iconImage.contentMode = .scaleAspectFit
            iconImage.clipsToBounds = true
            let rightButton = UIBarButtonItem(customView: iconImage)
            self.navigationItem.rightBarButtonItem = rightButton
            break;
        case .packagesDetail:
            setupGenericNavigationBar(conf?.translations?.data?.buyBagsTexts?.buyBagsHeader ?? "Comprar Bolsas" ?? "", action: #selector(goBack(_sender:)))
        }
        

    }
    
    //begins
    
    func goBackFromLateralMenu() {
        if(GlobalStruct.strNavType == "T&C"){
            AnalyticsInteractionSingleton.sharedInstance.ADBTrackCustomLink(viewName: "Terminos y condiciones:Regresar")
        }
        if let _ = SessionSingleton.sharedInstance.getCurrentSession() {
            let total = self.navigationController?.viewControllers.count ?? 0
            if total > 1 {
                self.navigationController?.popViewController(animated: true)
            } else {
                UIApplication.shared.keyWindow?.rootViewController  = ContainerVC();
            }
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }

    func goBackToRoot(){
        UIApplication.shared.keyWindow?.rootViewController  = ContainerVC();

    }
    func goToEditProfile(perfilVC: UIViewController){
        self.navigationController?.pushViewController(perfilVC, animated: true)
    }
    
    func goBack(_sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    func rightButtonAction(_sender: UIButton) {
        if self.isKind(of: SupportSectionsVC.superclass()!) {
            let vc = self as! SupportSectionsVC
            vc.sendEmailAction()
        }
    }

    //MARK: Navigation bar for support
    func navigationBarSendEmail(headerTitle: String, hiddeBtnRight: Bool) {
        let fuente = UIFont(name: RobotoFontName.RobotoRegular.rawValue, size: CGFloat(18))
        
        let label = UILabel()
        label.font = fuente
        label.textColor = institutionalColors.claroBlackColor
        label.text = headerTitle
        label.textAlignment = .center
        label.sizeToFit()
        self.navigationItem.titleView = label
        label.frame = CGRect(x: 20.0, y: 10.0, width: 200, height: 18.0)
        
        let backArrow = UIImage(named: "ico_back")?.withRenderingMode(.alwaysOriginal)
        
        //Create left button
        let lefButton = UIBarButtonItem(image: backArrow, style: .plain, target: self, action: #selector(self.goBack(_sender:)))
        self.navigationItem.leftBarButtonItem = lefButton
        
        //Create right button
        if !hiddeBtnRight {
            let imgSendEmail = UIImage(named: "ic_enviar_24px")?.withRenderingMode(.alwaysOriginal)
            let rightButton = UIBarButtonItem(image: imgSendEmail, style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.rightButtonAction(_sender:)));
            self.navigationItem.rightBarButtonItem = rightButton
        }
    }

    func openMenu() {
        AnalyticsInteractionSingleton.sharedInstance.ADBTrackCustomLink(viewName: "General:Menu")
        if let container = self.so_containerViewController {
            self.view.endEditing(true);
            container.isSideViewControllerPresented = true
             AnalyticsInteractionSingleton.sharedInstance.ADBTrackView(viewName: "Menu", detenido: false)
        }
        NotificationCenter.default.post(name: Notification.Name("refreshTipoPago"), object: nil);
    }
    
    func regresar()
    {
        self.navigationController?.pushViewController(LoginVC(), animated: true)
    }
    
    //ends

    private func setupGenericNavigationBar(_ headerTitle: String, action: Selector = #selector(goBack)) {
        let logoId = -1;
        var backArrow = UIImage(named: "ico_back");
        let iconImage = UIImageView(image: UIImage(named: "ico_logo"))
        iconImage.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width * 0.144, height: 44.0)
        iconImage.contentMode = .scaleAspectFit
        iconImage.clipsToBounds = true
        
        let customView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 24.0, height: 44.0))
        let rightButton = UIBarButtonItem(customView: iconImage)
        let leftButton = UIBarButtonItem(customView: customView)
        let button = UIButton.init(type: .custom)
        backArrow = UIImage(named: "ico_back")
        button.setBackgroundImage(backArrow, for: .normal)
        button.addTarget(self, action: action, for: .touchUpInside)
        button.frame = CGRect(x: customView.frame.size.width * 0.053, y: 0, width: 24.0, height: 24.0)
        button.center.y = customView.center.y
        customView.addSubview(button)
        let marginX = CGFloat(button.frame.maxX + 16.0)
        let label = UILabel(frame: CGRect(x: marginX, y: 0.0, width: self.view.frame.width - marginX, height: 0.35 * 44))
        label.text = headerTitle
        label.textColor = institutionalColors.claroRedColor
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont.init(name: RobotoFontName.RobotoMedium.rawValue, size: 18.0);
        label.backgroundColor = UIColor.clear
        label.adjustsFontSizeToFitWidth = true
        label.sizeToFit()
        leftButton.tintColor = institutionalColors.claroRedColor
        let leftTitle = UIBarButtonItem(customView: label)
        self.navigationItem.leftBarButtonItems = [leftButton, leftTitle]
        self.navigationItem.rightBarButtonItem = rightButton
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        if let bkg = self.navigationController?.view.viewWithTag(logoId){
            bkg.removeFromSuperview();
        }
        self.navigationController?.navigationBar.barTintColor = institutionalColors.claroPlecaColor
        self.navigationController?.navigationBar.tintColor = institutionalColors.claroRedColor
    }
    
    /// Get distance from top, based on status bar and navigation
    public var topDistance : CGFloat{
        get{
            if self.navigationController == nil{
                return 0
            }else{
                let barHeight=self.navigationController?.navigationBar.frame.height ?? 0
                let statusBarHeight = UIApplication.shared.isStatusBarHidden ? CGFloat(0) : UIApplication.shared.statusBarFrame.height
                return barHeight + statusBarHeight
            }
        }
    }
    */
    func indexSelected(selected:Int) {
        print("selected at extension: ()")
    }

}

