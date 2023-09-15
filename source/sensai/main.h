/*
  Analog input, analog output, serial output

  Reads an analog input pin, maps the result to a range from 0 to 255 and uses
  the result to set the pulse width modulation (PWM) of an output pin.
  Also prints the results to the Serial Monitor.

  The circuit:
  - potentiometer connected to analog pin 0.
    Center pin of the potentiometer goes to the analog pin.
    side pins of the potentiometer go to +5V and ground
  - LED connected from digital pin 9 to ground through 220 ohm resistor

  created 29 Dec. 2008
  modified 9 Apr 2012
  by Tom Igoe

  This example code is in the public domain.

  https://www.arduino.cc/en/Tutorial/BuiltInExamples/AnalogInOutSerial
*/
#include <cstdint>

// These constants won't change. They're used to give names to the pins used:
const int analogInPin = A0;  // Analog input pin that the potentiometer is attached to
const int analogOutPin = 9;  // Analog output pin that the LED is attached to

  const float ntcMaxTempohm = 0.3836;
  const float ntcMinTempohm = 10;
  const float ntcohmTemp[] = {
    119.9908257
  , 116.6461031
  , 113.6059427
  , 110.8144988
  , 108.235398
  , 105.8318986
  , 103.5798708
  , 101.4516699
  , 99.45816018
  , 97.63540407
  , 95.91206439
  , 94.28707212
  , 92.74559405
  , 91.28061667
  , 89.88359944
  , 88.55427532
  , 87.28299134
  , 86.06431624
  , 84.89986159
  , 83.79841138
  , 82.73968713
  , 81.72076579
  , 80.74050137
  , 79.79412242
  , 78.88119576
  , 77.99810104
  , 77.1487458
  , 76.32522649
  , 75.52669935
  , 74.75090573
  , 73.99535305
  , 73.26873701
  , 72.55992738
  , 71.86698765
  , 71.19596679
  , 70.54362326
  , 69.90296532
  , 69.28373096
  , 68.67772623
  , 68.08290963
  , 67.50825906
  , 66.93935554
  , 66.39042726
  , 65.84791872
  , 65.32122357
  , 64.80279136
  , 64.29727698
  , 63.80032764
  , 63.31560563
  , 62.83756475
  , 62.37199225
  , 61.91018957
  , 61.46337236
  , 61.01655515
  , 60.58780797
  , 60.15975607
  , 59.74251784
  , 59.33171857
  , 58.92414203
  , 58.5300838
  , 58.13602557
  , 57.75281556
  , 57.37532434
  , 56.99792255
  , 56.63600918
  , 56.27409582
  , 55.91589533
  , 55.56928345
  , 55.22267157
  , 54.88119202
  , 54.54893323
  , 54.21667444
  , 53.88929263
  , 53.5710532
  , 53.25281377
  , 52.93732465
  , 52.63246311
  , 52.32760157
  , 52.02274003
  , 51.7298883
  , 51.43800461
  , 51.14612093
  , 50.86039623
  , 50.58084565
  , 50.30129508
  , 50.0217445
  , 49.75334724
  , 49.4858907
  , 49.21843415
  , 48.95304241
  , 48.69685102
  , 48.44065963
  , 48.18446824
  , 47.9313993
  , 47.68636115
  , 47.44132299
  , 47.19628483
  , 46.9533677
  , 46.71899
  , 46.48461229
  , 46.25023459
  , 46.01585688
  , 45.79096314
  , 45.56675759
  , 45.34255205
  , 45.11834651
  , 44.89871735
  , 44.68420442
  , 44.46969149
  , 44.25517857
  , 44.04066564
  , 43.83380994
  , 43.62874538
  , 43.42368082
  , 43.21861626
  , 43.0135517
  , 42.81694794
  , 42.62094289
  , 42.42493783
  , 42.22893278
  , 42.03292772
  , 41.84405528
  , 41.65662301
  , 41.46919074
  , 41.28175847
  , 41.0943262
  , 40.91104966
  , 40.73198332
  , 40.55291697
  , 40.37385062
  , 40.19478428
  , 40.01571793
  , 39.84391481
  , 39.67281058
  , 39.50170634
  , 39.33060211
  , 39.15949788
  , 38.98891184
  , 38.82544685
  , 38.66198186
  , 38.49851688
  , 38.33505189
  , 38.1715869
  , 38.00812191
  , 37.85160395
  , 37.69544919
  , 37.53929444
  , 37.38313969
  , 37.22698494
  , 37.07083019
  , 36.91852162
  , 36.76940587
  , 36.62029012
  , 36.47117438
  , 36.32205863
  , 36.17294288
  , 36.02382713
  , 35.88038698
  , 35.73802619
  , 35.5956654
  , 35.45330461
  , 35.31094383
  , 35.16858304
  , 35.02622225
  , 34.88909482
  , 34.75314899
  , 34.61720316
  , 34.48125733
  , 34.34531151
  , 34.20936568
  , 34.07341985
  , 33.94035521
  , 33.81067373
  , 33.68099226
  , 33.55131079
  , 33.42162931
  , 33.29194784
  , 33.16226636
  , 33.03258489
  , 32.90730241
  , 32.7834962
  , 32.65968998
  , 32.53588377
  , 32.41207756
  , 32.28827134
  , 32.16446513
  , 32.04065892
  , 31.92070549
  , 31.80263607
  , 31.68456665
  , 31.56649723
  , 31.44842781
  , 31.33035839
  , 31.21228897
  , 31.09421955
  , 30.97724037
  , 30.86456821
  , 30.75189605
  , 30.63922389
  , 30.52655173
  , 30.41387956
  , 30.3012074
  , 30.18853524
  , 30.07586308
  , 29.96491028
  , 29.85750108
  , 29.75009187
  , 29.64268266
  , 29.53527345
  , 29.42786425
  , 29.32045504
  , 29.21304583
  , 29.10563663
  , 28.99830928
  , 28.89586057
  , 28.79341185
  , 28.69096313
  , 28.58851442
  , 28.4860657
  , 28.38361698
  , 28.28116827
  , 28.17871955
  , 28.07627083
  , 27.97504253
  , 27.87736998
  , 27.77969743
  , 27.68202487
  , 27.58435232
  , 27.48667977
  , 27.38900722
  , 27.29133466
  , 27.19366211
  , 27.09598956
  , 26.99839634
  , 26.9053278
  , 26.81225926
  , 26.71919072
  , 26.62612218
  , 26.53305364
  , 26.4399851
  , 26.34691656
  , 26.25384802
  , 26.16077947
  , 26.06771093
  , 25.97582945
  , 25.88711768
  , 25.79840591
  , 25.70969414
  , 25.62098238
  , 25.53227061
  , 25.44355884
  , 25.35484707
  , 25.2661353
  , 25.17742354
  , 25.08871177
  , 25
  };

int sensorValue = 0;  // value read from the pot
int outputValue = 0;  // value output to the PWM (analog out)

void setup() {
  // initialize serial communications at 9600 bps:
  Serial.begin(57600);
  //analogReadResolution(16); //< Keep math simple, pad to maximum board supports
}

float adc_to_ohm(uint16_t adc_val) {
    float Vin = 5.0;
    float Vref = 5.0;
    float Vout = adc_val * (Vref / 1024.0);
    float RT = 10000.0 / (Vin / Vout - 1.0);
    return RT;
}

float ohmToCelcius( float ohm )
{

  const uint16_t ntcohmTempCount = (sizeof(ntcohmTemp)/sizeof(ntcohmTemp[0]));
  const float tempohmRange = (ntcMinTempohm-ntcMaxTempohm);
  const uint16_t tempIndex = min(max( (ohm/1000)-ntcMaxTempohm,0), tempohmRange) * (1.0f/tempohmRange) * ntcohmTempCount + 0.5f;
  return ntcohmTemp[tempIndex];
}
void loop() {
  // read the analog in value:
  sensorValue = analogRead(analogInPin);
  float ohm = adc_to_ohm(sensorValue);
  float celcius = ohmToCelcius(ohm);

  // print the results to the Serial Monitor:
  Serial.print("sensor,\t");
  Serial.print(sensorValue);
  Serial.print("\tohm,\t");
  Serial.print( ohm );
  Serial.print("\tcelcius,\t");
  Serial.println( celcius );

  // wait 2 milliseconds before the next loop for the analog-to-digital
  // converter to settle after the last reading:
  delay(2);
}
