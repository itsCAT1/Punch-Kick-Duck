using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CoinDroped : ObjectJumping
{
    public Vector3 offset;

    void Start()
    {
        DropCoin();
    }

    void DropCoin()
    {
        var targetX = this.transform.position.x + offset.x * Player.Instance.controller.playerDirection;
        PerformJumping(new Vector3(targetX, 0, 0));
    }

    private void OnCollisionEnter(Collision collision)
    {
        if (collision.gameObject.CompareTag("Player"))
        {
            DataManager.Instance.data.totalCoin++;
            Destroy(this.gameObject);
        }
    }
}