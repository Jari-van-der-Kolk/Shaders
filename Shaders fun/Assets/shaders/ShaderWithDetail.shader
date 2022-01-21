// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/Textured With Detail"
{
    
    properties
    {
        _Tint ("Tint", Color) = (1,0.5,1,1)   
        _MainTex ("Texture", 2D) = "white" {} 
        _DetailTex ("Detail Texture", 2D) = "gray" {} 
        
    }
    
        subshader
    {
        pass
        {
            CGPROGRAM

            #pragma vertex MyVertexProgram
			#pragma fragment MyFragmentProgram

            #include "UnityCG.cginc"

            float4 _Tint;
            sampler2D _MainTex, _DetailTex;
            float4 _MainTex_ST, _DetailTex_ST;

            struct Interpolators 
            {
                float4 position : SV_POSITION;
                float2 uv : TEXCOORD0;
            };

            struct VertexData
            {
                float4 position : POSITION;
                float2 uv : TEXCOORD0;
            };
            
            
			Interpolators MyVertexProgram (const VertexData v)
            {
                Interpolators i;
                i.position =  UnityObjectToClipPos(v.position);
			    i.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return i;
			}

            float4 MyFragmentProgram (Interpolators i) : SV_TARGET
            {
                float4 color = tex2D(_MainTex, i.uv) * _Tint;
                color *= tex2D(_MainTex, i.uv * 10) * 2;
				return color;
			}

            ENDCG
        }
    }
    
}