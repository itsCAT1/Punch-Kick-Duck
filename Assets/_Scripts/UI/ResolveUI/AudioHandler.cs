using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Audio;
using UnityEngine.UI;

public class AudioHandler : MonoBehaviour
{
    public Image musicFill;
    public Image soundFill;

    private void OnEnable()
    {
        UpdateFillProgress();
    }

    void UpdateFillProgress()
    {
        musicFill.fillAmount = DataManager.Instance.data.musicVolume;
        soundFill.fillAmount = DataManager.Instance.data.soundVolume;
    }


    public void IncreaseMusicVolume()
    {
        float volume = DataManager.Instance.data.musicVolume;

        volume += 0.199f;

        if (volume > 1)
        {
            volume = 0.001f;
        }

        float db = Mathf.Log10(volume) * 20;
        AudioManager.Instance.audioMixer.SetFloat("MusicVolume", db);

        DataManager.Instance.data.musicVolume = volume;
        UpdateFillProgress();
    }

    public void IncreaseSoundVolume()
    {
        float volume = DataManager.Instance.data.soundVolume;

        volume += 0.199f;

        if (volume > 1)
        {
            volume = 0.001f;
        }

        float db = Mathf.Log10(volume) * 20;
        AudioManager.Instance.audioMixer.SetFloat("SoundVolume", db);

        DataManager.Instance.data.soundVolume = volume;
        UpdateFillProgress();
    }
}
