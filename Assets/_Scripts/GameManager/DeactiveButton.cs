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
        UEventData uEventData = new UEventData();
        UEventDispatcherSingleton.Instance.AddEventListener<UEvent>(TurnOffButton);
    }

    private void TurnOffButton(IUEventData uEventData)
    {
        

        StartCoroutine(TimeWaitForPress());

        
    }

    IEnumerator TimeWaitForPress()
    {
        Debug.Log("deactive");
        foreach (Button button in buttons)
        {
            button.interactable = false;
        }

        yield return new WaitForSeconds(0.6f);

        Debug.Log("active");
        foreach (Button button in buttons)
        {
            button.interactable = true;
        }
    }
}
