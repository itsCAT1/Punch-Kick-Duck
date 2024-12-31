using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Lean.Pool;

public class SelfDestroy : MonoBehaviour
{
    private void Start()
    {
        LeanPool.Despawn(this);
    }
}
