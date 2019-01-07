using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace VolumeSampler.Demo
{

    public class TurnTable : MonoBehaviour
    {

        [SerializeField] protected float speed = 2f;

        protected void FixedUpdate()
        {
            transform.Rotate(Vector3.up * speed * Time.fixedDeltaTime);
        }

    }

}


