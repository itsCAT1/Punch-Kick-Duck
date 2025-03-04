using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public enum GameState
{
    Menu,
    StartGame,
    InGame,
    EndGame,
    EndGameBoss,
    GameOver,
    SelectCharacter,
    Tutorial
}

public class ConditionManger : Singleton<ConditionManger>
{
    public GameState currentState;

    [Header("UI")]
    public GameObject inGameUI;
    public GameObject endGameUI;
    public GameObject endGameBossUI;
    public GameObject attackUI;
    public GameObject gameOverUI;
    public GameObject pauseGameUI;
    public GameObject buttonPauseUI;
    public GameObject miniBossUI;
    public GameObject bossUI;
    public GameObject menuGameUI;
    public GameObject selectCharactorUI;
    public GameObject tutorialUI;

    void Start()
    {
        UEventDispatcherSingleton.Instance.AddEventListener<MenuGame>(OnMenuGame);
        UEventDispatcherSingleton.Instance.AddEventListener<InGame>(OnInGame);
        UEventDispatcherSingleton.Instance.AddEventListener<StartGame>(OnStartGame);
        UEventDispatcherSingleton.Instance.AddEventListener<EndGame>(OnEndGame);
        UEventDispatcherSingleton.Instance.AddEventListener<EndGameBoss>(OnEndGameBoss);
        UEventDispatcherSingleton.Instance.AddEventListener<GameOver>(OnGameOver);
        UEventDispatcherSingleton.Instance.AddEventListener<CharactorSelection>(OnSelectCharactor);
        UEventDispatcherSingleton.Instance.AddEventListener<Tutorial>(OnTutorial);

        UEventData uEventData = new UEventData();
        UEventDispatcherSingleton.Instance.Invoke<MenuGame>(uEventData);
    }


    public void SetState(GameState newState)
    {
        currentState = newState;
        ActiveCurrentUI();
    }

    void ActiveCurrentUI()
    {
        inGameUI.SetActive(currentState == GameState.StartGame || currentState == GameState.InGame || currentState == GameState.GameOver);
        if (DataManager.Instance.data.showTutorial)
        {
            inGameUI.SetActive(false);
        }

        endGameUI.SetActive(currentState == GameState.EndGame);
        endGameBossUI.SetActive(currentState == GameState.EndGameBoss);
        selectCharactorUI.SetActive(currentState == GameState.SelectCharacter);
        menuGameUI.SetActive(currentState == GameState.Menu);
        attackUI.SetActive(currentState == GameState.InGame || currentState == GameState.StartGame || currentState == GameState.Tutorial);
        tutorialUI.SetActive(currentState == GameState.StartGame || currentState == GameState.Tutorial);
        buttonPauseUI.SetActive(currentState == GameState.StartGame || currentState == GameState.InGame || currentState == GameState.Tutorial);

        miniBossUI.SetActive(currentState == GameState.InGame && DataManager.Instance.data.currentMap > 1 && DataManager.Instance.data.currentMap < 10);
        bossUI.SetActive(currentState == GameState.InGame && DataManager.Instance.data.currentMap == 10);
    }

    void OnMenuGame(IUEventData uEvent)
    {
        SetState(GameState.Menu);
    }

    void OnStartGame(IUEventData uEvent)
    {
        SetState(GameState.StartGame);
    }

    void OnInGame(IUEventData uEvent)
    {
        SetState(GameState.InGame);
    }

    void OnGameOver(IUEventData uEvent)
    {
        SetState(GameState.GameOver);
    }

    void OnEndGame(IUEventData uEvent)
    {
        SetState(GameState.EndGame);
    }

    void OnEndGameBoss(IUEventData uEvent)
    {
        SetState(GameState.EndGameBoss);
    }

    void OnSelectCharactor(IUEventData uEvent)
    {
        SetState(GameState.SelectCharacter);
    }

    void OnTutorial(IUEventData uEvent)
    {
        SetState(GameState.Tutorial);
    }
}