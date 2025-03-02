using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System.Security.Cryptography;

public enum TutorialState
{
    Punch,
    Kick,
    Duck,
    None
}

public class TutorialManager : Singleton<TutorialManager>
{
    public TutorialState currentState;

    public GameObject tutorialUI;
    public AttackHintSlider punchHint, kickHint, duckHint;

    void Start()
    {
        UEventDispatcherSingleton.Instance.AddEventListener<StartGame>(UpdateTutorial);
    }

    void UpdateTutorial(IUEventData uEventData)
    {
        if(DataManager.Instance.data.showTutorial)
        {

            currentState = TutorialState.Punch;
            ShowHint();
        }
        else
        {
            tutorialUI.SetActive(false);
        }
    }

    public void ShowHint()
    {
        switch (currentState)
        {
            case TutorialState.Punch:
                punchHint.OpenHint();
                break;

            case TutorialState.Kick:
                kickHint.OpenHint();
                break;

            case TutorialState.Duck:
                duckHint.OpenHint();
                break;

            case TutorialState.None:
                break;
        }
    }

    public void ChangeState()
    {
        switch (currentState)
        {
            case TutorialState.Punch:
                punchHint.CloseHint();
                StartCoroutine(TimeChangeState(TutorialState.Kick, 0.25f));
                break;

            case TutorialState.Kick:
                kickHint.CloseHint();
                StartCoroutine(TimeChangeState(TutorialState.Duck, 0.25f));
                break;

            case TutorialState.Duck:
                duckHint.CloseHint();
                StartCoroutine(TimeChangeState(TutorialState.None, 0.25f));
                break;
        }
    }

    IEnumerator TimeChangeState(TutorialState state, float time)
    {
        yield return new WaitForSeconds(time);

        currentState = state;
        ShowHint();
    }
}
