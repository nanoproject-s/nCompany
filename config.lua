Config = Config or {}

Config.DebugMode = true
Config.Company = {
    ['uwu'] = {
        ['label'] = 'Uwu Cafe',
        ['blip'] = {
            coords = vector3(-585.06, -1059.65, 22.34),
            color = 8,
            sprite = 205,
        },
        ['coords'] = {
            ['orders'] = {
                ['target'] = {
                    center = vector3(-584.01, -1061.68, 22.42),
                    lenght = 1.0,
                    width = 0.4,
                    heading = 0.0,
                }
            },
            ['boss'] = {
                ['target'] = {
                    center = vector3(-595.97, -1052.87, 22.25),
                    lenght = 1.0,
                    width = 0.4,
                    heading = 90.0,
                }
            },
            ['stash'] = {
                ['target'] = {
                    center = vector3(-590.37, -1058.75, 22.34),
                    lenght = 1.3,
                    width = 1.0,
                    zOffs = 1.3,
                    heading = 0.0,
                }
            },
            ['craft'] = {
                [1] = {
                    ['label'] = 'Tahta',
                    ['icon'] = 'fas fa-knife-kitchen',
                    ['target'] = {
                        center = vector3(-590.99, -1063.16, 22.36),
                        lenght = 1.0,
                        width = 1.4,
                        heading = 91.0,
                    },
                    ['items'] = {
                        ['phone'] = {
                            ['pistol_ammo'] = 2,
                        },
                    },
                },
                [2] = {
                    ['label'] = 'Ocak',
                    ['icon'] = 'fas fa-knife-kitchen',
                    ['target'] = {
                        center = vector3(-590.96, -1056.59, 22.36),
                        lenght = 0.5,
                        width = 1.4,
                        heading = 91.0,
                    },
                    ['items'] = {
                        ['phone'] = {
                            ['pistol_ammo'] = 2,
                        },
                    },
                },
                [3] = {
                    ['label'] = 'Kahve',
                    ['icon'] = 'fas fa-knife-kitchen',
                    ['target'] = {
                        center = vector3(-586.8, -1061.88, 22.34),
                        lenght = 1.0,
                        width = 1.4,
                        heading = 91.0,
                    },
                    ['items'] = {
                        ['phone'] = {
                            ['pistol_ammo'] = 2,
                        },
                    },
                },
            }
        }
    },
    ['pizzeria'] = {
        ['label'] = 'Pizzeria',
        ['blip'] = {
            coords = vector3(798.64, -745.4, 26.78),
            color = 25,
            sprite = 681,
        },
        ['coords'] = {
            ['orders'] = {
                ['target'] = {
                    center = vector3(811.02, -750.99, 26.78),
                    lenght = 3.0,
                    width = 1.4,
                    heading = 0.0,
                }
            },
            ['boss'] = {
                ['target'] = {
                    center = vector3(797.91, -750.82, 31.15),
                    lenght = 2.0,
                    width = 1.4,
                    heading = 0.0,
                }
            },
            ['stash'] = {
                ['target'] = {
                    center = vector3(806.32, -763.28, 26.78),
                    lenght = 4.3,
                    width = 1.0,
                    zOffs = 1.3,
                    heading = 0.0,
                }
            },
            ['craft'] = {
                [1] = {
                    ['label'] = 'Tahta',
                    ['icon'] = 'fas fa-knife-kitchen',
                    ['target'] = {
                        center = vector3(809.30, -761.25, 26.78),
                        lenght = 1.0,
                        width = 1.4,
                        heading = 91.0,
                    },
                    ['items'] = {
                        ['phone'] = {
                            ['pistol_ammo'] = 2,
                        },
                    },
                },
            }
        }
    },
    ['beanmachine'] = {
        ['label'] = 'Bean Machine',
        ['blip'] = {
            coords = vector3(117.84, -1039.09, 29.28),
            color = 23,
            sprite = 133,
        },
        ['coords'] = {
            ['orders'] = {
                ['target'] = {
                    center = vector3(120.98, -1040.34, 29.58),
                    lenght = 1.5,
                    width = 1.5,
                    heading = 0.0,
                }
        
            },
            ['boss'] = {
                ['target'] = {
                    center = vector3(126.85, -1033.46, 29.28),
                    lenght = 1.0,
                    width = 2.5,
                    heading = 0.5,
                }
            },
            ['stash'] = {
                ['target'] = {
                    center = vector3(124.19, -1037.43, 29.28), 
                    lenght = 3.8,
                    width = 1.0,
                    zOffs = 1.3,
                    heading = 0.0,
                }
            },
            ['craft'] = {
                [1] = {
                    ['label'] = 'İçecek',
                    ['icon'] = 'fas fa-knife-kitchen',
                    ['target'] = {
                        center = vector3(123.15, -1042.34, 29.28),
                        lenght = 2.1,
                        width = 2.0,
                        heading = 91.0,
                    },
                    ['items'] = {
                        ['phone'] = {
                            ['pistol_ammo'] = 2,
                        },
                    },
                },
            }
        }
    },
}