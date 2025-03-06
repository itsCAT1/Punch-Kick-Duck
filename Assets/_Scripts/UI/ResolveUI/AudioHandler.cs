using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Audio;

public class AudioHandler : MonoBehaviour
{
    public void IncreaseAudio(string audioGroup)
    {
        AudioManager.Instance.audioMixer.GetFloat(audioGroup, out float dB);

        // Chuyển dB về volume (0 - 1)
        float volume = Mathf.Pow(10, dB / 20);

        // Tăng âm lượng
        volume += 0.19f; // Điều chỉnh giá trị tăng

        // Giới hạn volume từ 0.001 - 1
        if (volume > 1)
        {
            volume = 0.001f; // Reset nếu vượt quá 1
        }

        // Chuyển volume về dB và đặt giá trị mới
        float newDb = Mathf.Log10(volume) * 20;
        AudioManager.Instance.audioMixer.SetFloat(audioGroup, newDb);
    }
}
