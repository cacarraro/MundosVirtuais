Shader "Hidden/MyShader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _pixels("Resolution", float) = 512
        _pixWidht("Pixel Width", float) = 64
        _pixHeight("Pixel Height", float) = 64
    }
    SubShader
    {
        // No culling or depth
        Cull Off ZWrite Off ZTest Always

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            float _pixels;
            float _pixWidht;
            float _pixHeight;
            float _dx;
            float _dy;
            sampler2D _MainTex;

            fixed4 frag (v2f i) : SV_Target
            {
                _dx = _pixWidht * (1 / _pixels);
                _dy = _pixHeight * (1 / _pixels);
                float2 coordinates = float2(_dx * floor(i.uv.x / _dx), _dy * floor(i.uv.y / _dy));
                fixed4 col = tex2D(_MainTex, coordinates);
                // just invert the colors
                col.rgb = 1 - col.rgb;
                return col;
            }
            ENDCG
        }
    }
}
