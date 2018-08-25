Shader "MyShader/VertexDiffuse"
{
	Properties
	{
		_LightDirection ("Light Direction", Vector) = (1.0, 1.0, -1.0, 1.0)
		_Ldiffuse ("Ldiffuse", Vector) = (1.0, 1.0, 1.0, 1.0)
		_Kdiffuse ("Kdiffuse", Vector) = (1.0, 1.0, 1.0, 1.0)
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
				float3 normal : Normal;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
				float3 color : COLOR;
			};

			uniform float3 _LightDirection;
			uniform float3 _Ldiffuse;
			uniform float3 _Kdiffuse;

			void vert (in appdata v, out v2f o)
			{
				o.vertex = UnityObjectToClipPos(v.vertex);
				float3 normal = UnityObjectToWorldNormal(v.normal);
				float3 l = normalize(_LightDirection);
				o.color = _Ldiffuse * _Kdiffuse * max(dot(normal, l), 0);
			}

			float4 frag (v2f i) : SV_Target
			{
				return float4(i.color, 1);
			}
			ENDCG
		}
	}
}
