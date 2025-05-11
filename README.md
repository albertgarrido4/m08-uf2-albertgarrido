# Rick & Morty Catalog

¡Bienvenido a **Rick & Morty Catalog**, una app Flutter que consume la API pública de Rick & Morty y muestra los personajes en una lista con búsqueda en tiempo real, paginación y detalle de cada uno!

---

## 📦 Estructura del proyecto

```
lib/
├── models/
│   └── character.dart          # Modelo de datos Character
├── services/
│   └── api_service.dart        # Lógica de llamadas HTTP y paginación
├── viewmodel/
│   └── character_viewmodel.dart# MVVM: estado, carga, búsqueda, paginación
└── views/
    ├── character_list_screen.dart   # Pantalla principal
    └── character_detail_screen.dart # Pantalla de detalle
```

---

## 🚀 Características

* **Consumo de API** pública de Rick & Morty con [`http`](https://pub.dev/packages/http).
* **Modelo** `Character` con constructor principal y `factory fromJson`.
* **Paginación** automática (“Cargar más”) y control de páginas.
* **Búsqueda en tiempo real** usando debounce (300 ms) para filtrar por nombre.
* **Gestión de estados** (carga inicial, “cargando más”, errores, sin resultados) vía MVVM con [`provider`](https://pub.dev/packages/provider).
* **Interfaz limpia**:

  * `ListView` con `ListTile` y `CircleAvatar`.
  * Mensajes claros de error o “fin de lista”.
  * Pantalla de detalle con imagen, chips de atributos y filas de información.

---

## 📋 Requisitos

* Flutter SDK **>= 3.7.2**
* Permiso de Internet en Android (`android/app/src/main/AndroidManifest.xml`):

  ```xml
  <uses-permission android:name="android.permission.INTERNET"/>
  ```

---

## 🔧 Instalación

1. **Clona** el repositorio:

   ```bash
   git clone https://github.com/tu-usuario/proyecto_albert_garrido.git
   cd proyecto_albert_garrido
   ```
2. **Instala** dependencias:

   ```bash
   flutter pub get
   ```
3. (Opcional) **Genera** los launcher icons si has configurado `flutter_launcher_icons`:

   ```bash
   flutter pub run flutter_launcher_icons:main
   ```
4. **Ejecuta** la app en tu emulador o dispositivo:

   ```bash
   flutter run
   ```

---

## 📦 Dependencias principales

* `flutter`
* `http`
* `provider`
* `cupertino_icons`
* `flutter_launcher_icons` (dev)

---

## 🖼️ Personalización

* **App Icon & Nombre**

  1. Reemplaza `assets/icon/app_icon.png` con tu PNG 1024×1024.

  2. Ajusta `pubspec.yaml` en la sección `flutter_icons`:

     ```yaml
     flutter_icons:
       android: true
       ios: true
       image_path: "assets/icon/app_icon.png"
       android_name: "MiApp"
       ios_name: "MiApp"
     ```

  3. Ejecuta:

     ```bash
     flutter pub run flutter_launcher_icons:main
     ```

---

## 🛠️ Cómo funciona

1. **Carga inicial**

   * Se lanza `fetchCharacters()` al montar el provider o en `initState()`.
2. **Búsqueda en tiempo real**

   * `SearchBar` detecta cambios, aplica debounce y llama a `vm.fetchCharacters(filtro)`.
3. **ViewModel**

   * Gestiona `_isLoading`, `_characters`, `_totalPages` y notifica cambios con `notifyListeners()`.
4. **Pantalla**

   * Observa con `context.watch<CharacterViewModel>()`, muestra spinner o lista según estado.
   * `ListView.builder` pinta `CharacterListItem` y un footer `LoadMoreFooter`.
5. **Detalle**

   * Al pulsar, `vm.selectCharacter(ch)` y navega a `CharacterDetailScreen`, que muestra avatar, chips e información.

---
