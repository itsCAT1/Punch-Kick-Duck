using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BossMovement : MonoBehaviour
{
    public float speedMove;

    void Start()
    {
        
    }

    private void Update()
    {
        //MoveTowardsPlayer();
    }

    public void MoveTowardsPlayer()
    {
        var playerPos = Player.Instance.transform.position;

        var direction = (playerPos - transform.position).normalized;
        transform.rotation = Quaternion.LookRotation(direction);

        transform.position = Vector3.MoveTowards(this.transform.position, playerPos, speedMove * Time.deltaTime);
    }
}
