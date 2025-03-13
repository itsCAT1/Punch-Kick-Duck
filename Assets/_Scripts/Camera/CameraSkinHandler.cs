using Cinemachine;
using DG.Tweening;
using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEngine;

public class CameraSkinHandler : Singleton<CameraSkinHandler>
{
    [Header ("Skin Infor")]
    public Transform[] skin;
    public BoxHandler[] boxes;
    public int currentIndex;
    public AudioSource soundOnSelected;

    [Header ("Movement")]
    public float swipeSpeed = 10f;
    public float minVelocityToSnap = 0.1f;
    public float decelerationRate = 0.95f;
    public float snapDuration = 0.5f;
    Vector3 velocity;

    [Header("Condition")]
    Vector2 mouseStartPos;
    bool isDragging = false;
    float targetX, minX, maxX;
    public bool canMove;

    private void OnEnable()
    {
        PositionOnStart();
        canMove = true;
    }

    private void Start()
    {
        PositionLimit();
    }


    void PositionLimit()
    {
        if (skin.Length > 0)
        {
            minX = skin[0].position.x - 2;
            maxX = skin[skin.Length - 1].position.x + 2;
        }
    }

    void PositionOnStart()
    {
        int indexSkin = DataManager.Instance.data.currentSkin;
        this.transform.position = skin[indexSkin].position + new Vector3(0, 4, -9);
    }

    void Update()
    {
        if(canMove)
        HandleMouseInput();
    }

    void HandleMouseInput()
    {
        if (Input.GetMouseButtonDown(0))
        {
            mouseStartPos = Input.mousePosition;
            isDragging = true;
            DOTween.Kill(transform);
        }

        if (Input.GetMouseButton(0) && isDragging)
        {
            Vector2 mouseDir = ((Vector2)Input.mousePosition - mouseStartPos).normalized;
            velocity.x = -mouseDir.x * swipeSpeed;
        }

        CameraMoving();
    }

    void CameraMoving()
    {
        if (Input.GetMouseButtonUp(0))
        {
            isDragging = false;
        }

        if (!isDragging && Mathf.Abs(velocity.x) < minVelocityToSnap)
        {
            StartSnap();
        }

        if (!isDragging)
        {
            velocity *= decelerationRate;
        }

        transform.position += velocity * Time.deltaTime;
        LimitCameraPosition();
    }

    void FindNearestItem()
    {
        float minDistance = 100;
        int newIndex = 0;

        for (int i = 0; i < skin.Length; i++)
        {
            float distance = Mathf.Abs(transform.position.x - skin[i].position.x);
            if (distance < minDistance)
            {
                minDistance = distance;
                newIndex = i;
            }
        }

        if (currentIndex != newIndex)
        {
            if (currentIndex > 1 && !SkinManager.Instance.CheckSkin(currentIndex))
            {
                boxes[currentIndex].MoveBack();
                Debug.Log("back" + currentIndex);
            }

            currentIndex = newIndex;
            targetX = skin[currentIndex].position.x;

            CharacterSelectionHandler.Instance.UpdateUI();
            soundOnSelected.Play();

            if (currentIndex > 1 && !SkinManager.Instance.CheckSkin(currentIndex))
            {
                boxes[currentIndex].MoveFoward();
                Debug.Log("foward" + currentIndex);
            }
        }
    }


    void StartSnap()
    {
        FindNearestItem();

        transform.DOMoveX(targetX, snapDuration).OnComplete(() =>
        {
            velocity = Vector3.zero;
        });
    }

    void LimitCameraPosition()
    {
        float clampedX = Mathf.Clamp(transform.position.x, minX, maxX);
        transform.position = new Vector3(clampedX, transform.position.y, transform.position.z);

        if (transform.position.x <= minX || transform.position.x >= maxX)
        {
            velocity = Vector3.zero;
        }
    }


    public void DisableMove()
    {
        canMove = false;
    }

    public void EnableMove()
    {
        canMove = true;
    }
}
