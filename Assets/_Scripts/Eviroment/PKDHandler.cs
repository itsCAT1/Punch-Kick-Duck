using RMC.Core.UEvents;
using RMC.Core.UEvents.UEventDispatcher;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PKDHandler : MonoBehaviour
{
    Rigidbody rigid;
    public float forcePush;

    bool canPush = true;
    public string type;

    float timeCount = 0;
    public float maxTime = 0.5f;

    void Start()
    {
        this.rigid = GetComponent<Rigidbody>();
        UEventDispatcherSingleton.Instance.AddEventListener<InGame>(PushAll);
    }

    public void PerformPushing()
    {
        rigid.AddForce(new Vector3(Player.Instance.controller.playerDirection * 5, 2, Random.Range(1, 3)) * forcePush);
    }

    private void Update()
    {
        SelfDestroy();
    }

    void SelfDestroy()
    {
        if(Vector3.Distance(Camera.main.transform.position, Player.Instance.transform.position) >= 20 
            && ConditionManger.Instance.currentState == GameState.InGame)
        {
            Destroy(this.gameObject);
        }
    }

    private void OnTriggerEnter(Collider other)
    {
        var player = other.gameObject;

        if (DataManager.Instance.data.showTutorial)
        {
            forcePush = 500;

            if (player.CompareTag("Punch") && type == "Punch" && TutorialManager.Instance.currentState == TutorialState.Punch && canPush)
            {
                canPush = false;
                PerformPushing();
                TutorialManager.Instance.ChangeState();
            }

            else if (player.CompareTag("Kick") && type == "Kick" && TutorialManager.Instance.currentState == TutorialState.Kick && canPush)
            {
                canPush = false;
                PerformPushing();
                TutorialManager.Instance.ChangeState();
            }

            else if(player.CompareTag("Duck") && type == "Duck" && TutorialManager.Instance.currentState == TutorialState.Duck && canPush)
            {
                canPush = false;
                PerformPushing();
                TutorialManager.Instance.ChangeState();

                UEventData uEventData = new UEventData();

                if(DataManager.Instance.data.currentMap == 10)
                {
                    DataManager.Instance.data.showTutorial = false;

                    UEventDispatcherSingleton.Instance.Invoke<InGame>(uEventData);
                }
                else UEventDispatcherSingleton.Instance.Invoke<Tutorial>(uEventData);
            }

            return;
        }

        if((player.CompareTag("Punch") || player.CompareTag("Kick") || player.CompareTag("Duck"))
            && canPush)
        {
            canPush = false;
            UEventData uEventData = new UEventData();
            UEventDispatcherSingleton.Instance.Invoke<InGame>(uEventData);
        }
    }

    private void OnCollisionStay(Collision collision)
    {
        if (collision.gameObject.CompareTag("Player"))
        {
            DisableCollision();
        }
    }

    void DisableCollision()
    {
        timeCount += Time.deltaTime;
        if (timeCount >= maxTime && this.transform.position.y <= Player.Instance.transform.position.y + 0.2)
        {
            rigid.velocity = Vector3.zero;
            rigid.useGravity = false;
            GetComponent<Collider>().enabled = false;
        }
    }

    void PushAll(IUEventData uEventData)
    {
        PerformPushing();
    }
}
