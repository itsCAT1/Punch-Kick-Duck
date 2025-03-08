using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEngine;

public class CartHandler : ColliderHandler
{
    bool hasColidered = false;
    Enemy enemy;
    public AudioSource soundCartMove, soundCartHit, soundCartReflect;
    bool isPlaying;

    void Start()
    {
        enemy = GetComponentInParent<Enemy>();
    }

    

    private void Update()
    {
        PlaySoundCart();
    }

    void PlaySoundCart()
    {
        var currentState = enemy.executer.GetCurrentState().Name.ToString();

        var distance = Vector3.Distance(enemy.transform.position, Player.Instance.transform.position);

        if (enemy.controller.haveCart)
        {
            if (currentState == "Walk" && distance <= 15)
            {
                if (!soundCartMove.isPlaying)
                {
                    soundCartMove.Play();
                }
            }
            else
            {
                if (soundCartMove.isPlaying) 
                {
                    soundCartMove.Stop();
                }
            }
        }


        else
        {
            soundCartMove.Stop();
        }
    }

    private void OnTriggerEnter(Collider other)
    {
        if (other.gameObject.CompareTag("Player") && !hasColidered)
        {
            hasColidered = true;
            enemy.controller.haveCart = false;
            PlayerOnHit();
            ObjectOnHit();
            soundCartHit.Play();
        }

        if (other.gameObject.CompareTag("Punch") || other.gameObject.CompareTag("Kick") || other.gameObject.CompareTag("Duck"))
        {
            enemy.controller.haveCart = false;
            enemy.executer.SetCurrentState("GoBack");
            ObjectOnHit();
            soundCartReflect.Play();
        }

        if (other.gameObject.CompareTag("Enemy"))
        {
            enemy.executer.SetCurrentState("GoBack");
        }
    }
}
