#pragma once

#include "NtcAdcConversion.h"
#include "Utility.h"


constexpr bool test()
{
    constexpr struct{ uint16_t adc; float ohm; float celcius; } 
    expected[] = {
     {2805,	447.154,	116.654      }
    ,{3060,	489.796,	113.614      }
    ,{3315,	532.787,	110.821      }
    ,{3570,	576.132,	105.838      }
    ,{3825,	619.835,	103.586      }
    ,{4080,	663.9	,	101.457      }
    ,{4335,	708.333,	99.463       }
    ,{4590,	753.138,	97.6399      }
    ,{4845,	798.319,	95.9163      }
    ,{5100,	843.882,	92.7494      }
    ,{5355,	889.831,	91.2842      }
    ,{5610,	936.17	,	89.887       }
    ,{5865,	982.906,	88.5575      }
    ,{6120,	1030.04,	86.0673      }
    ,{6375,	1077.59,	84.9026      }
    ,{6630,	1125.54,	83.801       }
    ,{6885,	1173.91,	82.7422      }
    ,{7140,	1222.71,	80.7428      }
    ,{7395,	1271.93,	79.7963      }
    ,{7650,	1321.59,	78.8833      }
    ,{7905,	1371.68,	77.1508      }
    ,{8160,	1422.22,	76.3272      }
    ,{8415,	1473.21,	75.5286      }
    ,{8670,	1524.66,	73.9971      }
    ,{8925,	1576.58,	73.2704      }
    ,{9180,	1628.96,	71.8685      }
    ,{9435,	1681.82,	71.1975      }
    ,{9690,	1735.16,	70.5451      }
    ,{9945,	1788.99,	69.2851      }
    ,{10200,	1843.32,	68.6791  }
    ,{10455,	1898.15,	67.5095  }
    ,{10710,	1953.49,	66.9406  }
    ,{10965,	2009.35,	65.8491  }
    ,{11220,	2065.73,	65.3224  }
    ,{11475,	2122.64,	64.2984  }
    ,{11730,	2180.09,	63.8014  }
    ,{11985,	2238.10,	62.8386  }
    ,{12240,	2296.65,	62.373   }
    ,{12495,	2355.77,	61.4643  }
    ,{12750,	2415.46,	61.0175  }
    ,{13005,	2475.73,	60.1606  }
    ,{13260,	2536.59,	59.3326  }
    ,{13515,	2598.04,	58.9249  }
    ,{13770,	2660.10,	58.1368  }
    ,{14025,	2722.77,	57.3761  }
    ,{14280,	2786.07,	56.9986  }
    ,{14535,	2850.00,	56.2748  }
    ,{14790,	2914.57,	55.57    }
    ,{15045,	2979.80,	55.2233  }
    ,{15300,	3045.69,	54.5496  }
    ,{15555,	3112.24,	53.8899  }
    ,{15810,	3179.49,	53.2534  }
    ,{16065,	3247.42,	52.9379  }
    ,{16320,	3316.06,	52.3282  }
    ,{16575,	3385.42,	51.7304  }
    ,{16830,	3455.5	,	51.1466  }
    ,{17085,	3526.32,	50.5813  }
    ,{17340,	3597.88,	50.0222  }
    ,{17595,	3670.21,	49.4864  }
    ,{17850,	3743.32,	48.9535  }
    ,{18105,	3817.2	,	48.4411  }
    ,{18360,	3891.89,	47.9318  }
    ,{18615,	3967.39,	47.4417  }
    ,{18870,	4043.72,	46.9538  }
    ,{19125,	4120.88,	46.485   }
    ,{19380,	4198.9	,	46.0162  }
    ,{19635,	4277.78,	45.5671  }
    ,{19890,	4357.54,	45.1187  }
    ,{20145,	4438.2	,	44.6845  }
    ,{20400,	4519.77,	44.2555  }
    ,{20655,	4602.27,	43.8341  }
    ,{20910,	4685.71,	43.2189  }
    ,{21165,	4770.11,	42.8172  }
    ,{21420,	4855.49,	42.4252  }
    ,{21675,	4941.86,	42.0332  }
    ,{21930,	5029.24,	41.4694  }
    ,{22185,	5117.65,	41.0946  }
    ,{22440,	5207.1	,	40.7322  }
    ,{22695,	5297.62,	40.195   }
    ,{22950,	5389.22,	39.8441  }
    ,{23205,	5481.93,	39.3308  }
    ,{23460,	5575.76,	38.9891  }
    ,{23715,	5670.73,	38.4987  }
    ,{23970,	5766.87,	38.1718  }
    ,{24225,	5864.2	,	37.6956  }
    ,{24480,	5962.73,	37.3833  }
    ,{24735,	6062.5	,	36.9187  }
    ,{24990,	6163.52,	36.4713  }
    ,{25245,	6265.82,	36.1731  }
    ,{25500,	6369.43,	35.7382  }
    ,{25755,	6474.36,	35.3111  }
    ,{26010,	6580.65,	34.8892  }
    ,{26265,	6688.31,	34.4814  }
    ,{26520,	6797.39,	34.0735  }
    ,{26775,	6907.89,	33.6811  }
    ,{27030,	7019.87,	33.4217  }
    ,{27285,	7133.33,	33.0327  }
    ,{27540,	7248.32,	32.536   }
    ,{27795,	7364.87,	32.1646  }
    ,{28050,	7482.99,	31.8027  }
    ,{28305,	7602.74,	31.4485  }
    ,{28560,	7724.14,	31.0943  }
    ,{28815,	7847.22,	30.752   }
    ,{29070,	7972.03,	30.3013  }
    ,{29325,	8098.59,	29.965   }
    ,{29580,	8226.95,	29.6427  }
    ,{29835,	8357.14,	29.2131  }
    ,{30090,	8489.21,	28.8959  }
    ,{30345,	8623.19,	28.4861  }
    ,{30600,	8759.12,	28.0763  }
    ,{30855,	8897.06,	27.7797  }
    ,{31110,	9037.04,	27.389   }
    ,{31365,	9179.1	,	26.9984  }
    ,{31620,	9323.31,	26.6261  }
    ,{31875,	9469.7	,	26.3469  }
    ,{32130,	9618.32,	25.9758  }
    ,{32385,	9769.23,	25.621   }
    ,{32640,	9922.48,	25.2661  }
        };

  uint16_t pass = 0;
  for ( auto expect : expected )
  {            
    float ohm = adcToOhm(expect.adc);
    float celcius = ohmToCelcius(ohm);
    pass += floatNear( celcius, expect.celcius, 0.1F );
  }
  return pass== std::extent<decltype(expected)>();
}
//static_assert( test() );

#if !ARDUINO

#include <iostream>
int main( int argc, char** argv)
{
    for ( int32_t adc = 0; adc < 0xeFFF; adc+= 0xFF )
    {
        float milliohm = adcToOhm(adc == 0 ? 3060 : adc);
        float celcius = milliohmToCelcius(milliohm);
        std::cout 
            <<   "adc\t" << adc
            << "\tohm\t" << milliohm /// 1000.0F
            << "\tcelcius\t" << celcius
            << '\n';
    }
}
#endif