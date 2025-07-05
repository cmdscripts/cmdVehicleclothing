# Job Vehicle Clothing System

This FiveM script allows job-based clothing changes directly at specified vehicles. It is built with `ESX`, `ox_lib`, and optionally supports `ox_target`. Players can change into predefined outfits depending on their **job** and **rank**, using the **vehicle as a wardrobe**.

---

## ✅ Features

- 🚔 Job & grade-based outfit availability  
- 🚗 Vehicle-based access (only allowed models)  
- 🎯 Optional `ox_target` integration  
- 🎭 Uses `skinchanger` to apply clothing  
- 💡 Reverts to your own outfit when choosing "Own Clothing"  
- 🎬 Animation while changing clothing  
- 🔐 Restricted by job/vehicle combination  
- 🧠 Localized (`Config.Text` support)

---

## 📦 Dependencies

- [ESX (latest version)](https://github.com/esx-framework/esx_core)
- [ox_lib](https://github.com/overextended/ox_lib)
- [ox_target (optional)](https://github.com/overextended/ox_target)
- [skinchanger](https://github.com/esx-framework/skinchanger)

---

## ⚙️ Configuration

### `Config.Settings`
Define which vehicle models offer outfits, and which jobs/grades can access them:

```lua
Config.Settings = {
    ['police'] = {
        ['police'] = {
            ['recruit'] = {
                { label = 'Patrol Uniform', skin = { male = { ... }, female = { ... } } }
            },
            ['officer'] = {
                { label = 'Tactical Gear', skin = { male = { ... }, female = { ... } } }
            }
        }
    }
}
