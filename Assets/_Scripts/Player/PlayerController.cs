using FSMC.Runtime;
using RMC.Core.UEvents;
using RMC.Core.UEvents.UEventDispatcher;
using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEditor;
using UnityEngine;

public class PlayerController : MonoBehaviour
{
    public Player player;
    public Transform body;
    public float moveSpeed;
    public int playerDirection;
    public PlayerDataBase data;

    private void Start()
    {
        player = GetComponent<Player>();
        SetDirection();
        SetPosition();

        UEventDispatcherSingleton.Instance.AddEventListener<MenuGame>(PlayerInMenu);
        UEventDispatcherSingleton.Instance.AddEventListener<RestartGame>(PlayerInRestart);
    }

    public void SetPosition()
    {
        this.transform.position = DataInGame.Instance.playerPosition[DataManager.Instance.data.currentMap - 1].position;
    }

    public void SetDirection()
    {
        if(DataManager.Instance.data.currentMap == 10)
        {
            RotateFowardBoss();
            return;
        }

        if(DataManager.Instance.data != null)
        {
            var dataPlayer = GetDataPlayer(DataManager.Instance.data.currentMap);
            playerDirection = dataPlayer.playerDirection;
        }
        
        FlipCharacter();
    }

    public void ChangeDirection(int direction)
    {
        playerDirection = direction;
        FlipCharacter();
    }

    public void FlipCharacter()
    {
        this.transform.rotation = Quaternion.Euler(0, 90 * playerDirection, 0);
    }

    public DataPlayer GetDataPlayer(int currentMapIndex)
    {
        return data.dataPlayers.Find(data => data.numberMap == currentMapIndex);
    }

    public void UpdateAction()
    {
        if(!ConditionManger.Instance.inGame) return;

        if (DataManager.Instance.data.currentMap == 10)
        {
            Player.Instance.followBoss.FollowBoss();
        }
        else
        {
            Player.Instance.executer.SetCurrentState("Walk");
        }
        return;
    }

    void RotateFowardBoss()
    {
        var playerPos = Player.Instance.transform.position.x;
        var bossPos = Boss.Instance.transform.position.x;

        playerDirection = playerPos > bossPos ? -1 : 1;

        FlipCharacter();
    }

    public void PlayerInMenu(IUEventData uEventData)
    {
        player.executer.SetCurrentState("Idle");
    }

    public void PlayerInRestart(IUEventData uEventData)
    {
        ConditionManger.Instance.inGame = true;
        player.executer.SetCurrentState("Walk");
    }
}
