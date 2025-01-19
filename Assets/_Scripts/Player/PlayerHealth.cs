using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerHealth : Health
{

    public void PerformHurt()
    {
        Player.Instance.controller.animator.Play("Hurt");
    }

}
