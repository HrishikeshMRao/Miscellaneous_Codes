#include <wifi.h>
void setup()
{
 serial.begin(115200);
 wifi.mode(WIFI_STA);
 wifi.disconnect();
 delay(100);
}