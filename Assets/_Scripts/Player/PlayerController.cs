using FSMC.Runtime;
using RMC.Core.UEvents;
using RMC.Core.UEvents.UEventDispatcher;
using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEditor;
using UnityEditor.PackageManager;
using UnityEngine;

public class PlayerController : MonoBehaviour
{
    public Player player;
    public Transform body;
    public float moveSpeed;
    public int playerDirection;
    public ListDataPlayer data;

    public float distanceAttack;

    public bool reachedDoor;
    private void Start()
    {
        player = GetComponent<Player>();
        SetDirection();
        SetPosition();

        UEventDispatcherSingleton.Instance.AddEventListener<RestartGame>(ResetPlayer);
    }

    private void Update()
    {
        if (Input.GetKeyDown(KeyCode.S))
        {
            player.executer.SetCurrentState("Walk");
        }
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

        var dataPlayer = GetDataPlayer(DataManager.Instance.data.currentMap);
        playerDirection = dataPlayer.playerDirection;
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

    public void ResetPlayer(IUEventData uEventData)
    {
        player.rigid.velocity = Vector3.zero;
        player.executer.SetCurrentState("Walk");
    }

    public void UpdateAction()
    {
        if(!ConditionManger.Instance.startGame) return;

        if (DataManager.Instance.data.currentMap == 10)
        {
            if(reachedDoor)
            {
                Player.Instance.executer.SetCurrentState("Idle");
                return;
            }

            float distance = Vector3.Distance(Player.Instance.transform.position, Boss.Instance.transform.position);
            SetState(distance);
        }
        else
        {
            Player.Instance.executer.SetCurrentState("Walk");
        }
        return;
    }

    void SetState(float distance)
    {
        if (distance > distanceAttack + 0.2f)
        {
            Player.Instance.executer.SetCurrentState("Walk");
        }
        else if (distance < distanceAttack + 0.2f)
        {
            Player.Instance.executer.SetCurrentState("Idle");
        }
    }

    void RotateFowardBoss()
    {
        var playerPos = Player.Instance.transform.position.x;
        var bossPos = Boss.Instance.transform.position.x;

        playerDirection = playerPos > bossPos ? -1 : 1;

        FlipCharacter();
    }
}
