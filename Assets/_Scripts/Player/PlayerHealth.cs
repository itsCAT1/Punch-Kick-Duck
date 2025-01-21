using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerHealth : Health
{
    protected override void Hurt()
    {
        Player.Instance.controller.executer.SetCurrentState("Hurt");
    }

    protected override void Dead()
    {
        Player.Instance.controller.executer.SetCurrentState("Dead");
    }
}
