unity-volume-sampler
=====================

Mesh volume sampler with voxelizer & 3D poisson disk sampling for Unity.

![Demo](https://raw.githubusercontent.com/mattatz/unity-volume-sampler/master/Captures/Demo.gif)

## Usage

```cs

// Volume instance has sample points & grid information (grid size & unit length).
Volume volume = VolumeSampler.Sample(
    mesh,       // mesh to sample volume
    resolution, // grid resolution
    distance    // minimum distance between samples
);

```

## VolumeSamplerWindow

Menu : Window -> VolumeSampler

<img src="https://raw.githubusercontent.com/mattatz/unity-volume-sampler/master/Captures/VolumeSamplerWindow.png">

VolumeSamplerWindow builds a Volume asset from a mesh file & save it in a project.

## Compatibility

Tested on Unity 2018.3.0f2, windows10.

## Sources

- mattatz/unity-voxel - https://github.com/mattatz/unity-voxel
- njanakiev/poisson-disk-sampling - https://github.com/njanakiev/poisson-disk-sampling
- keijiro/Pcx - https://github.com/keijiro/Pcx/blob/master/Assets/Pcx/Runtime/Shaders/Disk.cginc
