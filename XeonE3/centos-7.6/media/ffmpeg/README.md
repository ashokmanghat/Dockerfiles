This docker image is part of Open Visual Cloud software stacks. Optimized for the media creation and delivery use case. Included FFmpeg and codecs such as aac, opus, ogg, vorbis, x264, x265, vp8/9, av1 and SVT-HEVC, also included Intel hardware accelaration software stack such as media driver, media SDK, gmmlib and libva. The docker image can be used to invoke FFmpeg commands or be used in the FROM field of a downstream Dockerfile. 

## Supported tags and respective Dockerfile links
 - [xeone3-centos-76-media-ffmpeg](https://github.com/OpenVisualCloud/Dockerfiles/blob/master/XeonE3/centos-7.6/media/ffmpeg/Dockerfile)

## Quick reference
- #### Supported platform and OS
Intel&reg; Xeon&reg; E3 platform, CentOS-7.6.1810

- #### Included components:
[FFmpeg](https://github.com/OpenVisualCloud/Dockerfiles/blob/master/doc/ffmpeg.md)	


- #### Where to get help:
- [Open Visual Cloud Dockerfiles Github](https://github.com/OpenVisualCloud/Dockerfiles)
- [Getting Started With Open Visual Cloud Docker Files](https://01.org/openvisualcloud/documents/get-started-docker)
- [the Docker Community Forums](https://forums.docker.com)
- [the Docker Community Slack](https://www.docker.com/docker-community)
- [Stack Overflow](https://stackoverflow.com/questions/tagged/docker)

-  #### Where to file issues:
[OpenVisualCloud Dockerfiles Issues](https://github.com/OpenVisualCloud/Dockerfiles/issues)

- #### Maintained by:
[OpenVisualCloud Dockerfiles Community](https://github.com/OpenVisualCloud/Dockerfiles/graphs/contributors)


## License
This docker installs third party components licensed under various open source licenses.  The terms under which those components may be used and distributed can be found with the license document that is provided with those components.  Please familiarize yourself with those terms to ensure your distribution of those components complies with the terms of those licenses.


| Components | License |
| ----- | ----- |
|CentOS| [Various](https://hub.docker.com/_/centos) |
|libogg|BSD 3-clause "New" or "Revised" License|
|libvorbis|BSD 3-clause "New" or "Revised" License|
|Opus Interactive Audio Codec|BSD 3-clause "New" or "Revised" License|
|libvpx|BSD 3-clause "New" or "Revised" License|
|x264|GNU General Public License v2.0 or later|
|x265|GNU General Public License v2.0 or later|
|dav1d|BSD 2-clause "Simplified" License|
|Intel SVT-HEVC|BSD-2-Clause Plus Patent License|
|Intel SVT-AV1|BSD-2-Clause Plus Patent License|
|Intel SVT-VP9|BSD-2-Clause Plus Patent License|
|Intel Graphics Memory Management Library| MIT License|
|libdrm|MIT license|
|Intel libva| MIT License
|Intel media-driver | MIT License|
|Intel media SDK|MIT License|
|FFmpeg|GNU Lesser General Public License v2.1 or later|


More license information can be found in [components source package](https://github.com/OpenVisualCloud/Dockerfiles-Resources).   
As for any pre-built image usage, it is the image user's responsibility to ensure that any use of this image complies with any relevant licenses and potential fees for all software contained within. We will have no indemnity or warranty coverage from suppliers.
