# man-in-the-middle-attack
It allow to execute a man in the middle attack into a LAN.

## Important:
- You can run the "arpspoofing.sh" first to execute a man in the middle attack.
- The other scripts you can run after to do some cool things.

## Starting attack
Usage arpspoofing.sh:
```shell
./arpspoofing.sh [interface] [IP target] [IP gateway] [IP network]
```

Example:
```shell
./arpspoofing.sh eth0 192.168.0.100 192.168.0.1 192.168.0.0/24
```
