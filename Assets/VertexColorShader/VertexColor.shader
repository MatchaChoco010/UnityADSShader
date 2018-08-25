Shader "MyShader/VertexColor"
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
				float4 color: COLOR;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
				float4 color : COLOR;
			};

			void vert (in appdata v, out v2f o)
			{
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.color = v.color;
			}

			void frag (in v2f i, out float4 col : SV_Target)
			{
				col = i.color;
			}
			ENDCG
		}
	}
}
