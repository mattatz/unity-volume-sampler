Shader "VolumeSampler/Demo"
{
  Properties {
    _Color ("Color", Color) = (1, 1, 1, 1)
    _Size ("Size", Range(0.01, 0.1)) = 0.1
  }

  // References:
  // - https://github.com/keijiro/Pcx/blob/master/Assets/Pcx/Runtime/Shaders/Disk.cginc

  CGINCLUDE

  #include "UnityCG.cginc"

  struct appdata
  {
    float4 vertex : POSITION;
  };

  struct v2g
  {
    float4 position : SV_POSITION;
  };

  struct g2f {
    float4 position : SV_POSITION;
  };

  v2g vert(appdata v)
  {
    v2g o;
    o.position = UnityObjectToClipPos(v.vertex);
    return o;
  }

  half _Size;
  half4 _Color;

  [maxvertexcount(36)]
  void geom(point v2g IN[1], inout TriangleStream<g2f> OUT) {
    float4 origin = IN[0].position;
    float2 extent = abs(UNITY_MATRIX_P._11_22 * _Size);

    g2f o = IN[0];

    float radius = extent.y / origin.w * _ScreenParams.y;
    uint slices = min((radius + 1) / 5, 4) + 2;

    if (slices == 2) extent *= 1.2;

    o.position.y = origin.y + extent.y;
    o.position.xzw = origin.xzw;
    OUT.Append(o);

    UNITY_LOOP for (uint i = 1; i < slices; i++)
    {
      float sn, cs;
      sincos(UNITY_PI / slices * i, sn, cs);

      o.position.xy = origin.xy + extent * float2(sn, cs);
      OUT.Append(o);

      o.position.x = origin.x - extent.x * sn;
      OUT.Append(o);
    }

    o.position.x = origin.x;
    o.position.y = origin.y - extent.y;
    OUT.Append(o);

    OUT.RestartStrip();
  }

  fixed4 frag(v2g IN) : SV_Target
  {
    return _Color;
  }

  ENDCG

  SubShader
  {
    Tags { "RenderType" = "Opaque" "Queue" = "Geometry" }
    LOD 100

    Cull Off

    Pass
    {
      CGPROGRAM
      #pragma vertex vert
      #pragma geometry geom
      #pragma fragment frag
      ENDCG
    }
  }
}
