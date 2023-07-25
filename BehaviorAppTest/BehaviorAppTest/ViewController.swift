import UIKit
import CSBehavior

class ViewController: UIViewController, UITextFieldDelegate {

    var locationManager: CLLocationManager!
    var csbehavior: CSBehavior!
    //Outlets
    @IBOutlet weak var txtSessionId: UITextField!
    @IBOutlet var lbResultStatus: UILabel!
    @IBOutlet var lbGeoresult: UILabel!
    
    
    //Actions
    @IBAction func btnCollect(_ sender: UIButton) {
        if (txtSessionId.text == "") {
            let newSessionId = csbehavior.generateSessionId();
            lbResultStatus.text = NSString(format: "Enviado dados:\n App: %@\n Sessão gerada: %@", csbehavior.app!, newSessionId!) as String;
            print(lbResultStatus.text);
            csbehavior.collectDeviceInformation(newSessionId);
          
                
            
            lbResultStatus.numberOfLines = 5;
            lbResultStatus.lineBreakMode = NSLineBreakMode.byWordWrapping
        } else {
            csbehavior.collectDeviceInformation(txtSessionId.text);
            
            lbResultStatus.text = NSString(format: "Enviado dados:\n App: %@\n Sessão: %@", csbehavior.app!, txtSessionId.text!) as String
            lbResultStatus.numberOfLines = 5;
            lbResultStatus.lineBreakMode = NSLineBreakMode.byWordWrapping
        }
        txtSessionId.text = "";
    }
    
    @IBAction func btnGeoLocation(_ sender: Any) {
        if (CLLocationManager.locationServicesEnabled()) {
            
            locationManager = CLLocationManager();
            
            let status: CLAuthorizationStatus = CLLocationManager.authorizationStatus();
                        
            switch (status) {
            case CLAuthorizationStatus.authorizedAlways:
                locationManager.requestLocation();
                break;
            case CLAuthorizationStatus.authorizedWhenInUse:
                locationManager.requestWhenInUseAuthorization();
                break;
            default:
                locationManager.requestWhenInUseAuthorization();
                break;
            }
            
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let location = locations.last! as CLLocation

        lbGeoresult.numberOfLines = 6;
        lbGeoresult.text = String(format: "Latitude: %f\n Longitude: %f\n Altitude: %f, HAccur: %f, VAccur: %f, Floor: %d"
            , (location.coordinate.latitude)
            , (location.coordinate.longitude)
            , location.altitude
            , location.horizontalAccuracy
            , location.verticalAccuracy
            , location.floor?.level ?? "unknwon");
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.txtSessionId.delegate = self;
    }

    override func viewDidAppear(_ animated: Bool) {
        csbehavior = CSBehavior.getInstance("APP_KEY");
    }
    
    

}

