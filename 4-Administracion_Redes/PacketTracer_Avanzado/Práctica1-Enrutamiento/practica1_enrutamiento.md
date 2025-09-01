```markdown
# Práctica 1 - Redes con Packet Tracer

## 📖 Descripción
Este repositorio contiene la **Práctica 1** de Redes en Packet Tracer, donde se trabajan los siguientes puntos:

- Subnetting (VLSM)
- Configuración de interfaces
- Comprobación de conectividad
- Enrutamiento estático y dinámico (RIPv2)
- Configuración de routers, HQ, BR1 e ISP
- Cuestionario de repaso sobre conceptos de enrutamiento

---

## 📌 Índice
- [Packet Tracer: fundamentos](#packet-tracer-fundamentos)
- [Componentes de un router](#componentes-de-un-router)
- [Modos de IOS](#modos-de-ios)
- [Comandos básicos](#comandos-básicos)
- [Enrutamiento estático](#enrutamiento-estático)
- [Enrutamiento dinámico (RIP)](#enrutamiento-dinámico-rip)
- [Ejercicio 1: Enrutamiento estático](#ejercicio-1-enrutamiento-estático)
- [Ejercicio 2: RIP básico](#ejercicio-2-rip-básico)
- [Ejercicio 3: RIP con no-auto-summary](#ejercicio-3-rip-con-no-auto-summary)
- [Ejercicio 4: passive-interface y redistribute static](#ejercicio-4-passive-interface-y-redistribute-static)
- [Escenario base](#escenario-base)
- [Configuración ISP](#configuración-isp)
- [Configuración HQ](#configuración-hq)
- [Configuración BR1](#configuración-br1)
- [Configuración de hosts](#configuración-de-hosts)
- [Cuestionario](#cuestionario)
- [Distancia administrativa y métricas](#distancia-administrativa-y-métricas)

---

## Packet Tracer: fundamentos
Todo se realiza desde la **línea de comandos**. Las configuraciones se guardan en `running-config`. Existe la opción de backups automáticos en *Miscellaneous*. 

⚠️ Importante:
- El SO de Packet Tracer (IOS) **no tiene comandos Linux**.
- Si el router queda "colgado" espera peticiones Telnet. Se puede cancelar con `Ctrl + Shift + 6`.
- Para conocer los comandos disponibles usar `help` o `?`.

---

## Componentes de un router
- **CPU**: ejecuta instrucciones del SO.
- **RAM**: contiene `running-config`, tabla de enrutamiento, ARP y buffer de paquetes.
- **ROM**: arranque y diagnóstico.
- **Flash**: almacena Cisco IOS.
- **NVRAM**: guarda `startup-config`.
- **Interfaces**: reciben y reenvían paquetes.
- **Puertos de administración**: consola, usado para configuración inicial.

Flujo: **NVRAM → CPU → RAM → Running-config**

---

## Modos de IOS
- **Usuario (>)**: comandos básicos.
- **Privilegiado (#)**: gestión completa (`enable`).
- **Configuración global (config)**: `configure terminal`.
- **Sub-modos**:
  - `config-if`: interfaces
  - `config-router`: enrutamiento
  - `config-line`: líneas

Salir de modos:
- `exit` → sub-modos
- `disable` → volver a usuario

---

## Comandos básicos
- `show running-config`
- `show startup-config`
- `copy running-config startup-config`
- `show ip route`
- `show ip protocols`
- `show ip interface brief`
- `ping <IP>`
- `traceroute <IP>`
- `no ip domain-lookup`
- `no <comando>` → eliminar configuraciones
- `erase startup-config` → reset
- `write memory` → guardar

---

## Enrutamiento estático
Se configuran manualmente las rutas:
```bash
Router> enable
Router# configure terminal
Router(config)# ip route <RED_DESTINO> <MÁSCARA> <IP_SIGUIENTE_SALTO>
```

Ruta por defecto:
```bash
Router(config)# ip route 0.0.0.0 0.0.0.0 <IP_GATEWAY>
```

---

## Enrutamiento dinámico (RIP)
- RIP = protocolo de vector-distancia, métrica = saltos.
- Máx. 15 saltos.
- En redes modernas se usa RIP v2 (soporta subnetting).

Configuración:
```bash
Router(config)# router rip
Router(config-router)# version 2
Router(config-router)# network <RED>
Router(config-router)# no auto-summary
Router(config-router)# passive-interface <INTERFAZ>
Router(config-router)# redistribute static
```

---

## Ejercicio 1: Enrutamiento estático
### Router1
```bash
enable
configure terminal
hostname R1
interface g0/0
 ip address 192.168.1.1 255.255.255.0
 no shutdown
 exit
interface g0/1
 ip address 192.168.2.1 255.255.255.0
 no shutdown
 exit
ip route 192.168.3.0 255.255.255.0 192.168.2.2
ip route 192.168.4.0 255.255.255.0 192.168.2.2
```

### Router2
```bash
enable
configure terminal
interface g0/0
 ip address 192.168.2.2 255.255.255.0
 no shutdown
interface g0/1
 ip address 192.168.3.1 255.255.255.0
 no shutdown
interface g0/2
 ip address 192.168.4.1 255.255.255.0
 no shutdown
ip route 192.168.1.0 255.255.255.0 192.168.2.1
```

✅ Comprobación: `ping` entre PCs de distintas redes.

---

## Ejercicio 2: RIP básico
### Router1
```bash
enable
configure terminal
router rip
 version 2
 no auto-summary
 network 192.168.1.0
 network 192.168.2.0
 network 192.168.5.0
end
write memory
```

### Router2
```bash
router rip
 version 2
 no auto-summary
 network 192.168.2.0
 network 192.168.6.0
 network 192.168.3.0
 network 192.168.4.0
end
write memory
```

### Router3
```bash
router rip
 version 2
 no auto-summary
 network 192.168.5.0
 network 192.168.6.0
end
write memory
```

✅ Comprobar: `show ip route` (rutas con R) + `ping` entre PCs.

---

## Ejercicio 3: RIP con no auto-summary
Se mezclan redes de clase B y C → obligatorio `no auto-summary`.

### Router1
```bash
router rip
 version 2
 no auto-summary
 network 172.16.1.0
 network 192.168.2.0
 network 192.168.5.0
```

### Router2
```bash
router rip
 version 2
 no auto-summary
 network 192.168.2.0
 network 192.168.6.0
 network 172.16.3.0
 network 172.16.4.0
```

### Router3
```bash
router rip
 version 2
 no auto-summary
 network 192.168.5.0
 network 192.168.6.0
```

✅ Comprobar conectividad entre PCs.

---

## Ejercicio 4: passive-interface y redistribute static
### Router1
```bash
router rip
 version 2
 no auto-summary
 network 192.168.2.0
 network 192.168.5.0
 passive-interface g0/0
```

### Router2
```bash
router rip
 version 2
 no auto-summary
 network 192.168.2.0
 network 192.168.6.0
 network 192.168.3.0
 network 192.168.4.0
ip route 0.0.0.0 0.0.0.0 192.0.2.2
redistribute static
```

### Router3
```bash
router rip
 version 2
 no auto-summary
 network 192.168.5.0
 network 192.168.6.0
```

---

## Escenario base
Topología: **ISP + HQ + BR1** conectados.
- ISP → red central `192.0.2.0/24` con subredes /30 y /28.
- HQ → red interna `10.0.0.0/8` subdividida en /24 y /30.
- BR1 → red `192.168.1.0/24` subdividida en dos LANs /25.

---

## Configuración ISP
Ejemplo ISP1:
```bash
interface g0/0
 ip address 192.0.2.1 255.255.255.252
 no shutdown
interface g0/1
 ip address 192.0.2.10 255.255.255.252
 no shutdown
interface s0/0/0
 ip address 192.0.2.17 255.255.255.240
 no shutdown
router rip
 version 2
 no auto-summary
 network 192.0.2.0
redistribute static
ip route 10.0.0.0 255.0.0.0 192.0.2.18
```

---

## Configuración HQ
Ejemplo HQ-R1:
```bash
interface g0/0
 ip address 10.1.16.1 255.255.255.0
 no shutdown
interface g0/1
 ip address 10.1.17.1 255.255.255.0
 no shutdown
interface g0/0/0
 ip address 10.0.0.1 255.255.255.252
 no shutdown
interface g0/1/0
 ip address 10.0.0.10 255.255.255.252
 no shutdown
router rip
 version 2
 no auto-summary
 network 10.0.0.0
 network 10.1.16.0
 network 10.1.17.0
```

---

## Configuración BR1
```bash
interface g0/0
 ip address 192.168.1.1 255.255.255.128
 no shutdown
interface g0/1
 ip address 192.168.1.129 255.255.255.128
 no shutdown
interface s0/0/0
 ip address 192.0.2.34 255.255.255.240
 no shutdown
ip route 0.0.0.0 0.0.0.0 192.0.2.33
```

---

## Configuración de hosts
Ejemplo LAN16:
- PC1 → IP: 10.1.16.11 / 255.255.255.0 / GW: 10.1.16.1
- PC2 → IP: 10.1.16.12 / 255.255.255.0 / GW: 10.1.16.1

Ejemplo BR1:
- Server1 → 192.168.1.10 / 255.255.255.128 / GW: 192.168.1.1
- PC1 → 192.168.1.210 / 255.255.255.128 / GW: 192.168.1.129

---

## Cuestionario
1. **IP 192.168.10.10 → 192.168.20.20**: usa la **MAC del Gateway 192.168.10.1**.
2. **Tabla de enrutamiento con 10.2.1.200** → se elige G0/3 (/24, ruta más específica).
3. **Tabla con 10.2.100.2** → se elige G0/2 (10.2.0.0/16).
4. **¿Cómo decide interfaz de salida un router?** → dirección **IP de destino**.
5. **Subredes de 192.169.20.0/24 en 6 bloques** → máscara **/27** (30 hosts por subred).

---

## Distancia administrativa y métricas
- Estático = mejor, RIP = peor.
- **RIP**: límite 15 saltos, convergencia lenta, mucho overhead.
- **OSPF**: estado de enlace, métrica = ancho de banda.
- **EIGRP**: retardo, ancho de banda, carga.
- **BGP**: estándar en Internet.

Ejemplo RIP:
- Ruta1 → 3 saltos
- Ruta2 → 5 saltos
✅ Se elige la de 3 saltos.

---

## ✅ Conclusión
Esta práctica integra **configuración básica de routers, subnetting, RIP y rutas estáticas**, preparando un escenario realista de HQ + ISP + BR1. También incluye teoría y cuestionarios de repaso.
```

