using RMC.Core.UEvents;
using RMC.Core.UEvents.UEventDispatcher;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Audio;

public class AudioManager : Singleton<AudioManager>
{
    [Header("General")]
    public AudioMixer audioMixer;
    public AudioSource musicInGame;
    public AudioSource musicTutorial;

    [Header("Player")]
    public AudioSource playerPunch;
    public AudioSource playerKick;
    public AudioSource playerDuck;
    public AudioSource playerBlock;
    public AudioSource collectCoin;
    public AudioSource heartReached;
    public AudioSource bonusPointReached;

    private void Start()
    {
        GetDataAudio("MusicVolume", DataManager.Instance.data.musicVolume);
        GetDataAudio("SoundVolume", DataManager.Instance.data.soundVolume);

        UEventDispatcherSingleton.Instance.AddEventListener<StartGame>(PlayMusic);
        UEventDispatcherSingleton.Instance.AddEventListener<MenuGame>(StopMusic);
        UEventDispatcherSingleton.Instance.AddEventListener<RestartGame>(OnRestart);
    }

    void GetDataAudio(string audioGroup, float volume)
    {
        audioMixer.SetFloat(audioGroup, Mathf.Log10(volume) * 20);
    }

    void PlayMusic(IUEventData uEventData)
    {
        if (DataManager.Instance.data.showTutorial)
        {
            musicTutorial.Play();
        }
        else
        {
            musicInGame.Play();
        }
    }

    void StopMusic(IUEventData uEventData)
    {
        musicTutorial.Stop();
        musicInGame.Stop();
    }

    void OnRestart(IUEventData uEventData)
    {
        if (DataManager.Instance.data.showTutorial)
        {
            musicTutorial.Stop();
            musicInGame.Play();
        }
    }

    public void PauseGame()
    {
        musicTutorial.Pause();
        musicInGame.Pause();
    }

    public void ContinueGame()
    {
        musicTutorial.UnPause();
        musicInGame.UnPause();
    }
}
