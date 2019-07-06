using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.XR.ARFoundation;
using UnityEngine.Experimental.XR;
using System;
using UnityEngine.EventSystems;
using UnityEngine.UI;
using TrackableType = UnityEngine.XR.ARSubsystems.TrackableType;


public class ARTapToPlaceObject : MonoBehaviour
{
    private Vector2 _screenCenterV2;
    public GameObject objectToPlace;
    public GameObject placementIndicator;
    public CanvasGroup theCanvasGroup;

    public GameObject theGO;

    public Camera ARCamera;

    public Pose theContentLocationPose;

    private ARRaycastManager _raycastManager;
    private Pose _placementPose;
    private bool _placementPoseIsValid;
    private bool _scaleSet;
    private bool _objectSet;

    ARSessionOrigin m_SessionOrigin;

    void Awake()
    {
        m_SessionOrigin = GetComponent<ARSessionOrigin>();
    }

    void Start()
    {
        _screenCenterV2 = new Vector2(0.5f, 0.5f);
        _raycastManager = FindObjectOfType<ARRaycastManager>();
    }

    void Update()
    {
        if (!_objectSet)
        {
            UpdatePlacementPose();

            // Check if there is a touch
            if (Input.touchCount > 0 && Input.GetTouch(0).phase == TouchPhase.Began)
            {
                // Check if finger is over a UI element
                if (EventSystem.current.IsPointerOverGameObject(Input.GetTouch(0).fingerId))
                {
                }
                else
                {
                    PlaceObject();
                    _objectSet = true;
                    placementIndicator.SetActive(false);

                    //If the Canvas isn't needed anymore, then fade it out, otherwise, just disable the Panel leaving
                    //the Scale/Rotate sliders visible.
                    // StartCoroutine(FadeOutCanvas());

                    //After user clicks the placement indicator, now show them the scale and rotate sliders to tweak the placed object
                    GameObject UIPanel = GameObject.FindWithTag("CanvasScalePanel");
                    var sliders = UIPanel.GetComponentsInChildren<Slider>();

                    foreach (Slider _slider in sliders)
                        _slider.interactable = true;
                }
            }
        }
    }


    IEnumerator FadeOutCanvas()
    {
        var _t = 0f;
        var _startTime = Time.time;
        var duration = 1.5f;
        while (_t <= duration)
        {
            theCanvasGroup.alpha = Mathf.SmoothStep(1, 0, _t);
            _t = (Time.time - _startTime) / duration;
            yield return null;
        }

        theCanvasGroup.interactable = false;
        theCanvasGroup.blocksRaycasts = false;
    }


    private void PlaceObject()
    {
        theGO = Instantiate(objectToPlace, _placementPose.position, _placementPose.rotation);
        m_SessionOrigin.MakeContentAppearAt(theGO.transform, _placementPose.position, _placementPose.rotation);
        theContentLocationPose = _placementPose;
    }


    private void UpdatePlacementPose()
    {
        var screenCenter = ARCamera.ViewportToScreenPoint(_screenCenterV2);
        var hits = new List<ARRaycastHit>();

#if UNITY_IOS
        _raycastManager.Raycast(screenCenter, hits, TrackableType.PlaneWithinPolygon | TrackableType.FeaturePoint);
#else
        _raycastManager.Raycast(screenCenter, hits, TrackableType.Planes);
#endif

        _placementPoseIsValid = hits.Count > 0;
        if (_placementPoseIsValid)
        {
            //This contains the default pose, which would point whichever way the camera was at launch.
            _placementPose = hits[0].pose;

            //instead, we want to recalculate the pose rotation based on where the camera is pointing real time
            var cameraForward = Camera.current.transform.forward;
            var cameraBearing = new Vector3(cameraForward.x, 0, cameraForward.z).normalized;
            _placementPose.rotation = Quaternion.LookRotation(cameraBearing);

            placementIndicator.SetActive(true);
            placementIndicator.transform.SetPositionAndRotation(_placementPose.position, _placementPose.rotation);
            theContentLocationPose = _placementPose;
        }
        else
        {
            placementIndicator.SetActive(false);
        }
    }
}