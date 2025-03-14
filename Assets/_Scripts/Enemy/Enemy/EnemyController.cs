﻿using FSMC.Runtime;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnemyController : MonoBehaviour
{
    Enemy enemy;

    [Header("Raycast Detect")] 
    public Transform rayDetect;
    public LayerMask charactorLayer;

    [Header("Enemy Type")]
    public bool haveBottle, haveCart;

    [Header("Size Attack")]
    public float currentRange;
    public bool canAttack = true;
    float distance;

    [Header("Hit Effect")]
    public GameObject hitVFXPrefab;
    public Transform hitPosition;

    private void Start()
    {
        enemy = GetComponent<Enemy>();
    }

    private void Update()
    {
        UpdateAction();
    }

    public void UpdateAction()
    {
        if (enemy.executer.GetCurrentState() == null || !canAttack) return;

        bool aimingRay = Physics.Raycast(rayDetect.transform.position, rayDetect.transform.forward, out RaycastHit Infor, currentRange, charactorLayer);

        if(Infor.collider != null)
        {
            distance = Vector3.Distance(transform.position, Infor.collider.transform.position);
        }
        
        if (aimingRay)
        {
            if (Infor.collider.CompareTag("Player") && distance < currentRange - 0.2f)
            {
                Attack();
            }
            else if (Infor.collider.CompareTag("Enemy") && distance < currentRange - 0.2f)
            {
                enemy.executer.SetCurrentState("Idle");
            }
        }
        else
        {
            if (ConditionManger.Instance.currentState == GameState.InGame)
            {
                enemy.executer.SetCurrentState("Walk");
            }
            if (ConditionManger.Instance.currentState == GameState.Tutorial)
            {
                enemy.tutorial.UpdateEnemyState();
            }
        }
    }

    public void Attack()
    {
        if (haveBottle)
        {
            enemy.executer.SetCurrentState("Throw");
        }
        else
        {
            enemy.executer.SetCurrentState("Attack");
        }
    }

    void Idle()
    {
        enemy.rigid.velocity = Vector3.zero;
        enemy.controller.Standing();

        enemy.rigid.isKinematic = true;

        Standing();
    }

    public void Standing()
    {
        enemy.animator.SetBool("Walking", false);
        enemy.animator.SetBool("HaveCart", false);
    }

    public void Moving()
    {
        SetWalkingType();
    }

    public void SetWalkingType()
    {
        if (haveCart)
        {
            enemy.animator.SetBool("HaveCart", true);
            enemy.animator.SetBool("Walking", false);
        }
        else
        {
            enemy.animator.SetBool("HaveCart", false);
            enemy.animator.SetBool("Walking", true);
        }
    }

    private void OnTriggerEnter(Collider other)
    {
        if (other.gameObject.CompareTag("OpenableDoor"))
        {
            enemy.apear.enabled = true;
        }
    }

    private void OnCollisionEnter(Collision collision)
    {
        if (collision.gameObject.CompareTag("Boss"))
        {
            enemy.health.TakeDamage();
            Instantiate(hitVFXPrefab, hitPosition.position, Quaternion.identity);
        }
    }
}
