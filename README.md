docker-jumpgate
===============

Docker image to run SoftLayer Jumpgate; a WSGi application
which provides API adaptation between OpenStack REST APIs
and Cloud native APIs. Jumpgate in this image is served via
gunicorn.

[SoftLayer Jumpgate project page](http://softlayer.github.io/jumpgate/)
Based on instructions from [my blog](http://bodenr.blogspot.com/2014/03/managing-openstack-softlayer-resources.html)


Jumpgate version
-----------

`master` branch pulls jumpgate git `master` which
can be found [here](https://github.com/softlayer/jumpgate)


Building the image
-----------
```
docker build -t jumpgate .
```


Running the image
-----------
The jumpgate image it setup to bind on port 5000 inside the container's
network namespace, and thus you need to map it to a port on your host.

```
docker run -d -p 5000:5000 jumpgate
```

The Jumpgate image is setup with a random ```ADMIN_TOKEN``` which
you can find in ```/etc/jumpgate/jumpgate.conf``` inside the container.
This random token is generated on image build.


