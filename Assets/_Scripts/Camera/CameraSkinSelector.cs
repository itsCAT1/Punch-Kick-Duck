using DG.Tweening;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraSkinSelector : MonoBehaviour
{
    public Transform[] skin;
    public float swipeSpeed = 10f;
    public float minVelocityToSnap = 0.1f;
    public float decelerationRate = 0.95f;
    public float snapDuration = 0.5f;
    public int currentIndex;

    Vector2 mouseStartPos;
    bool isDragging = false;
    bool isSnapping = false;
    float targetX;
    Vector3 velocity;

    float minX;
    float maxX;


    private void Start()
    {
        if (skin.Length > 0)
        {
            minX = skin[0].position.x - 2;
            maxX = skin[skin.Length - 1].position.x + 2;
        }

        PositionOnStart();
    }

    void PositionOnStart()
    {
        this.transform.position = skin[DataManager.Instance.data.currentSkin].position + new Vector3(0, 4, -9);
    }

    void Update()
    {
        HandleMouseInput();

        if (!isDragging && Mathf.Abs(velocity.x) < minVelocityToSnap)
        {
            StartSnap();
        }

        if (!isDragging && !isSnapping)
        {
            velocity *= decelerationRate;
        }

        if (!isDragging)
        {
            transform.position += velocity * Time.deltaTime;
        }

        LimitCameraPosition();
    }

    void HandleMouseInput()
    {
        if (Input.GetMouseButtonDown(0))
        {
            mouseStartPos = Input.mousePosition;
            isDragging = true;
            isSnapping = false;
            DOTween.Kill(transform);
        }

        if (Input.GetMouseButton(0) && isDragging)
        {
            Vector2 mouseDir = (Vector2)Input.mousePosition - mouseStartPos;
            velocity.x = -mouseDir.x * swipeSpeed * Time.deltaTime;
        }

        if (Input.GetMouseButtonUp(0))
        {
            isDragging = false;
        }
    }

    void FindNearestItem()
    {
        float minDistance = 100;
        int nearestIndex = 0;

        for (int i = 0; i < skin.Length; i++)
        {
            float distance = Mathf.Abs(transform.position.x - skin[i].position.x);
            if (distance < minDistance)
            {
                minDistance = distance;
                nearestIndex = i;
            }
        }

        currentIndex = nearestIndex;
        targetX = skin[currentIndex].position.x;

    }

    void StartSnap()
    {
        FindNearestItem();
        isSnapping = true;

        transform.DOMoveX(targetX, snapDuration).OnComplete(() =>
        {
            isSnapping = false;
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
}
