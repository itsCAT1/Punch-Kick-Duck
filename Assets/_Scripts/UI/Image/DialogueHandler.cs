using RMC.Core.UEvents;
using RMC.Core.UEvents.UEventDispatcher;
using System.Collections;
using UnityEngine;

public class DialogueHandler : Singleton<DialogueHandler>
{
    public ScaleHandler dialogOnStart;
    public ScaleHandler[] dialogEnemy;
    public ScaleHandler[] dialogEnemyBeaton;
    public ScaleHandler dialogOnHit, dialogOnDraw;
    public RectTransform dialogPos, dotPos;
    Vector3 dotScale;
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
        dialog.ExpandObject(dotScale);

        yield return new WaitForSeconds(2);

        dialog.CollapseObject();
    }

    private void Start()
    {
        InitPos();
        UEventDispatcherSingleton.Instance.AddEventListener<MenuGame>(SetPosOnStart);
        UEventDispatcherSingleton.Instance.AddEventListener<LevelSelection>(SetPosOnStart);
    }

    void SetPosOnStart(IUEventData uEventData)
    {
        InitPos();
    }

    void InitPos()
    {
        enemyIndex = 0;

        int currentMap = DataManager.Instance.data.currentMap;

        if (currentMap % 2 == 1)
        {
            dialogPos.anchoredPosition = new Vector3(-300, 130, 0);
            dotScale = new Vector3(1.5f, 1.5f, 1.5f);
        }
        else
        {
            dialogPos.anchoredPosition = new Vector3(300, 130, 0);
            dotScale = new Vector3(-1.5f, 1.5f, 1.5f);
        }
    }
}
