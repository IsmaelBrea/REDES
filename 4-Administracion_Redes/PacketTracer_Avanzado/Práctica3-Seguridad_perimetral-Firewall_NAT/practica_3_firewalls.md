```markdown
# Práctica 3 - Redes con Packet Tracer

## 📖 Descripción
Este repositorio contiene la **Práctica 3** de Redes en Packet Tracer. En esta práctica se estudian y configuran protocolos de enrutamiento avanzados, principalmente **EIGRP**, y se comparan sus características frente a RIP y OSPF.

Se incluyen:
- Conceptos teóricos de EIGRP
- Configuración paso a paso
- Escenario de laboratorio
- Ejercicios guiados
- Preguntas de repaso

---

## 📌 Índice
- [Fundamentos de EIGRP](#fundamentos-de-eigrp)
- [Comandos básicos de EIGRP](#comandos-básicos-de-eigrp)
- [Ejercicio 1: Configuración básica](#ejercicio-1-configuración-básica)
- [Ejercicio 2: Verificación de vecinos y métricas](#ejercicio-2-verificación-de-vecinos-y-métricas)
- [Ejercicio 3: Redistribución de rutas](#ejercicio-3-redistribución-de-rutas)
- [Escenario completo](#escenario-completo)
- [Configuración de hosts](#configuración-de-hosts)
- [Cuestionario](#cuestionario)
- [Conclusiones](#conclusiones)

---

## Fundamentos de EIGRP
- EIGRP = *Enhanced Interior Gateway Routing Protocol*.
- Es un protocolo híbrido (vector-distancia + estado de enlace).
- Métrica: combina **ancho de banda, retardo, carga y fiabilidad**.
- Distancia administrativa = 90 (menor que RIP y OSPF).
- Usa el algoritmo DUAL para calcular rutas libres de bucles.
- Permite sumarización automática y manual.

---

## Comandos básicos de EIGRP
```bash
router eigrp <AS_NUMBER>
 network <RED> <WILDCARD_MASK>
 passive-interface <INTERFAZ>
 no auto-summary
redistribute static
```

Ejemplo:
```bash
router eigrp 100
 network 10.0.0.0 0.0.0.255
 network 192.168.1.0 0.0.0.255
 no auto-summary
```

---

## Ejercicio 1: Configuración básica
### Router1
```bash
hostname R1
interface g0/0
 ip address 10.0.0.1 255.255.255.0
 no shutdown
interface g0/1
 ip address 192.168.1.1 255.255.255.0
 no shutdown
router eigrp 100
 network 10.0.0.0 0.0.0.255
 network 192.168.1.0 0.0.0.255
 no auto-summary
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
router eigrp 100
 network 10.0.0.0 0.0.0.255
 network 192.168.2.0 0.0.0.255
 no auto-summary
```

✅ Comprobar con `show ip route` (rutas D) y `ping` entre PCs.

---

## Ejercicio 2: Verificación de vecinos y métricas
- `show ip eigrp neighbors` → lista de vecinos descubiertos.
- `show ip eigrp topology` → tabla de topología EIGRP.
- `show ip protocols` → parámetros de configuración.

Ejemplo de salida:
```bash
R1# show ip eigrp neighbors
IP-EIGRP neighbors for process 100
H   Address          Interface  Hold  Uptime  SRTT  RTO  Q  Seq
0   10.0.0.2         Gi0/0      12    01:20   20    100  0  35
```

---

## Ejercicio 3: Redistribución de rutas
Ejemplo con conexión a ISP:
```bash
router eigrp 100
 network 10.0.0.0 0.0.0.255
 network 192.168.3.0 0.0.0.255
redistribute static
ip route 0.0.0.0 0.0.0.0 203.0.113.2
```

✅ Así se anuncia la ruta por defecto a los vecinos EIGRP.

---

## Escenario completo
- **Backbone**: enlaces entre routers con EIGRP (AS 100).
- **LANs internas**: anunciadas por cada router.
- **Enlace ISP**: salida estática a Internet redistribuida en EIGRP.

Comandos de verificación:
- `show ip route`
- `show ip eigrp topology`
- `show ip eigrp neighbors`

---

## Configuración de hosts
Ejemplo:
- PC1 → 192.168.1.10 / 255.255.255.0 / GW: 192.168.1.1
- PC2 → 192.168.2.10 / 255.255.255.0 / GW: 192.168.2.1
- PC3 → 192.168.3.10 / 255.255.255.0 / GW: 192.168.3.1

---

## Cuestionario
1. **¿Qué métrica usa EIGRP?** → BW, delay, carga, fiabilidad.
2. **Diferencia con RIP** → EIGRP admite múltiples métricas y converge más rápido.
3. **Distancia administrativa de EIGRP** → 90.
4. **Comando para vecinos** → `show ip eigrp neighbors`.
5. **Ventajas de EIGRP** → rápido, eficiente, balanceo de carga, escalable.

---

## Conclusiones
En esta práctica se configuró **EIGRP**, se analizaron vecinos, métricas y redistribución de rutas. Se comparó frente a RIP y OSPF, observando su rapidez de convergencia y flexibilidad.
```

