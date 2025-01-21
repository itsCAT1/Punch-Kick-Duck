using RMC.Core.UEvents;
using RMC.Core.UEvents.UEventDispatcher;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class DeactiveButton : MonoBehaviour
{
    public List<Button> buttons;

    void Start()
    {
        UEventDispatcherSingleton.Instance.AddEventListener<StatusPlayerHurt>(TurnOffButton);
        UEventDispatcherSingleton.Instance.AddEventListener<StatusPlayerDead>(OffButton);
    }

    private void TurnOffButton(IUEventData uEventData)
    {
        StartCoroutine(TimeWaitForPress());
    }

    private void OffButton(IUEventData uEventData)
    {
        Deactive();
    }

    IEnumerator TimeWaitForPress()
    {
        Deactive();

        yield return new WaitForSeconds(0.6f);

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
