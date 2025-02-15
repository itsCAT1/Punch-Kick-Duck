using FSMC.Runtime;
using RMC.Core.UEvents;
using RMC.Core.UEvents.UEventDispatcher;
using System.Collections;
using System.Collections.Generic;
using UnityEditor;
using UnityEngine;

public class PlayerController : MonoBehaviour
{
    public Rigidbody rigid;
    public Animator animator;

    public Transform body;
    public float moveSpeed;
    public int playerDirection;
    
    public FSMC_Executer executer;

    public ListDataPlayer data;

    private void Start()
    {
        rigid = GetComponent<Rigidbody>();
        SetDirection();
        SetPosition();

        UEventDispatcherSingleton.Instance.AddEventListener<RestartGame>(ResetPlayer);
    }

    public void SetPosition()
    {
        this.transform.position = DataInGame.Instance.playerPosition[DataManager.Instance.data.currentMap - 1].position;
    }

    public void SetDirection()
    {
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
        rigid.velocity = Vector3.zero;
        executer.SetCurrentState("Walk");
    }
}
