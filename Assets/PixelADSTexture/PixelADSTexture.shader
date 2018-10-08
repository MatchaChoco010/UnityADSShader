Shader "MyShader/PixelADSTexture"
{
	Properties
	{
		[Header(Light)]
		_LightDirection ("Light Direction", Vector) = (1.0, 1.0, -1.0, 1.0)
		_Lambient ("Lambient", Vector) = (0.5, 0.5, 0.5, 1.0)
		_Ldiffuse ("Ldiffuse", Vector) = (1.0, 1.0, 1.0, 1.0)
		_Lspecular ("Lspecular", Vector) = (1.0, 1.0, 1.0, 1.0)
		[Space]
		[Header(Material)]
		_MainTex ("Diffuse Texture", 2D) = "white" {}
		_Kambient ("Kambient", Vector) = (0.1, 0.1, 0.1, 1.0)
		_Kspecular ("Kspecular", Vector) = (0.5, 0.5, 0.5, 1.0)
		_Shininess ("Shininess", float) = 150
	}
	SubShader
	{
		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float3 normal : NORMAL;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
				float3 normal : NORMAL;
				float4 position : TEXCOORD0;
				float2 uv : TEXCOORD1;
			};

			uniform float3 _LightDirection;
			uniform float3 _Lambient;
			uniform float3 _Ldiffuse;
			uniform float3 _Lspecular;

			uniform sampler2D _MainTex;
			uniform float4 _MainTex_ST;

			uniform float3 _Kambient;
			uniform float3 _Kspecular;
			uniform float _Shininess;

			void vert (in appdata v, out v2f o)
			{
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.normal = v.normal;
				o.position = mul(UNITY_MATRIX_M, v.vertex);

				// o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				o.uv = v.uv * _MainTex_ST.xy + _MainTex_ST.zw;
			}

			void frag (in v2f i, out float4 col : SV_Target)
			{
				float3 normal = UnityObjectToWorldNormal(i.normal);
				float3 l = normalize(_LightDirection);
				float3 view = normalize(_WorldSpaceCameraPos - i.position);
				float3 h = normalize(l + view);

				float3 Iambient = _Lambient * _Kambient;

				float3 tex = tex2D (_MainTex, i.uv);
				float3 Idiffuse = _Ldiffuse * tex * max(dot(normal, _LightDirection), 0);

				float3 Ispecular = _Lspecular * _Kspecular * pow(max(dot(normal, h), 0), _Shininess);

				col = float4(Iambient + Idiffuse + Ispecular, 1);
			}
			ENDCG
		}
	}
}
