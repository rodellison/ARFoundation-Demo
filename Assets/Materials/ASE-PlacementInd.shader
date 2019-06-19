// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "ASE-PlacementInd"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		_MainTexture("Main Texture", 2D) = "white" {}
		_MaskTexture("Mask Texture", 2D) = "black" {}
		_MaskSpinSpeed("Mask Spin Speed", Range( 0 , 0.2)) = 0.05
		[HDR]_MainColor("Main Color", Color) = (0.9716981,0.9716981,0.9716981,1)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "AlphaTest+0" }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha noshadow 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform float4 _MainColor;
		uniform sampler2D _MainTexture;
		uniform float4 _MainTexture_ST;
		uniform sampler2D _MaskTexture;
		uniform float4 _MaskTexture_ST;
		uniform float _MaskSpinSpeed;
		uniform float _Cutoff = 0.5;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_MainTexture = i.uv_texcoord * _MainTexture_ST.xy + _MainTexture_ST.zw;
			float4 tex2DNode3 = tex2D( _MainTexture, uv_MainTexture );
			o.Albedo = ( _MainColor * tex2DNode3 ).rgb;
			o.Alpha = 1;
			float2 uv0_MaskTexture = i.uv_texcoord * _MaskTexture_ST.xy + _MaskTexture_ST.zw;
			float cos7 = cos( radians( (0.0 + (( _Time.y * _MaskSpinSpeed ) - 0.0) * (360.0 - 0.0) / (1.0 - 0.0)) ) );
			float sin7 = sin( radians( (0.0 + (( _Time.y * _MaskSpinSpeed ) - 0.0) * (360.0 - 0.0) / (1.0 - 0.0)) ) );
			float2 rotator7 = mul( uv0_MaskTexture - float2( 0.5,0.5 ) , float2x2( cos7 , -sin7 , sin7 , cos7 )) + float2( 0.5,0.5 );
			clip( ( tex2D( _MaskTexture, rotator7 ).r * tex2DNode3.a ) - _Cutoff );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
754;190;1906;960;1990.51;1043.05;2.115366;True;True
Node;AmplifyShaderEditor.SimpleTimeNode;19;-2225.241,-166.7367;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;18;-2337.245,-44.32567;Float;False;Property;_MaskSpinSpeed;Mask Spin Speed;3;0;Create;True;0;0;False;0;0.05;0.05;0;0.2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;14;-1985.677,183.8454;Float;False;Constant;_Float5;Float 5;2;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;17;-1990.734,94.5284;Float;False;Constant;_Float4;Float 4;2;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;16;-1992.418,13.63751;Float;False;Constant;_Float3;Float 3;2;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;13;-1987.363,273.1624;Float;False;Constant;_Float6;Float 6;2;0;Create;True;0;0;False;0;360;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;-2023.006,-123.0096;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;12;-1840.422,-628.2894;Float;True;Property;_MaskTexture;Mask Texture;2;0;Create;True;0;0;False;0;18a45ea62199bbe4ea032f4391d3c225;18a45ea62199bbe4ea032f4391d3c225;False;black;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.TFHCRemapNode;20;-1775.67,9.99901;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;11;-1492.776,-235.7652;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RadiansOpNode;9;-1404.584,126.0571;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;8;-1446.584,-112.4506;Float;False;Constant;_Vector0;Vector 0;1;0;Create;True;0;0;False;0;0.5,0.5;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TexturePropertyNode;1;-1030.846,-59.2792;Float;True;Property;_MainTexture;Main Texture;1;0;Create;True;0;0;False;0;None;1e5972ba8c601504fa97f6fe4b81239b;False;white;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.RotatorNode;7;-1188.683,-311.6863;Float;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;6;-826.0361,-582.8428;Float;True;Property;_TextureSample1;Texture Sample 1;1;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;3;-768.8682,-58.9356;Float;True;Property;_TextureSample0;Texture Sample 0;1;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;2;-270.5478,-206.1146;Float;False;Property;_MainColor;Main Color;4;1;[HDR];Create;True;0;0;False;0;0.9716981,0.9716981,0.9716981,1;0.9716981,0.9716981,0.9716981,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;4;-250.0029,13.9262;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;5;20.60194,-80.1936;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;30;373,-221.7656;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;ASE-PlacementInd;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Masked;0.5;True;False;0;False;TransparentCutout;;AlphaTest;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;15;0;19;0
WireConnection;15;1;18;0
WireConnection;20;0;15;0
WireConnection;20;1;16;0
WireConnection;20;2;17;0
WireConnection;20;3;14;0
WireConnection;20;4;13;0
WireConnection;11;2;12;0
WireConnection;9;0;20;0
WireConnection;7;0;11;0
WireConnection;7;1;8;0
WireConnection;7;2;9;0
WireConnection;6;0;12;0
WireConnection;6;1;7;0
WireConnection;3;0;1;0
WireConnection;4;0;6;1
WireConnection;4;1;3;4
WireConnection;5;0;2;0
WireConnection;5;1;3;0
WireConnection;30;0;5;0
WireConnection;30;10;4;0
ASEEND*/
//CHKSM=9103F6802130AB258E089566C1428C083BA77C7B