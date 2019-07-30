Example of InterSystems IRIS with external Apache and WebGateway
===

Example of docker-compose configuration with external Apache configured to use InterSystems WebGateway

Start
---

```shell
docker-compose build
docker-compose up -d
```

Check
---

Open URL
<http://localhost/csp/sys/UtilHome.csp>

Stop
---

```shell
docker-compose down
```
