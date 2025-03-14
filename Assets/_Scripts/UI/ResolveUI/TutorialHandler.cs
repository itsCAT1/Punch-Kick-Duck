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
    public HintSlider hintSlider;

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

        foreach (var dash in dashUI)
        {
            dash.SetActive(true);
        }
    }

    public void UpdateTutorial(AttackType enemyAttackType)
    {
        if(enemyAttackType == AttackType.Kick)
        {
            tickUI[0].SetActive(true);
            dashUI[0].SetActive(false);
            DialogueHandler.Instance.ShowDialogEnemyBeaton();

            Player.Instance.tutorial.isWaiting = false;
            Player.Instance.attack.canAttack = false;
        }

        else if (enemyAttackType == AttackType.Duck)
        {
            tickUI[1].SetActive(true);
            dashUI[1].SetActive(false);
            DialogueHandler.Instance.ShowDialogEnemyBeaton();

            Player.Instance.tutorial.isWaiting = false;
            Player.Instance.attack.canAttack = false;
        }

        else if (enemyAttackType == AttackType.Punch)
        {
            tickUI[2].SetActive(true);
            dashUI[2].SetActive(false);
            DialogueHandler.Instance.ShowDialogEnemyBeaton();

            OnClearEnemy();
        }
    }

    void OnClearEnemy()
    {
        StartCoroutine(ShowPanelTutorial());
    }

    IEnumerator ShowPanelTutorial()
    {
        yield return new WaitForSeconds(2.5f);

        DataManager.Instance.data.showTutorial = false;
        Player.Instance.tutorial.isWaiting = false;
        Player.Instance.tutorial.canWait = true;

        ConditionManger.Instance.inGameUI.SetActive(true);
        InGameManager.Instance.lives.ShowLives();

        hintSlider.CloseHint();
        tutorialSlider.SlideNoteScore();
    }
}
