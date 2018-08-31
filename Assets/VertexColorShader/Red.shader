Shader "MyShader/Red"
{
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
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
			};

			void vert (in appdata v, out v2f o)
			{
				o.vertex = UnityObjectToClipPos(v.vertex);
			}

			void frag (in v2f i, out float col : SV_Target)
			{
				col = float4(1, 0, 0, 1);
			}
			ENDCG
		}
	}
}
