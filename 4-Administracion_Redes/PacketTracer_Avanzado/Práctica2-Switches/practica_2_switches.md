```markdown
# Práctica 2 - Redes con Packet Tracer

## 📖 Descripción
Este repositorio contiene la **Práctica 2** de Redes en Packet Tracer. En esta práctica se profundiza en la configuración de **enrutamiento dinámico**, especialmente en **OSPF**, así como en escenarios mixtos con rutas estáticas y protocolos dinámicos.

Se incluyen:
- Conceptos de OSPF y comparación con RIP
- Configuración paso a paso en routers
- Ejercicios guiados
- Preguntas de repaso

---

## 📌 Índice
- [Fundamentos de OSPF](#fundamentos-de-ospf)
- [Comandos básicos de OSPF](#comandos-básicos-de-ospf)
- [Ejercicio 1: Configuración básica de OSPF](#ejercicio-1-configuración-básica-de-ospf)
- [Ejercicio 2: OSPF multiárea](#ejercicio-2-ospf-multiárea)
- [Ejercicio 3: Redistribución de rutas](#ejercicio-3-redistribución-de-rutas)
- [Escenario completo](#escenario-completo)
- [Configuración de hosts](#configuración-de-hosts)
- [Cuestionario](#cuestionario)
- [Conclusiones](#conclusiones)

---

## Fundamentos de OSPF
- OSPF es un protocolo de enrutamiento **link-state**.
- Utiliza **Dijkstra (SPF)** para calcular rutas.
- Métrica: **coste** (basado en ancho de banda).
- Escalable y eficiente en comparación con RIP.
- Permite **áreas** para segmentar redes.

---

## Comandos básicos de OSPF
```bash
router ospf <PROCESS_ID>
 network <RED> <WILDCARD_MASK> area <N>
 passive-interface <INTERFAZ>
redistribute static
```

Ejemplo de configuración:
```bash
router ospf 1
 network 10.0.0.0 0.0.0.255 area 0
 network 192.168.1.0 0.0.0.255 area 1
 passive-interface g0/0
```

---

## Ejercicio 1: Configuración básica de OSPF
### Router1
```bash
hostname R1
interface g0/0
 ip address 10.0.0.1 255.255.255.0
 no shutdown
interface g0/1
 ip address 192.168.1.1 255.255.255.0
 no shutdown
router ospf 1
 network 10.0.0.0 0.0.0.255 area 0
 network 192.168.1.0 0.0.0.255 area 0
```

### Router2
```bash
hostname R2
interface g0/0
 ip address 10.0.0.2 255.255.255.0
 no shutdown
interface g0/1
 ip address 192.168.2.1 255.255.255.0
 no shutdown
router ospf 1
 network 10.0.0.0 0.0.0.255 area 0
 network 192.168.2.0 0.0.0.255 area 0
```

✅ Comprobar conectividad con `ping` y `show ip route` (rutas O).

---

## Ejercicio 2: OSPF multiárea
Se organiza la red en **área 0 (backbone)** y sub-áreas.

### Router3 (ABR)
```bash
hostname R3
interface g0/0
 ip address 10.0.1.1 255.255.255.0
 no shutdown
interface g0/1
 ip address 172.16.0.1 255.255.255.0
 no shutdown
router ospf 1
 network 10.0.1.0 0.0.0.255 area 0
 network 172.16.0.0 0.0.0.255 area 1
```

### Router4
```bash
hostname R4
interface g0/0
 ip address 172.16.0.2 255.255.255.0
 no shutdown
interface g0/1
 ip address 192.168.3.1 255.255.255.0
 no shutdown
router ospf 1
 network 172.16.0.0 0.0.0.255 area 1
 network 192.168.3.0 0.0.0.255 area 1
```

---

## Ejercicio 3: Redistribución de rutas
### Router5
```bash
hostname R5
interface g0/0
 ip address 10.0.2.1 255.255.255.0
 no shutdown
interface g0/1
 ip address 203.0.113.1 255.255.255.252
 no shutdown
router ospf 1
 network 10.0.2.0 0.0.0.255 area 0
redistribute static
ip route 0.0.0.0 0.0.0.0 203.0.113.2
```

---

## Escenario completo
El escenario integra:
- **Área 0**: backbone con routers principales.
- **Áreas 1 y 2**: redes departamentales.
- **Enlace a ISP**: salida a Internet con ruta estática.

Se deben verificar:
- Tablas de enrutamiento (`show ip route`)
- Vecinos OSPF (`show ip ospf neighbor`)
- Estados de interfaces (`show ip ospf interface brief`)

---

## Configuración de hosts
Ejemplo:
- PC1 → IP: 192.168.1.10 / 255.255.255.0 / GW: 192.168.1.1
- PC2 → IP: 192.168.2.10 / 255.255.255.0 / GW: 192.168.2.1
- PC3 → IP: 192.168.3.10 / 255.255.255.0 / GW: 192.168.3.1

---

## Cuestionario
1. **¿Qué métrica usa OSPF?** → El coste, basado en ancho de banda.
2. **Diferencia entre RIP y OSPF** → RIP usa saltos, OSPF usa coste.
3. **Función de un ABR** → conectar backbone (área 0) con otras áreas.
4. **Comando para ver vecinos OSPF** → `show ip ospf neighbor`.
5. **Redistribución de rutas** → permite anunciar rutas estáticas a OSPF.

---

## Conclusiones
En esta práctica se trabajó con **OSPF**, configurando desde un escenario básico hasta **multiárea y redistribución de rutas estáticas**. Se comparó su funcionamiento con RIP y se verificó la conectividad en un escenario realista.
```

