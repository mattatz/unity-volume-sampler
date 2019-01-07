using System;
using System.Linq;
using System.Collections;
using System.Collections.Generic;

using UnityEngine;
using Random = UnityEngine.Random;

namespace VolumeSampler.Demo
{

    [RequireComponent (typeof(MeshFilter))]
    public class Demo : MonoBehaviour
    {

        [SerializeField] protected Mesh source;
        [SerializeField, Range(4, 64)] int resolution = 16;
        [SerializeField, Range(1, 5f)] float distance = 1f;

        protected Volume volume;

        #region MonoBehaviour

        protected void Start()
        {
            volume = VolumeSampler.Sample(source, resolution, distance);
            GetComponent<MeshFilter>().sharedMesh = Build(volume);
        }

        protected void OnDrawGizmosSelected()
        {
            Gizmos.matrix = transform.localToWorldMatrix;

            if(volume != null)
            {
                var s = transform.localScale.x;
                volume.Points.ForEach(p =>
                {
                    Gizmos.DrawWireSphere(p, 0.01f / s);
                });
            }

        }

        #endregion

        protected Mesh Build(Volume vol)
        {
            var mesh = new Mesh();
            mesh.hideFlags = HideFlags.DontSave;
            mesh.SetVertices(vol.Points);
            var indices = new int[vol.Points.Count];
            for (int i = 0, n = indices.Length; i < n; i++)
            {
                indices[i] = i;
            }
            mesh.SetIndices(indices, MeshTopology.Points, 0);
            mesh.RecalculateBounds();
            return mesh;
        }

    }

}


