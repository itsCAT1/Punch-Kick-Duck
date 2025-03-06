using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Audio;

public class AudioManager : Singleton<AudioManager>
{
    public AudioMixer audioMixer;

    public AudioSource soundPunch;
    public AudioSource soundKick;
    public AudioSource soundDuck;
}
