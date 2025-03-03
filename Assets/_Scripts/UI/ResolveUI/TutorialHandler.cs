using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;


public class TutorialHandler : Singleton<TutorialHandler>
{
    public GameObject[] tickUI;
    public GameObject[] dashUI;

    public TutorialSlider tutorialSlider;
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

    public void UpdateTutorial(AttackType enemyAttackType)
    {
        if(enemyAttackType == AttackType.Kick)
        {
            tickUI[0].SetActive(true);
            dashUI[0].SetActive(false);
            Player.Instance.tutorial.canWait = false;
            Player.Instance.attack.canAttack = false;
        }

        else if (enemyAttackType == AttackType.Duck)
        {
            tickUI[1].SetActive(true);
            dashUI[1].SetActive(false);
            Player.Instance.tutorial.canWait = false;
            Player.Instance.attack.canAttack = false;
        }

        else if (enemyAttackType == AttackType.Punch)
        {
            tickUI[2].SetActive(true);
            dashUI[2].SetActive(false);

            OnBeatenEnemy();
        }
    }

    void OnBeatenEnemy()
    {
        DataManager.Instance.data.showTutorial = false;
        Player.Instance.tutorial.canWait = true;
        
        ConditionManger.Instance.inGameUI.SetActive(true);

        tutorialSlider.SlideNoteScore();
    }
}
