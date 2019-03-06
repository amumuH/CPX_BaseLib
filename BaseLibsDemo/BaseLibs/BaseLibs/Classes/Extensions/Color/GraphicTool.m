//
//  GraphicTool.m
//  kugou
//
//  Created by cheng lixing on 12-5-21.
//  Copyright (c) 2012年 kugou. All rights reserved.
//

#import "GraphicTool.h"
#import "math.h"

@implementation GraphicTool

#define min3v(v1, v2, v3)   ((v1)>(v2)? ((v2)>(v3)?(v3):(v2)):((v1)>(v3)?(v3):(v1)))  
#define max3v(v1, v2, v3)   ((v1)<(v2)? ((v2)<(v3)?(v3):(v2)):((v1)<(v3)?(v3):(v1)))

#define POW_FACTOR 0.88f

+ (void) rgbf2HSL: (float)r g: (float)g b: (float)b OUT retH: (float*)retH
                    OUT retS: (float*)retS OUT retL: (float*)retL
{
    double w = 0.00001f;
    float maxVal = max3v(r, g, b);
    float minVal = min3v(r, g, b);

    if( retH != 0 )
    {
        float hh  = 0;
        if(fabs(maxVal - minVal) <= w)
        {
            hh = 0;
        }
        else if(fabs(maxVal - r) <= w && g >= b )
        {
            hh =  60.0f*(g-b)/(maxVal-minVal); 
        }
        else if(fabs(maxVal - r) <= w && g < b)
        {
            hh = 60.0f * (g - b) / (maxVal - minVal) + 360.0f;
        }
        else if(fabs(maxVal - g) <= w)
        {
            hh = 60.0f*(b-r)/(maxVal-minVal) + 120.0f;   
        }
        else if(fabs(maxVal - b) <= w)
        {
            hh = 60.0f*(r-g)/(maxVal-minVal) + 240.0f;
        }
        *retH = (hh>360)? 360 : ((hh<0)?0:hh);    
    }

    if( retL != NULL)
    {
        float ll = 0;
        ll = (maxVal+minVal)/2.0f;
    
        *retL = ((ll>1)? 1 : ((ll<0)?0:ll))*100;   
        
        if( retS != NULL )
        {
            float ss = 0;
            if(ll <= w || fabs(maxVal - minVal) <= w )
            {
            ss = 0;
            }
            else if( 0 < ll && ll <= 0.5f)
            {
                ss = (maxVal-minVal)/(maxVal+minVal);   
            }
            else if( ll > 0.5f)
            {
                ss = (maxVal-minVal)/(2 - (maxVal+minVal));
            }
        
            *retS = ((ss>1)? 1 : ((ss<0)?0:(ss)))*100; 
        }
    }
}

+ (void) rgb2HSL: (UInt32)targetCorlor OUT retH: (float*)retH
        OUT retS: (float*)retS OUT retL: (float*)retL
{
    float r = GetRValue(targetCorlor) / 255.0f;
    float g = GetGValue( targetCorlor ) / 255.0f;
    float b = GetBValue( targetCorlor ) / 255.0f;
    [GraphicTool rgbf2HSL: r g: g b: b retH: retH retS: retS retL: retL];
}

+ (float) calPowl: (float)source
{
    float powl = 0;
	if ( source - 50.0f > 0 )
    {
        powl = pow( source - 50.0f, POW_FACTOR );
    }
	else
    {
        powl = -pow( 50.0f - source, POW_FACTOR );
    }
    
	return powl;
}

+ (void) hsl2RGBF: (float)hh ss: (float)ss ll: (float)ll a: (WORD)a OUT retR: (float*)retR
    OUT retG: (float*)retG OUT retB: (float*)retB
{
    float h = hh;                  // h must be [0, 360]   

    float s = ss / 100.f; // s must be [0, 1]   

    float l = ll / 100.f;      // l must be [0, 1]      
    
    float q = (l<0.5f)?(l * (1.0f+s)):(l+s - (l*s));   
    
    float p = (2.0f * l) - q;   
    
    float Hk = h/360.0f;   
    
    float T[3];   
    
    T[0] = Hk + 0.3333333f; // Tr   0.3333333f=1.0/3.0   
    
    T[1] = Hk;              // Tb   
    
    T[2] = Hk - 0.3333333f; // Tg   

    for(int i=0; i<3; i++)   
    {   
        if(T[i] < 0) T[i] += 1.0f;   
        
        if(T[i] > 1) T[i] -= 1.0f;          
        
        if((T[i]*6) < 1)   
        {   
            T[i] = p + ((q-p)*6.0f*T[i]);  
        }   
        else if((T[i]*2.0f) < 1) //(1.0/6.0)<=T[i] && T[i]<0.5   
        {   
            T[i] = q;   
        }   
        else if((T[i]*3.0f) < 2) // 0.5<=T[i] && T[i]<(2.0/3.0)   
        {   
            T[i] = p + (q-p) * ((2.0f/3.0f) - T[i]) * 6.0f;   
        }   
        else 
        {
            T[i] = p;  
        } 
    }   

    *retR = T[0];   
    
    *retG = T[1];   
    
    *retB = T[2];   
}

+ (void) hsl2RGB: (float)hh ss: (float)ss ll: (float)ll a: (WORD)a OUT retColor: (UInt32*)retColor
{
    float R, G, B;
    [GraphicTool hsl2RGBF: hh ss: ss ll: ll a: a retR: &R retG: &G retB: &B];

    R = R*255.0f;   

    G = G*255.0f;   

    B = B*255.0f;   

    *retColor = ( (BYTE)(a)<<24 ) |
    ( (BYTE)((R>255)? 255 : ((R<0)?0 : R))) |
    ( (BYTE)((G>255)? 255 : ((G<0)?0 : G))<<8 ) |
    ( (BYTE)((B>255)? 255 : ((B<0)?0 : B))<<16 );
}

+ (UInt32) calMergeColor: (UInt32)sourceColor powl: (float)powl selectH: (float)selectH
                 selectS: (float)selectS selectL: (float)selectL
{
    UInt32 DColor;
    float l;
    float s;
    float h;
    [GraphicTool rgb2HSL: sourceColor retH: &h retS: &s retL: &l];

    float DL, DS, DH;
    if( l >= 100.0f || l <= 0.0f )
    {
        DColor = sourceColor;
        return DColor;
    }
    
    DL = powl + l;
    DS = selectS;
    DH = selectH;
    
    [GraphicTool hsl2RGB: DH ss: DS ll: DL a: (sourceColor>>24) retColor: &DColor];
    
    return DColor;
}

@end
