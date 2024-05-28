Shader "Custom/RoundedPlaneShader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Radius ("Radius", Range(0.0, 1.0)) = 0.1
    }
    SubShader
    {
        Tags { "Queue" = "Geometry" }
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            sampler2D _MainTex;
            float _Radius;

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

            fixed4 frag (v2f i) : SV_Target
            {
                float2 uv = i.uv * 2.0 - 1.0; // Scale UV to [-1, 1]
                float radius = _Radius;

                // Check if the fragment is within the rounded corners
                if (abs(uv.x) > 1.0 - radius && abs(uv.y) > 1.0 - radius)
                {
                    if (pow(abs(uv.x) - (1.0 - radius), 2.0) + pow(abs(uv.y) - (1.0 - radius), 2.0) > radius * radius)
                    {
                        discard;
                    }
                }

                fixed4 col = tex2D(_MainTex, i.uv);
                return col;
            }
            ENDCG
        }
    }
}
