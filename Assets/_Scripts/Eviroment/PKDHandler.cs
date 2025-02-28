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
            if (player.CompareTag("Punch") && type == "Punch" && TutorialManager.Instance.hasPunched)
            {
                TutorialManager.Instance.hasPunched = false;
                TutorialManager.Instance.hasKicked = true;
                PerformPushing();
            }
            if (player.CompareTag("Kick") && type == "Kick" && TutorialManager.Instance.hasKicked)
            {
                TutorialManager.Instance.hasKicked = false;
                TutorialManager.Instance.hasDucked = true;
                PerformPushing();
            }
            if (player.CompareTag("Duck") && type == "Duck" && TutorialManager.Instance.hasDucked)
            {
                TutorialManager.Instance.hasDucked = false;
                PerformPushing();
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

    void PushAll(IUEventData uEventData)
    {
        PerformPushing();
    }
}
