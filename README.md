docker-jumpgate
===============

Docker image to run SoftLayer Jumpgate; a WSGi application
which provides API adaptation between OpenStack REST APIs
and Cloud native APIs. Jumpgate in this image is served via
gunicorn.

Also see the [SoftLayer Jumpgate project page](http://softlayer.github.io/jumpgate/)

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
you can find in ```/etc/jumpgate.conf``` inside the container.
This random token is generated on image build.

If you want to override `jumpgate.conf` settings in the container you 
can attach a docker volume which contains a `jumpgate.conf` with conf 
property overrides and map it into `/etc/jumpgate/` in the container.

For example suppose you want to set the Jumpgate `log_level` to `DEBUG` and 
set the `admin_token` to `T0PSECR8T`:

* Create a `jumpgate` directory on the host which contains the `jumpgate.conf`
file.

* In that `jumpgate.conf` file specify any conf overrides you want to self. For
example:

```
[DEFAULT]
log_level = DEBUG
admin_token = T0PSECR8T
```

* When starting the jumpgate container, map your `jumpgate` directory to 
`/etc/jumpgate` directory in the container:

```
docker run -d -p 5000:5000 -v /opt/jumpgate:/etc/jumpgate jumpgate
```

* The resulting container will parse you bind mounted conf file after 
parsing the conf setup by the image build. This allows you to overrite
any conf properties you want.
