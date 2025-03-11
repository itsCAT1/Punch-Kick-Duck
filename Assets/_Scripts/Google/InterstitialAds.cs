using RMC.Core.UEvents;
using RMC.Core.UEvents.UEventDispatcher;
using UnityEngine;
using UnityEngine.Advertisements;
using UnityEngine.Purchasing;

public class InterstitialAds : MonoBehaviour, IUnityAdsLoadListener, IUnityAdsShowListener
{
    [SerializeField] string _androidAdUnitId = "Interstitial_Android";
    [SerializeField] string _iOsAdUnitId = "Interstitial_iOS";
    string _adUnitId;

    int noADS;
    public int adsCount;

    void Awake()
    {
        // Get the Ad Unit ID for the current platform:
        _adUnitId = (Application.platform == RuntimePlatform.IPhonePlayer)
            ? _iOsAdUnitId
            : _androidAdUnitId;
    }

    private void Start()
    {
        UEventDispatcherSingleton.Instance.AddEventListener<PlayerDeath>(ShowAd);
    }

    // Load content to the Ad Unit:
    public void LoadAd()
    {
        // IMPORTANT! Only load content AFTER initialization (in this example, initialization is handled in a different script).
        Debug.Log("Loading Ad: " + _adUnitId);
        Advertisement.Load(_adUnitId, this);
    }

    // Show the loaded content in the Ad Unit:
    public void ShowAd(IUEventData uEventData)
    {
        adsCount++;

        if (adsCount > 3)
        {
            adsCount = 0;

            if (noADS == 1)
            {
                Debug.Log("Ads have been removed, not load");
                return;
            }
            // Note that if the ad content wasn't previously loaded, this method will fail
            Debug.Log("Showing Ad: " + _adUnitId);
            Advertisement.Show(_adUnitId, this);
        }
    }

    // Implement Load Listener and Show Listener interface methods: 
    public void OnUnityAdsAdLoaded(string adUnitId)
    {
        // Optionally execute code if the Ad Unit successfully loads content.
    }

    public void OnUnityAdsFailedToLoad(string adUnitId, UnityAdsLoadError error, string message)
    {
        Debug.Log($"Error loading Ad Unit: {adUnitId} - {error.ToString()} - {message}");
        // Optionally execute code if the Ad Unit fails to load, such as attempting to try again.
    }

    public void OnUnityAdsShowFailure(string adUnitId, UnityAdsShowError error, string message)
    {
        Debug.Log($"Error showing Ad Unit {adUnitId}: {error.ToString()} - {message}");
        // Optionally execute code if the Ad Unit fails to show, such as loading another ad.
    }

    public void OnUnityAdsShowStart(string adUnitId) { }
    public void OnUnityAdsShowClick(string adUnitId) { }
    public void OnUnityAdsShowComplete(string adUnitId, UnityAdsShowCompletionState showCompletionState)
    {
        LoadAd();
    }

    public void RemoveADS()
    {
        noADS = 1;
    }

    private void OnEnable()
    {
        LoadDataADS();
    }

    private void OnApplicationQuit()
    {
        SaveDataADS();
    }

    public void SaveDataADS()
    {
        PlayerPrefs.SetInt("NoAds", noADS);
        PlayerPrefs.Save();
    }

    public void LoadDataADS()
    {
        PlayerPrefs.GetInt("NoAds", noADS);

    }
}