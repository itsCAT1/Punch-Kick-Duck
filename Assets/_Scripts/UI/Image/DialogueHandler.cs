using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DialogueHandler : Singleton<DialogueHandler>
{
    public ScaleHandler dialogOnStart;
    public ScaleHandler[] dialogEnemy;
    public ScaleHandler[] dialogEnemyBeaton;
    public ScaleHandler dialogOnHit, dialogOnDraw;
    public int enemyIndex;

    public void ShowDialogOnStart()
    {
        StartCoroutine(ShowDialog(dialogOnStart));
    }

    public void ShowDialogEnemy()
    {
        StartCoroutine(ShowDialog(dialogEnemy[enemyIndex]));
    }

    public void ShowDialogEnemyBeaton()
    {
        StartCoroutine(ShowDialog(dialogEnemyBeaton[enemyIndex]));
        enemyIndex++;
    }

    public void ShowDialogOnHit()
    {
        StartCoroutine(ShowDialog(dialogOnHit));
    }

    public void ShowDialogOnDraw()
    {
        StartCoroutine(ShowDialog(dialogOnDraw));
    }

    IEnumerator ShowDialog(ScaleHandler dialog)
    {
        dialog.ExpandObject();

        yield return new WaitForSeconds(2);

        dialog.CollapseObject();
    }

    private void Start()
    {
        UEventDispatcherSingleton.Instance.AddEventListener<MenuGame>(OnReset);
        UEventDispatcherSingleton.Instance.AddEventListener<RestartGame>(OnReset);
    }

    void OnReset(IUEventData uEventData)
    {
        enemyIndex = 0;
    }
}
