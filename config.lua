Config = {}

Config.Locale = 'en' -- 'en'
Config.Hotkey = 'Z'
Config.Align = "right"
Config.UseOxTarget = true
Config.EnableClothingLog = true

Config.Settings = {
    ['police'] = {
        ['police'] = {
            ['boss'] = {
                {
                    label = 'Patrol (cap)',
                    skin = {
                        male = {
                            tshirt_1 = 59,  tshirt_2 = 1,
                            torso_1 = 55,   torso_2 = 0,
                            decals_1 = 0,   decals_2 = 0,
                            arms = 41,
                            pants_1 = 25,   pants_2 = 0,
                            shoes_1 = 25,   shoes_2 = 0,
                            helmet_1 = 46,  helmet_2 = 0,
                            chain_1 = 0,    chain_2 = 0,
                            ears_1 = 2,     ears_2 = 0
                        },
                        female = {
                            tshirt_1 = 36,  tshirt_2 = 1,
                            torso_1 = 48,   torso_2 = 0,
                            decals_1 = 0,   decals_2 = 0,
                            arms = 44,
                            pants_1 = 34,   pants_2 = 0,
                            shoes_1 = 27,   shoes_2 = 0,
                            helmet_1 = 45,  helmet_2 = 0,
                            chain_1 = 0,    chain_2 = 0,
                            ears_1 = 2,     ears_2 = 0
                        }
                    }
                },
                {
                    label = 'Patrol',
                    skin = {
                        male = {
                            tshirt_1 = 59,  tshirt_2 = 1,
                            torso_1 = 55,   torso_2 = 0,
                            decals_1 = 0,   decals_2 = 0,
                            arms = 41,
                            pants_1 = 25,   pants_2 = 0,
                            shoes_1 = 25,   shoes_2 = 0,
                            helmet_1 = -1,  helmet_2 = 0,
                            chain_1 = 0,    chain_2 = 0,
                            ears_1 = 2,     ears_2 = 0
                        },
                        female = {
                            tshirt_1 = 36,  tshirt_2 = 1,
                            torso_1 = 48,   torso_2 = 0,
                            decals_1 = 0,   decals_2 = 0,
                            arms = 44,
                            pants_1 = 34,   pants_2 = 0,
                            shoes_1 = 27,   shoes_2 = 0,
                            helmet_1 = 45,  helmet_2 = 0,
                            chain_1 = 0,    chain_2 = 0,
                            ears_1 = 2,     ears_2 = 0
                        }
                    }
                },
            },
            ['officer'] = {
                {
                    label = 'Patrol',
                    skin = {
                        male = {
                            tshirt_1 = 58,  tshirt_2 = 0,
                            torso_1 = 55,   torso_2 = 0,
                            decals_1 = 0,   decals_2 = 0,
                            arms = 41,
                            pants_1 = 25,   pants_2 = 0,
                            shoes_1 = 25,   shoes_2 = 0,
                            helmet_1 = -1,  helmet_2 = 0,
                            chain_1 = 0,    chain_2 = 0,
                            ears_1 = 2,     ears_2 = 0
                        },
                        female = {
                            tshirt_1 = 35,  tshirt_2 = 0,
                            torso_1 = 48,   torso_2 = 0,
                            decals_1 = 0,   decals_2 = 0,
                            arms = 44,
                            pants_1 = 34,   pants_2 = 0,
                            shoes_1 = 27,   shoes_2 = 0,
                            helmet_1 = -1,  helmet_2 = 0,
                            chain_1 = 0,    chain_2 = 0,
                            ears_1 = 2,     ears_2 = 0
                        }
                    }
                },
            },
        },
    },
}

Config.Text = {
    open_menu = {
        de = 'Kleidung wechseln',
        en = 'Change Outfit'
    },
    own_clothing = {
        de = 'Eigene Kleidung',
        en = 'Personal Outfit'
    },
    no_vehicle_near = {
        de = 'Kein Fahrzeug in der Nähe.',
        en = 'No vehicle nearby.'
    },
    no_permission = {
        de = 'Keine Berechtigung für diese Kleidung.',
        en = 'No permission for this clothing.'
    },
    open_key_desc = {
        de = 'Öffne die Kleiderbox im Fahrzeug',
        en = 'Open the clothing box in vehicle'
    }
}
