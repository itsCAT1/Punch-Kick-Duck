using RMC.Core.UEvents;
using RMC.Core.UEvents.UEventDispatcher;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class ButtonHandler : MonoBehaviour
{
    public List<Button> buttons;
    float timeStart = 0;
    public float duration = 1;
    public bool cantAttack => Time.time - timeStart >= duration;

    void Start()
    {
        UEventDispatcherSingleton.Instance.AddEventListener<PlayerHurt>(SetAttackCooldown);
        UEventDispatcherSingleton.Instance.AddEventListener<PlayerBlocking>(SetAttackCooldown);
    }

    public void SetAttackCooldown(IUEventData uEventData)
    {
        timeStart = Time.time;

        if (cantAttack)
        {
            Deactive();
            return;
        }

        Active();
    }

    public void Deactive()
    {
        foreach (Button button in buttons)
        {
            button.interactable = false;
        }
    }

    public void Active()
    {
        foreach (Button button in buttons)
        {
            button.interactable = true;
        }
    }
}
