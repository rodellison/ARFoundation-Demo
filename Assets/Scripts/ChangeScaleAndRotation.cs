using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.XR.ARFoundation;

[RequireComponent(typeof(ARSessionOrigin))]
public class ChangeScaleAndRotation : MonoBehaviour
{

    private ARSessionOrigin _sessionOrigin;
    private ARTapToPlaceObject myARTTPO;
    private Vector3 _newScale;
    private Quaternion _newRotation;

    private void Start()
    {
       _newScale = new Vector3();
       _newRotation = new Quaternion();
       _sessionOrigin = GetComponent<ARSessionOrigin>();
       myARTTPO = GetComponent<ARTapToPlaceObject>();
    }

    public void SetScale(float _scaleValue)
    {
        _newScale.x = _scaleValue;
        _newScale.y = _scaleValue;
        _newScale.z = _scaleValue;
        _sessionOrigin.transform.localScale = _newScale;

        if (myARTTPO.theGO != null)
        {
            _sessionOrigin.MakeContentAppearAt(myARTTPO.theGO.transform, myARTTPO.theContentLocationPose.position);
        }
    }
    
    public void SetRotation(float _rotationValue)
    {
        _newRotation = Quaternion.AngleAxis(_rotationValue, Vector3.up);
        _sessionOrigin.transform.localRotation = _newRotation;

    }
}
