Shader "MyShader/VertexADS"
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
		_Kambient ("Kambient", Vector) = (0.1, 0.1, 0.1, 1.0)
		_Kdiffuse ("Kdiffuse", Vector) = (0.5, 0.5, 0.5, 1.0)
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
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
				float3 color : COLOR;
			};

			uniform float3 _LightDirection;
			uniform float3 _Lambient;
			uniform float3 _Ldiffuse;
			uniform float3 _Lspecular;
			uniform float3 _Kambient;
			uniform float3 _Kdiffuse;
			uniform float3 _Kspecular;
			uniform float _Shininess;

			void vert (in appdata v, out v2f o)
			{
				o.vertex = UnityObjectToClipPos(v.vertex);

				float3 normal = UnityObjectToWorldNormal(v.normal);
				float3 l = normalize(_LightDirection);
				float3 view = normalize(_WorldSpaceCameraPos - o.vertex);
				float3 h = normalize(l + view);

				float3 Iambient = _Lambient * _Kambient;

				float3 Idiffuse = _Ldiffuse * _Kdiffuse * max(dot(normal, _LightDirection), 0);

				float3 Ispecular = _Lspecular * _Kspecular * pow(max(dot(normal, h), 0), _Shininess);

				o.color = Iambient + Idiffuse + Ispecular;
			}

			void frag (in v2f i, out float4 col : SV_Target)
			{
				col = float4(i.color, 1);
			}
			ENDCG
		}
	}
}
