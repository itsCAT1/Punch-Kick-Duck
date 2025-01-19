using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerHealth : Health
{
    public GameObject disableAction;

    public void PerformHurt()
    {
        Player.Instance.controller.animator.Play("Hurt");
        disableAction.SetActive(true);
    }

}
