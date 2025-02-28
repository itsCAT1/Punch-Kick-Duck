using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BossHealth : Health
{
    private void Start()
    {
        currentHealth = maxHealth;
    }

    protected override void Hurt()
    {
        Boss.Instance.executer.SetCurrentState("Hurt");
    }


    protected override void Dead()
    {
        Boss.Instance.executer.SetCurrentState("Dead");
    }
}
