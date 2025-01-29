using RMC.Core.UEvents;
using RMC.Core.UEvents.UEventDispatcher;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class ButtonHandle : MonoBehaviour
{
    public List<Button> buttons;

    void Start()
    {
        UEventDispatcherSingleton.Instance.AddEventListener<PlayerHurt>(TurnOffForAWhile);
        UEventDispatcherSingleton.Instance.AddEventListener<PlayerBlocking>(TurnOffForAWhile);
        UEventDispatcherSingleton.Instance.AddEventListener<PlayerDeath>(TurnOff);
    }

    public void TurnOffForAWhile(IUEventData uEventData)
    {
        StartCoroutine(StartTurnOff());
    }

    public IEnumerator StartTurnOff()
    {
        Deactive();

        yield return new WaitForSeconds(1f);

        Active();
    }

    public void TurnOff(IUEventData uEventData)
    {
        Deactive();
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
