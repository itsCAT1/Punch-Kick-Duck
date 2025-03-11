using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ButtonSoundEffect : MonoBehaviour
{
    public AudioSource soundEffect;

    public void OnClick()
    {
        soundEffect.Play();
    }
}
