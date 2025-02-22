using RMC.Core.UEvents;
using RMC.Core.UEvents.UEventDispatcher;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PKDHandler : MonoBehaviour
{
    Rigidbody rigid;
    public float forcePush;

    public 

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
        if(Vector3.Distance(Camera.main.transform.position, Player.Instance.transform.position) >= 20 && ConditionManger.Instance.inGame)
        {
            Destroy(this.gameObject);
        }
    }

    private void OnTriggerEnter(Collider other)
    {


        if((other.gameObject.CompareTag("Punch") || other.gameObject.CompareTag("Kick") || other.gameObject.CompareTag("Duck")) 
            && !ConditionManger.Instance.inGame)
        {
            UEventData uEventData = new UEventData();
            UEventDispatcherSingleton.Instance.Invoke<InGame>(uEventData);
        }
    }

    void PushAll(IUEventData uEventData)
    {
        PerformPushing();
    }
}
