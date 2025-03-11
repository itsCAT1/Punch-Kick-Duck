using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EndGameTrigger : MonoBehaviour
{
    PlayerLevelMover levelMover;

    private void Start()
    {
        levelMover = GetComponent<PlayerLevelMover>();
        UEventDispatcherSingleton.Instance.AddEventListener<EndGame>(ChangeStatePlayer);
    }

    public void ChangeStatePlayer(IUEventData uEventData)
    {
        Player.Instance.executer.SetCurrentState("EndGame");
    }


    private void OnTriggerEnter(Collider other)
    {
        if (other.gameObject.CompareTag("Player"))
        {
            levelMover.PlayerMoving();
            LevelManager.Instance.StartTransition();

            ConditionManger.Instance.endGameUI.SetActive(true);
            SetAchievement();

            UEventData uEventData = new UEventData();
            UEventDispatcherSingleton.Instance.Invoke<EndGame>(uEventData);
        }
    }

    void SetAchievement()
    {
        if (DataManager.Instance.data.currentMap == 1 || DataManager.Instance.data.currentMap == 10 || MiniBoss.Instance == null) return;

        if(Vector3.Distance(Player.Instance.transform.position, MiniBoss.Instance.transform.position) <= 10)
        {
            AchievementManager.Instance.UnlockAchievement(4);
        }
    }
}
