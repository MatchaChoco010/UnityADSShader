using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CreateTriangleWithColor : MonoBehaviour {

	void Start () {
		var mesh = new Mesh ();

		var vertices = new List<Vector3> {
			new Vector3 (-1, 0, 0),
			new Vector3 (0, 1, 0),
			new Vector3 (1, 0, 0),
		};
		mesh.SetVertices (vertices);

		var triangles = new List<int> { 0, 1, 2 };
		mesh.SetTriangles (triangles, 0);

		var colors = new List<Color> {
			Color.red,
			Color.blue,
			Color.green,
		};
		mesh.SetColors (colors);

		var meshFilter = GetComponent<MeshFilter> ();
		meshFilter.mesh = mesh;
	}

}
