using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;


public class TutorialHandler : Singleton<TutorialHandler>
{
    public GameObject[] tickUI;
    public GameObject[] dashUI;


    private void OnEnable()
    {
        HintOnStart();
    }

    void HintOnStart()
    {
        foreach (var tick in tickUI)
        {
            tick.SetActive(false);
        }
    }

    public void UpdateHint(AttackType enemyAttackType)
    {
        if(enemyAttackType == AttackType.Kick)
        {
            tickUI[0].SetActive(true);
            dashUI[0].SetActive(false);
        }

        else if (enemyAttackType == AttackType.Duck)
        {
            tickUI[1].SetActive(true);
            dashUI[1].SetActive(false);
        }

        else if (enemyAttackType == AttackType.Punch)
        {
            tickUI[2].SetActive(true);
            dashUI[2].SetActive(false);

            OnCompletedTutorial();
        }
    }

    void OnCompletedTutorial()
    {
        DataManager.Instance.data.showTutorial = false;

        UEventData uEventData = new UEventData();
        UEventDispatcherSingleton.Instance.Invoke<InGame>(uEventData);
    }
}
