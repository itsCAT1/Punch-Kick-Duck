using FSMC.Runtime;
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

    void Awake()
    {
        rigid = GetComponent<Rigidbody>();
        DirectionOnStart();
    }

    void DirectionOnStart()
    {
        var dataPlayer = GetDataPlayer(DataBase.Instance.currentMap);
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

    public DataPlayerBase GetDataPlayer(int currentMapIndex)
    {
        return data.dataPlayers.Find(data => data.numberMap == currentMapIndex);
    }
}
