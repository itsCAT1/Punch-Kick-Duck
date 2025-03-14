using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CoinDroped : ObjectPushing
{
    public Vector3 offset;
    public GameObject collectEffect;

    void Start()
    {
        SetDirection();
    }

    void SetDirection()
    {
        int direction = (this.transform.position.x > Player.Instance.transform.position.x) ? 1 : -1;
        if(DataManager.Instance.data.currentMap == 10) direction = -direction;

        DropCoin(direction);
    }

    public void DropCoin(int direction)
    {
        var currentPosition = this.transform.position;

        var target = new Vector3(currentPosition.x + offset.x * direction, currentPosition.y + offset.y, currentPosition.z);
        PerformJumping(target);
    }

    void CreateEffect()
    {
        Instantiate(collectEffect);
        AudioManager.Instance.collectCoin.Play();
    }

    private void OnCollisionEnter(Collision collision)
    {
        if (collision.gameObject.CompareTag("Player"))
        {
            DataManager.Instance.data.totalCoin++;
            InGameManager.Instance.coin.UpdateCoin();
            CreateEffect();
            Destroy(this.gameObject);
        }
    }
}