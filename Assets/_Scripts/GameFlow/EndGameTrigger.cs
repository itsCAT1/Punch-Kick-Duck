using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EndGameTrigger : MonoBehaviour
{
    public float time;
    private void Start()
    {
        UEventDispatcherSingleton.Instance.AddEventListener<EndGame>(ChangeStatePlayer);
    }

    public void ChangeStatePlayer(IUEventData uEventData)
    {
        Player.Instance.controller.executer.SetCurrentState("EndGame");
    }


    private void OnTriggerEnter(Collider other)
    {
        if (other.gameObject.CompareTag("Player"))
        {
            UEventData uEventData = new UEventData();
            UEventDispatcherSingleton.Instance.Invoke<EndGame>(uEventData);
            StartCoroutine(StartEndGame());
        }
    }

    IEnumerator StartEndGame()
    {
        while (time <= 15)
        {
            yield return new WaitForSeconds(1);
            time++;
            Debug.Log(time);
        }
    }
}
