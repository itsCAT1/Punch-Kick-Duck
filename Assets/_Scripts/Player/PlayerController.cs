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
    
    public float inputHorizontal;
    public FSMC_Executer executer;

    public ListDataPlayer data;
    public int currentMapIndex;


    void Awake()
    {
        rigid = GetComponent<Rigidbody>();
        DirectionOnStart();
    }

    

    private void FixedUpdate()
    {
        PerformMove();
    }

    void PerformMove()
    {
        inputHorizontal = Input.GetAxisRaw("Horizontal");
        rigid.velocity = new Vector3(moveSpeed * playerDirection, rigid.velocity.y, rigid.velocity.z);
    }

    private void Update()
    {
        FlipCharacter();
    }

    public void ChangeDirection(int direction)
    {
        playerDirection = direction;
        FlipCharacter();
    }

    void DirectionOnStart()
    {
        var direction = data.dataPlayers.Find(data => data.numberMap == currentMapIndex);
        playerDirection = direction.playerDirection;

        //FlipCharacter();
    }

    void FlipCharacter()
    {
        Player.Instance.transform.rotation = Quaternion.Euler(0, 90 * playerDirection, 0);
    }
}
