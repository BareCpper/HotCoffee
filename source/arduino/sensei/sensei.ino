/* TODO ADS1115:
* https://wolles-elektronikkiste.de/en/ads1115-a-d-converter-with-amplifier (English)

*  Test WEB BLE UART @ https://makerdiary.github.io/web-device-cli
*/
#include <Wire.h>
#include <algorithm>

#include "adsservice.h"
#include "bleservice.h"

AdsService adsService;
BleService bleService;

class Application : public sub0::PublishAll<Setup, Update>
{
  public:
    void setup()
    {
      Serial.begin(115200);

    #if CFG_DEBUG
      // Blocking wait for connection when debug mode is enabled via IDE
      while ( !Serial ) yield();
    #endif

      sub0::publish(this, Setup{});
    }

    void update()
    {
      sub0::publish(this, Update{});
  
      delay(1);
    }
} app;

void setup() 
{
  app.setup(); 
}

void loop() 
{
 app.update(); 
}