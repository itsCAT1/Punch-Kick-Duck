using Cinemachine;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class test : MonoBehaviour
{
    public Transform cameraTarget;  // Đối tượng làm điểm follow
    public Transform[] itemPositions; // Danh sách vị trí items
    public float swipeSpeed = 0.5f;  // Tốc độ vuốt
    public float inertiaDamping = 0.5f;  // Hệ số giảm tốc
    public float snapSpeed = 2f;  // Tốc độ căn chỉnh về giữa
    public float minX, maxX;  // Giới hạn trục X

    private float velocity = 0f;
    public bool isSnapping = false;

    void Update()
    {
        if (Input.GetMouseButton(0))  // Khi vuốt màn hình
        {
            float deltaX = -Input.GetAxis("Mouse X") * swipeSpeed;
            cameraTarget.position += Vector3.right * deltaX;
            cameraTarget.position = new Vector3(Mathf.Clamp(cameraTarget.position.x, minX, maxX), cameraTarget.position.y, cameraTarget.position.z);
            velocity = deltaX;
        }
        else
        {

            velocity = Mathf.Lerp(velocity, 0, Time.deltaTime * inertiaDamping);
            cameraTarget.position += Vector3.right * velocity;

            // Khi tốc độ gần bằng 0, tự căn chỉnh về item gần nhất
            if (velocity < 0.01f && !isSnapping)
            {
                //StartCoroutine(SnapToClosestItem());
            }
        }
    }

    IEnumerator SnapToClosestItem()
    {
        isSnapping = true;
        float closestX = FindClosestItemX();

        while (Mathf.Abs(cameraTarget.position.x - closestX) > 0.01f)
        {
            cameraTarget.position = new Vector3(Mathf.Lerp(cameraTarget.position.x, closestX, Time.deltaTime * snapSpeed), cameraTarget.position.y, cameraTarget.position.z);
            yield return null;
        }

        isSnapping = false;
    }

    float FindClosestItemX()
    {
        float closestX = itemPositions[0].position.x;
        Debug.Log(closestX);
        float minDist = Mathf.Abs(closestX - cameraTarget.position.x);

        foreach (var item in itemPositions)
        {
            float dist = Mathf.Abs(item.position.x - cameraTarget.position.x);
            if (dist < minDist)
            {
                minDist = dist;
                closestX = item.position.x;
            }
        }
        return closestX;
    }
}
