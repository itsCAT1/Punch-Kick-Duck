using RMC.Core.UEvents;
using RMC.Core.UEvents.UEventDispatcher;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class ButtonHandler : MonoBehaviour
{
    public List<Button> buttons;

    void Start()
    {
        UEventDispatcherSingleton.Instance.AddEventListener<PlayerHurt>(SetAttackCooldown);
        UEventDispatcherSingleton.Instance.AddEventListener<PlayerBlocking>(SetAttackCooldown);
    }

    public void SetAttackCooldown(IUEventData uEventData)
    {
        StartCoroutine(TurnOffButton());
    }

    public IEnumerator TurnOffButton()
    {
        Deactive();

        yield return new WaitForSeconds(1f);

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
