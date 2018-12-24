------------------------------------------------
-- Coordinates for buttons in various screens --
------------------------------------------------

HORTENSIA = {
  LOADING = {
    RUNNING = {
      COLORS = {
        {x = 926, y = 852, color = 16777215},
        {x = 926, y = 861, color = 16777215},
        {x = 936, y = 873, color = 16645630},
        {x = 967, y = 856, color = 16777215},
        {x = 948, y = 869, color = 16777215},
        {x = 947, y = 863, color = 16777215},
        {x = 988, y = 850, color = 16777215},
        {x = 990, y = 854, color = 16514045},
        {x = 988, y = 863, color = 14147050},
        {x = 992, y = 861, color = 16777215},
        {x = 993, y = 866, color = 16777215},
        {x = 995, y = 870, color = 16777215},
        {x = 1009, y = 850, color = 16711422},
        {x = 1024, y = 857, color = 16777215},
        {x = 1025, y = 862, color = 16777215},
        {x = 1024, y = 868, color = 16711423},
        {x = 1021, y = 872, color = 16711423},
        {x = 1007, y = 860, color = 16777215},
        {x = 1036, y = 850, color = 16777215},
        {x = 1036, y = 855, color = 16777215},
        {x = 1036, y = 869, color = 16777215},
        {x = 1050, y = 858, color = 16251131},
        {x = 1055, y = 852, color = 16777215},
        {x = 1064, y = 861, color = 16053752},
        {x = 1067, y = 861, color = 12699610},
        {x = 1077, y = 858, color = 16711423},
        {x = 1078, y = 865, color = 16777215},
        {x = 1096, y = 867, color = 16777215},
        {x = 1096, y = 867, color = 16777215},
        {x = 1096, y = 861, color = 16777215}
      }
    },

    CIRCLE = {
      CENTER = {
        x = 1024,
        y = 768,
        COLORS = {
          81281,
          15233,
          81025,
          81026,
          80769,
          81026,
          15233,
          15489
        }
      },

      -- BORDER_TOP and TOP_SWORD_TIP currently unused
      BORDER_TOP = {
        x = 1014,
        y = 698,
        COLORS = {
          12951615,
          13017663,
          13017663,
          12951615,
          13017663,
          13017663,
          13017663,
          13017663,
        }
      },
      TOP_SWORD_TIP = {
        x = 1023,
        y = 696,
        COLORS = {
          4026794,
          6923224,
          4026794,
          4026794,
          12570336,
          4026794,
          3370685,
          12570336,
        }
      }
    }
  },

  HOME = {
    MISSIONS = {
      x = 1545,
      y = 1287
    },

    STATUS_BAR = {
      x = 521,
      y = 257
    }
  },

  MISSIONS = {
    HOME_OR_BACK = {
      x = 1708,
      y = 264
    },

    DROPDOWN = {
      x = 1905,
      y = 311,

      GIFTBOX = {
        x = 1942,
        y = 687
      },

      EVENT = {
        {x = 398, y = 617},
        {x = 387, y = 900},
      }
    },

    BOSS = {
      x = 1227,
      y = 235,
      COLOR = {
        UNAVAILABLE = 8347976
      }
    },

    KNIGHTS_QUEST = {
      TAB = {
        x = 1033,
        y = 1280
      },

      FIRST = {
        x = 1568,
        y = 551
      },

      SECOND = {
        x = 1559,
        y = 775
      },

      THIRD = {
        x = 1544,
        y = 989
      }
    },

    DAILY = {
      x = 1414,
      y = 1268,
      FOURTH = {
        x = 1134,
        y = 1139
      },
      THIRD = {
        x = 1134,
        y = 901
      },
      SECOND = {
        x = 1134,
        y = 666
      },
      FIRST = {
        x = 1134,
        y = 429
      }
    },

    THREE_BATTLES = {
      FIRST = {
        x = 1511,
        y = 867
      },

      SECOND = {
        x = 1511,
        y = 1070
      },

      THIRD = {
        x = 1511,
        y = 1270
      }
    },

    BATTLE_SELECT = {
      THIRD_BATTLE = {
        BORDER = {
          {x = 1741, y = 1182},
          {x = 1741, y = 1227},
          {x = 1741, y = 1245},
          {x = 1741, y = 1283},
          {x = 1741, y = 1337},
        }
      }
    },

    INSUFFICIENT_AP = {
      COLORS = {
        compat = true,
        {x = 430, y = 330, color = 7363130},
        {x = 530, y = 330, color = 7363130},
        {x = 630, y = 330, color = 7363130},
        {x = 1330, y = 330, color = 7363130},
        {x = 1430, y = 330, color = 7363130},
        {x = 565, y = 625, color = 16777215},
        {x = 1216, y = 625, color = 16777215},
        {x = 568, y = 834, color = 16777215},
        {x = 1233, y = 841, color = 35531},
        {x = 586, y = 1048, color = 7421954},
        {x = 586, y = 1048, color = 7421954}
      },

      AP10 = {
        compat = true,
        name = "AP10",
        LOC = {x = 655, y = 590},
        x = 671,
        y = 512,
        COLOR = { AVAILABLE = 8191861 }
      },

      AP30 = {
        compat = true,
        name = "AP30",
        LOC = {x = 1310, y = 590},
        x = 1378,
        y = 512,
        COLOR = { AVAILABLE = 7864178 }
      },

      AP50 = {
        compat = true,
        name = "AP50",
        LOC = {x = 655, y = 795},
        x = 675,
        y = 719,
        COLOR = { AVAILABLE = 9174917 }
      },

      APMAX = {
        compat = true,
        name = "APMAX",
        LOC = {x = 1310, y = 795},
        x = 1360,
        y = 719,
        COLOR = { AVAILABLE = 9305990 }
      },

      APSTONE = {
        compat = true,
        name = "APSTONE",
        LOC = {x = 655, y = 1000},
        x = 671,
        y = 925,
        COLOR = { AVAILABLE = 8585083 }
      },

      CONSUME_CONFIRM = {
        x = 1180,
        y = 948
      },

      CONSUMED_STILL_INSUFFICIENT = {
        COLORS = {
          {x = 560, y = 515, color = 14932669},
          {x = 660, y = 515, color = 15458758},
          {x = 760, y = 515, color = 15195586},
          {x = 860, y = 515, color = 15195586},
          --{x = 960, y = 515, color = 14208694},
          {x = 1060, y = 515, color = 5722449},
          {x = 1160, y = 515, color = 15064000},
          {x = 1260, y = 515, color = 15129536},
          {x = 1360, y = 515, color = 15195842},
          {x = 1460, y = 515, color = 14998207},
          {x = 804, y = 683, color = 15458757},
          {x = 904, y = 683, color = 15063999},
          {x = 1004, y = 683, color = 5722449},
          {x = 1104, y = 683, color = 15195585},
          {x = 1204, y = 683, color = 15195585},
          --{x = 508, y = 970, color = 13024671},
          {x = 608, y = 970, color = 14998206},
          {x = 708, y = 970, color = 14866620},
          {x = 808, y = 970, color = 15393221},
          {x = 908, y = 970, color = 1209309},
          {x = 1008, y = 970, color = 547798},
          {x = 1108, y = 970, color = 480468},
          {x = 1208, y = 970, color = 2438218},
          {x = 1308, y = 970, color = 15195842},
          {x = 1408, y = 970, color = 15064000},
          {x = 1508, y = 970, color = 15129792},
        },

        CONFIRM = {
          x = 1080,
          y = 964
        }
      }
    }
  },

  GIFTBOX = {
    ACCEPT_ONCE = {
      x = 1496,
      y = 1265,
      COLOR = {
        AVAILABLE = 11537163,
        UNAVAILABLE = 2434085
      }
    },

    ACCEPT_CONFIRMATION = {
      x = 969,
      y = 967
    },

    ITEMS = {
      x = 112,
      y = 469,
      COLOR = {
        HIGHLIGHTED = 1893390,
        NON_HIGHLIGHTED = 10504213
      }
    },

    CARDS = {
      x = 115,
      y = 602,
      COLOR = {
        HIGHLIGHTED = 2485262,
        NON_HIGHLIGHTED = 13792787
      }
    }
  },

  BATTLE = {
    HELPER_SELECT = {
      COLORS = {
        {x = 1067, y = 396, color = 5000268},
        {x = 1317, y = 399, color = 5000268},
        {x = 1618, y = 393, color = 5000268},
        {x = 1838, y = 401, color = 5000268},
        {x = 1846, y = 587, color = 9568256},
      },
      FIRST = {
        x = 1858,
        y = 509
      }
    },

    PARTY_SELECT = {
      CONFIRM = {
        x = 875,
        y = 1133
      },

      CLOSE = {
        x = 1862,
        y = 377
      }
    },

    SPECIAL_COMPLETE = {
      COLORS = {
        -- Commented out some color matching for stability
        {x = 100, y = 935, color = 5190146},
        {x = 200, y = 935, color = 16508027},
        {x = 300, y = 935, color = 16574559},
        --{x = 400, y = 935, color = 5848853},
        {x = 500, y = 935, color = 5190146},
        --{x = 600, y = 935, color = 16248802},
        {x = 700, y = 935, color = 16441464},
        {x = 800, y = 935, color = 16644015},
        {x = 900, y = 935, color = 16704674},
        {x = 1000, y = 935, color = 2959138},
        {x = 1100, y = 935, color = 14263905}
      },
      CONFIRM = {x = 1605, y = 1246}
    },

    COMPLETE = {
      COLORS = {
        compat = true,
        {x = 1250, y = 268, color = 131329},
        {x = 1227, y = 387, color = 6894387},
        {x = 1606, y = 360, color = 9830399},
        {x = 1654, y = 1218, color = 3684408},
        {x = 1653, y = 1271, color = 1973790},
        {x = 1993, y = 1219, color = 3684408},
        {x = 2003, y = 1264, color = 1842204},
      },

      CONFIRM = {
        x = 1343,
        y = 1238
      },

      FRIEND_REQUEST = {
        COLORS = {
          compat = true,
          {x = 590, y = 573, color = 8872755},
          {x = 690, y = 573, color = 8872755},
          {x = 790, y = 573, color = 8872755},
          {x = 890, y = 573, color = 8872755},
          {x = 990, y = 573, color = 8872755},
          {x = 1090, y = 573, color = 8872755},
          {x = 1190, y = 573, color = 8872755},
          {x = 1290, y = 573, color = 8872755},
          {x = 1390, y = 573, color = 8872755},
          {x = 964, y = 1045, color = 4827132},
          {x = 994, y = 1045, color = 15459014},
          {x = 1044, y = 1045, color = 14866877},
          {x = 1124, y = 1045, color = 16297902},
          {x = 1314, y = 1045, color = 16296360},
        },
        SEND = {x = 1244, y = 1086},
        DISCARD = {x = 805, y = 1085}
      },

      SAVED_MISSION = {
        compat = true,
        LOC = {x = 1697, y = 1246},
        x = 1827,
        y = 1290,
        COLOR = {
          UNAVAILABLE = 4671303,
          AVAILBLE = 10922153
        }
      },

      RANK_UP = {
        COLORS = {
          compat = true,
          {x = 621, y = 357, color = 16777214},
          {x = 691, y = 368, color = 16777214},
          {x = 673, y = 417, color = 16776937},
          {x = 749, y = 399, color = 16777203},
          {x = 760, y = 440, color = 16776922},
          {x = 750, y = 483, color = 16776127},
          {x = 878, y = 406, color = 16777197},
          {x = 951, y = 483, color = 16776127},
          {x = 1010, y = 357, color = 16777214},
          {x = 1062, y = 436, color = 16776928},
          {x = 1084, y = 479, color = 16776127},
          {x = 1210, y = 361, color = 16777214},
          {x = 1210, y = 447, color = 16776918},
          {x = 1260, y = 489, color = 16776127},
          {x = 1302, y = 371, color = 16777214},
          {x = 1364, y = 360, color = 16777214},
          {x = 1429, y = 370, color = 16777214},
          {x = 1395, y = 416, color = 16777200},
          {x = 1360, y = 484, color = 16776127}
        },

        CONFIRM = {
          x = 950,
          y = 1088
        }
      },

      --[[
      --  Some unlocks have additional requirements that fails to satisify
      --  the below color matching
      --  TODO: update EP_UP unlocks color matching
      --]]
      EP_UP = {
        STORY_UNLOCK = {
          COLORS = {
            {x = 1160, y = 232, color = 10117198},
            {x = 1260, y = 232, color = 6896675},
            {x = 1360, y = 232, color = 6371104},
            {x = 1460, y = 232, color = 6305568},
            {x = 1560, y = 232, color = 6305568},
            {x = 1660, y = 232, color = 6633763},
            {x = 1760, y = 232, color = 6962211},
            {x = 1860, y = 232, color = 6305568},
            {x = 1960, y = 232, color = 7027243},
            {x = 1210, y = 995, color = 261},
            {x = 1310, y = 995, color = 15651766},
            {x = 1410, y = 995, color = 7431509},
            {x = 1510, y = 995, color = 15651766},
            {x = 1610, y = 995, color = 14533800},
            {x = 1710, y = 995, color = 259},
            {x = 1810, y = 995, color = 259},
            {x = 1910, y = 995, color = 595245},
            {x = 1159, y = 1182, color = 5449755},
            {x = 1259, y = 1182, color = 8871744},
            {x = 1359, y = 1182, color = 9200194},
            {x = 1459, y = 1182, color = 8871744},
            {x = 1559, y = 1182, color = 8871744},
            {x = 1659, y = 1182, color = 8871743},
            {x = 1759, y = 1182, color = 9134401},
            {x = 1859, y = 1182, color = 9200194},
            {x = 1959, y = 1182, color = 12295035},
            {x = 1115, y = 301, color = 5122075},
            {x = 1115, y = 401, color = 4071188},
            {x = 1115, y = 501, color = 3742737},
            {x = 1115, y = 601, color = 3676945},
            {x = 1115, y = 701, color = 3939859},
            {x = 1115, y = 801, color = 3939859},
            {x = 1115, y = 901, color = 4071188},
            {x = 1115, y = 1001, color = 3808530},
            {x = 1115, y = 1101, color = 3939859},
            {x = 2009, y = 260, color = 9333847},
            {x = 2009, y = 360, color = 4794395},
            {x = 2009, y = 460, color = 4728345},
            {x = 2009, y = 560, color = 4991258},
            {x = 2009, y = 660, color = 4334358},
            {x = 2009, y = 760, color = 4334358},
            {x = 2009, y = 860, color = 4531480},
            {x = 2009, y = 960, color = 4531480},
            {x = 2009, y = 1060, color = 4991517},
            {x = 2009, y = 1160, color = 7819837},
          },
          CONFIRM = {
            x = 1510,
            y = 1127
          }
        },

        AWAKENING_UNLOCK = {
          COLORS = {
            {x = 1160, y = 232, color = 10117198},
            {x = 1260, y = 232, color = 6896675},
            {x = 1360, y = 232, color = 6371104},
            {x = 1460, y = 232, color = 6305568},
            {x = 1560, y = 232, color = 6305568},
            {x = 1660, y = 232, color = 6633763},
            {x = 1760, y = 232, color = 6962211},
            {x = 1860, y = 232, color = 6305568},
            {x = 1960, y = 232, color = 7027243},
            {x = 1159, y = 1081, color = 5646620},
            {x = 1259, y = 1081, color = 7884851},
            {x = 1359, y = 1081, color = 8344374},
            {x = 1459, y = 1081, color = 7950387},
            {x = 1559, y = 1081, color = 7884851},
            {x = 1659, y = 1081, color = 7884594},
            {x = 1759, y = 1081, color = 8278581},
            {x = 1859, y = 1081, color = 8344374},
            {x = 1959, y = 1081, color = 12821894},
            {x = 1115, y = 301, color = 4990746},
            {x = 1115, y = 401, color = 4005651},
            {x = 1115, y = 501, color = 3676945},
            {x = 1115, y = 601, color = 3676945},
            {x = 1115, y = 701, color = 3939859},
            {x = 1115, y = 801, color = 4005651},
            {x = 1115, y = 901, color = 3939602},
            {x = 1115, y = 1001, color = 3939859},
            {x = 2009, y = 260, color = 9333847},
            {x = 2009, y = 360, color = 4925980},
            {x = 2009, y = 460, color = 4991259},
            {x = 2009, y = 560, color = 4597272},
            {x = 2009, y = 660, color = 4334358},
            {x = 2009, y = 760, color = 4531480},
            {x = 2009, y = 860, color = 4531480},
            {x = 2009, y = 960, color = 4991517},
            {x = 2009, y = 1060, color = 7754304},
          },
          CONFIRM = {
            x = 1505,
            y = 1021
          }
        },
      }
    },

    FAILED = {
      COLORS = {
        {x = 530, y = 630, color = 4666905},
        {x = 630, y = 630, color = 4666905},
        {x = 830, y = 630, color = 4798491},
        {x = 930, y = 630, color = 4600855},
        {x = 1030, y = 630, color = 4864284},
        {x = 1130, y = 630, color = 4601113},
        {x = 1230, y = 630, color = 4666649},
        {x = 1330, y = 630, color = 4535320},
        {x = 1430, y = 630, color = 4930077},
        {x = 1530, y = 630, color = 5456150},
        {x = 530, y = 1050, color = 4601113},
        {x = 630, y = 1050, color = 3511013},
        {x = 730, y = 1050, color = 3244770},
        {x = 830, y = 1050, color = 3902180},
        {x = 930, y = 1050, color = 3576806},
        {x = 1030, y = 1050, color = 4798492},
        {x = 1130, y = 1050, color = 3853106},
        {x = 1230, y = 1050, color = 8773504},
        {x = 1330, y = 1050, color = 3853362},
        {x = 1430, y = 1050, color = 6286931},
        {x = 1530, y = 1050, color = 5061392},
        {x = 660, y = 700, color = 5655873},
        {x = 660, y = 750, color = 5520414}
      },

      STONE_RESUME = {
        x = 1173,
        y = 1047
      },

      RETREAT = {
        x = 700,
        y = 1047
      }
    }
  },

  IN_BATTLE = {
    COLORS = {
      SKILLBAR = {
        FULL = 13803008,
        NOT_FULL = 131072
      }
    },

    MEMBERS = {
      FIRST = {
        x = 1900,
        y = 479,
        SKILLBAR = {
          TOP = {
            x = 1739,
            y = 377
          }
        }
      },

      SECOND = {
        x = 1900,
        y = 671,
        SKILLBAR = {
          TOP = {
            x = 1739,
            y = 569
          }
        }
      },

      THIRD = {
        x = 1900,
        y = 863,
        SKILLBAR = {
          TOP = {
            x = 1739,
            y = 761
          }
        }
      },

      FOURTH = {
        x = 1900,
        y = 1055,
        SKILLBAR = {
          TOP = {
            x = 1739,
            y = 953
          }
        }
      },

      FIFTH = {
        x = 1900,
        y = 1247,
        SKILLBAR = {
          TOP = {
            x = 1739,
            y = 1145
          }
        }
      },
    },

    WAVE = {
      FINAL = {
        COLORS = {
          {x = 25, y = 1133, color = 14731683},
          {x = 56, y = 1140, color = 16711422},
          {x = 72, y = 1139, color = 16315367},
          {x = 92, y = 1135, color = 14863784},
          {x = 129, y = 1135, color = 14731683},
          {x = 166, y = 1150, color = 16184811},
          {x = 243, y = 1140, color = 16711422},
          {x = 256, y = 1144, color = 16776936},
          {x = 278, y = 1139, color = 16117474},
          {x = 280, y = 1154, color = 15325623},
          {x = 291, y = 1143, color = 15921906},
          {x = 311, y = 1143, color = 16776954},
        }
      }
    }
  },

  SIXHR = {
    HOME = {
      SP_MISSION = {
        x = 1239,
        y = 975
      }
    },

    RAID = {
      ENCOUNTERED = {
        COLORS = {
          {x = 100, y = 1245, color = 41725},
          {x = 200, y = 1245, color = 37093},
          {x = 300, y = 1245, color = 37093},
          {x = 400, y = 1245, color = 153254},
          {x = 500, y = 1245, color = 7709647},
          {x = 600, y = 1245, color = 16777215},
          {x = 700, y = 1245, color = 27843},
          {x = 800, y = 1245, color = 37093},
          {x = 900, y = 1245, color = 39665},
          {x = 1148, y = 1245, color = 16136448},
          {x = 1248, y = 1245, color = 16399616},
          {x = 1348, y = 1245, color = 9969408},
          {x = 1448, y = 1245, color = 16710908},
          {x = 1548, y = 1245, color = 9969408},
          {x = 1648, y = 1245, color = 9969408},
          {x = 1748, y = 1245, color = 11019264},
          {x = 1848, y = 1245, color = 16399616},
          {x = 1948, y = 1245, color = 10888192},
        }
      },

      COMPLETE = {
        COLORS = {
          {x = 657, y = 357, color = 4074267},
          {x = 757, y = 357, color = 3351574},
          {x = 857, y = 357, color = 658179},
          {x = 957, y = 357, color = 658179},
          {x = 1057, y = 357, color = 658179},
          {x = 1157, y = 357, color = 658179},
          {x = 1257, y = 357, color = 658179},
          {x = 1357, y = 357, color = 4074267},
          {x = 1107, y = 720, color = 7222581},
          {x = 1207, y = 720, color = 7222581},
          {x = 1307, y = 720, color = 7222581},
          {x = 1407, y = 720, color = 7222581},
          {x = 1507, y = 720, color = 7222581},
          {x = 1607, y = 720, color = 7222581},
          {x = 1707, y = 720, color = 7222581},
          {x = 1807, y = 720, color = 7222581},
          {x = 1907, y = 720, color = 7222581},
        },

        HOME = {
          x = 1497,
          y = 838
        }
      }
    }
  },

  OATH = {
    HOME = {
      MISSIONS = {
        x = 637,
        y = 1100
      },

      SAVED_MISSION = {
        x = 800,
        y = 1100
      },

      BATTLE = {
        x = 169,
        y = 1000,
      }
    },

    ENCOUNTERED = {
      COLORS = {
        {x = 100, y = 1245, color = 41725},
        {x = 200, y = 1245, color = 37093},
        {x = 300, y = 1245, color = 37093},
        {x = 400, y = 1245, color = 153254},
        {x = 500, y = 1245, color = 7709647},
        {x = 600, y = 1245, color = 16777215},
        {x = 700, y = 1245, color = 27843},
        {x = 800, y = 1245, color = 37093},
        {x = 900, y = 1245, color = 39665},
        {x = 1148, y = 1245, color = 16136448},
        {x = 1248, y = 1245, color = 16399616},
        {x = 1348, y = 1245, color = 9969408},
        {x = 1448, y = 1245, color = 16710908},
        {x = 1548, y = 1245, color = 9969408},
        {x = 1648, y = 1245, color = 9969408},
        {x = 1748, y = 1245, color = 11019264},
        {x = 1848, y = 1245, color = 16399616},
        {x = 1948, y = 1245, color = 10888192},
      },

      PROCEED = {
        x = 1348,
        y = 1251
      }
    },

    BATTLE = {
      PREP = {
        PROCEED = {
          x = 1356,
          y = 819
        },
      },

      PARTY_SELECT = {
        RP_SELECT = {
          RP1 = { x = 787, y = 840 },
          RP2 = { x = 1007, y = 840 },
          RP3 = { x = 1227, y = 840 }
        },


        INSUFFICIENT_RP = {
          CONSUME = {
            COLORS = {
              --[[
              -- Reduced color matching to be compatible with 6hr raid
              --
              --{x = 608, y = 508, color = 15327428},
              --{x = 708, y = 508, color = 15261635},
              --{x = 808, y = 508, color = 15261379},
              --{x = 908, y = 508, color = 15064256},
              --{x = 1008, y = 508, color = 14998207},
              --{x = 1108, y = 508, color = 15195842},
              --{x = 1208, y = 508, color = 15195585},
              --{x = 1308, y = 508, color = 15261378},
              --{x = 1408, y = 508, color = 15195841},
              --{x = 608, y = 643, color = 15130049},
              --{x = 708, y = 643, color = 15130049},
              --{x = 908, y = 643, color = 5722449},
              --{x = 1008, y = 643, color = 14801084},
              --{x = 1208, y = 643, color = 14932414},
              --{x = 1308, y = 643, color = 14998207},
              --{x = 1408, y = 643, color = 15261379},
              --{x = 608, y = 892, color = 15327428},
              --{x = 1008, y = 892, color = 14998207},
              --{x = 1408, y = 892, color = 15195841},
              --]]
              {x = 708, y = 892, color = 812761},
              {x = 908, y = 892, color = 480980},
              {x = 1108, y = 892, color = 11471627},
              {x = 1208, y = 892, color = 16777215},
              {x = 1308, y = 892, color = 11143176},
            },

            CONFIRM = {
              x = 1284,
              y = 870
            }
          },

          PURCHASE = {
            COLORS = {
              {x = 608, y = 500, color = 15196098},
              {x = 708, y = 500, color = 15326915},
              {x = 808, y = 500, color = 15327171},
              {x = 908, y = 500, color = 15261635},
              {x = 1008, y = 500, color = 15129536},
              {x = 1108, y = 500, color = 15064000},
              {x = 1208, y = 500, color = 15130049},
              {x = 1308, y = 500, color = 15129793},
              {x = 1408, y = 500, color = 15130049},
              {x = 608, y = 690, color = 15129793},
              {x = 708, y = 690, color = 15130048},
              {x = 808, y = 690, color = 15129793},
              {x = 908, y = 690, color = 5722449},
              {x = 1008, y = 690, color = 15063999},
              {x = 1108, y = 690, color = 5722449},
              {x = 1208, y = 690, color = 15129793},
              {x = 1308, y = 690, color = 15129792},
              {x = 1408, y = 690, color = 15261122},
              {x = 900, y = 801, color = 1539041},
              {x = 1000, y = 801, color = 11312244},
              {x = 1100, y = 801, color = 13053743},
              {x = 1200, y = 801, color = 16777215},
              {x = 1300, y = 801, color = 12857135},
              {x = 1400, y = 801, color = 15195585},
            },

            CLOSE = {
              x = 1444,
              y = 456
            }
          }
        },
      },

      COMPLETE = {
        COLORS = {
          {x = 657, y = 357, color = 4074267},
          {x = 757, y = 357, color = 3351574},
          {x = 857, y = 357, color = 658179},
          {x = 957, y = 357, color = 658179},
          {x = 1057, y = 357, color = 658179},
          {x = 1157, y = 357, color = 658179},
          {x = 1257, y = 357, color = 658179},
          {x = 1357, y = 357, color = 4074267},
          {x = 1107, y = 720, color = 7222581},
          {x = 1207, y = 720, color = 7222581},
          {x = 1307, y = 720, color = 7222581},
          {x = 1407, y = 720, color = 7222581},
          {x = 1507, y = 720, color = 7222581},
          {x = 1607, y = 720, color = 7222581},
          {x = 1707, y = 720, color = 7222581},
          {x = 1807, y = 720, color = 7222581},
          {x = 1907, y = 720, color = 7222581},
          {x = 1100, y = 843, color = 2143986},
          {x = 1200, y = 843, color = 16777215},
          {x = 1300, y = 843, color = 16777215},
          {x = 1400, y = 843, color = 16777215},
          {x = 1600, y = 842, color = 15421520},
          {x = 1700, y = 842, color = 13316144},
          {x = 1800, y = 842, color = 11676202},
          {x = 1900, y = 842, color = 13185072},
        },

        BOSS = {
          x = 527,
          y = 670
        },

        OATH_HOME = {
          x = 1288,
          y = 836
        },

        SAVED_MISSION = {
          x = 1757,
          y = 836
        }
      }
    },
  },

  MAGONIA = {
    POTS = {
      FIRST = {
        BREAK = {
          x = 767,
          y = 683,
          COLOR = {AVAILABLE = 1739750},
          CONFIRM = {
            NORMAL = {x = 1121, y = 689},
            HAMMER = {x = 1147, y = 689}
          }
        }
      }
    },

    HOME = {
      POTS = {
        x = 1690,
        y = 505
      },

      MISSIONS = {
        FIRST = {x = 1514, y = 990},
        SECOND = {x = 1694, y = 990},
        THIRD = {x = 1899, y = 990},
      },

      BP_RECOVER = {
        x = 312,
        y = 1050,
        COLOR = { AVAILABLE = 13985792 },
        OPTIONS = {
          EVENT_BPMAX = {
            name = "EVENT_BPMAX",
            x = 646,
            y = 1037,
            COLOR = { AVAILABLE = 1427975 }
          },
          EVENT_BP50 = {
            name = "EVENT_BP50",
            x = 1322,
            y = 1037,
            COLOR = { AVAILABLE = 1361415 }
          }
        },
        CONFIRM = {x = 1334, y = 982}
      },

      AID_REQUESTS = {
        x = 184,
        y = 826
      }
    },

    AID_REQUESTS = {
      HOME = {x = 1313, y = 454},
      BATTLE_FINISHED = {
        CONFIRM = {x = 1081, y = 966},
        COLORS = {
          {x = 950, y = 964, color = 1539298},
          {x = 1101, y = 966, color = 1076188},
          {x = 1543, y = 465, color = 16776960},
          {x = 1024, y = 1035, color = 15393221},
          {x = 1872, y = 1233, color = 0},
          {x = 204, y = 332, color = 0}
        }
      },
      REQUEST = {
        {x = 1594, y = 766, COLOR = { AVAILABLE = 12394272 }}
      }
    },

    BOSS = {
      APPEARED = {
        SKIP = {x = 1931, y = 258}
      },

      UNIT_SELECT = {
        RAID_TOP = {x = 1255, y = 307},
        REFRESH = {x = 103, y = 1269},
        BP_RECOVER = {
          x = 383,
          y = 1269,
          TWO_MINS = {x = 532, y = 556},
          COMPLETE = {x = 1783, y = 785},
          COLORS = {
            RECOVERING = 11550773,
            RECOVER_COMPLETE = 3757720
          },
          OPTIONS = {
            EVENT_BPMAX = {
              name = "EVENT_BPMAX",
              x = 652,
              y = 1025,
              COLOR = { AVAILABLE = 1162502 }
            },
            EVENT_BP50 = {
              name = "EVENT_BP50",
              amount = 4,
              x = 1327,
              y = 1025,
              COLOR = { AVAILABLE = 1492745 }
            }
          },
          CONFIRM = {
            x = 1250,
            y = 980,
            BP50_AMOUNT = {
              INCREASE = {x = 1301, y = 816},
              DECREASE = {x = 988, y = 816}
            }
          }
        },
        AID_REQUEST = {
          x = 592,
          y = 1269,
          ALL = {x = 876, y = 938}
        },
        ATTACK = {x = 1292, y = 1249},
        UNITS = {
          {x = 1556, y = 320},
          {x = 1556, y = 540},
          {x = 1556, y = 760},
          {x = 1556, y = 980},
          {x = 1556, y = 1200},
          {x = 1880, y = 320},
          {x = 1880, y = 540},
          {x = 1880, y = 760},
          {x = 1880, y = 980},
          {x = 1880, y = 1200}
        },
        INSUFFICIENT_BP = {
          CONFIRM = {
            x = 1106,
            y = 972
          },
          COLORS = {
            {x = 947, y = 970, color = 680920},
            {x = 1096, y = 970, color = 481493},
            {x = 1035, y = 1037, color = 15261378},
            {x = 1538, y = 462, color = 16776960}
          }
        },
        COLORS = {
          {x = 1292, y = 1249, color = 12397612},
          {x = 103, y = 1269, color = 9533707},
          {x = 1255, y = 307, color = 4499517}
        },
      },

      IN_BATTLE = {
        SKIP = {x = 1534, y = 1279}
      },

      ALREADY_DEFEATED = {
        CONFIRM = {x = 1078, y = 966},
        COLORS = {
          {x = 1033, y = 1046, color = 15195586},
          {x = 957, y = 973, color = 613846},
          {x = 1093, y = 972, color = 878553},
          {x = 1541, y = 467, color = 16776960}
        },
        BP_NOT_CONSUMED = {
          CONFIRM = {x = 1042, y = 962},
          COLORS = {
            {x = 947, y = 970, color = 680920},
            {x = 1096, y = 970, color = 481493},
            {x = 1035, y = 1037, color = 15261378},
            {x = 1538, y = 462, color = 16776960},
            {x = 214, y = 349, color = 0},
            {x = 1750, y = 1199, color = 0}
          }
        }
      },

      BATTLE_COMPLETE = {
        COLORS = {
          {x = 1100, y = 400, color = 8722968},
          {x = 1200, y = 400, color = 3541770},
          {x = 1300, y = 400, color = 3738378},
          {x = 1400, y = 400, color = 3673098},
          {x = 1500, y = 400, color = 10060161},
          {x = 1600, y = 400, color = 3279368},
          {x = 1700, y = 400, color = 3410441},
          {x = 1800, y = 400, color = 3476234},
          {x = 1900, y = 400, color = 8329494}
        },
        REWARDS_CONFIRM = {x = 1500, y = 589},
        MAGONIA_HOME = {x = 1199, y = 750},
        BREAK_POTS = {x = 1666, y = 772}
      }
    },
  },

  RECOLLECTION = {
    HOME = {
      PROCEED = {x = 1658, y = 1166}
    },

    MISSION = {
      COMPLETE = {
        TREASURE_CHANCE = {
          COLORS = {
            {x = 368, y = 640, color = 8652116},
            {x = 468, y = 640, color = 10099578},
            {x = 568, y = 640, color = 7996807},
            {x = 668, y = 640, color = 15190504},
            {x = 768, y = 640, color = 7545495},
            {x = 868, y = 640, color = 4069779},
            {x = 968, y = 640, color = 1183355},
            {x = 1068, y = 640, color = 1446275}
          }
        }
      }
    },

    PATHS = {
      TAKEN = { COLOR = 1776411 },

      AP_INSUFFICIENT = {
        CONFIRM = {x = 1029, y = 940},
        COLORS = {
          {x = 1029, y = 940, color = 12394785},
          {x = 726, y = 972, color = 15195842},
          {x = 1339, y = 975, color = 15195841},
          {x = 1021, y = 1038, color = 15261379}
        }
      },

      LAMP = {
        x = 140,
        y = 572,
        COLOR = {
          AVAILABLE = 1638144,
          IN_USE = 13352784
        },
        CONFIRM = {x = 1333, y = 1122},
      },

      [2] = {
        {x = 638, y = 1223, IMAGE = {x = 520, y = 920}},
        {x = 1413, y = 1223, IMAGE = {x = 1300, y = 920}}
      },

      [3] = {
        {x = 442, y = 1223, IMAGE = {x = 320, y = 920}},
        {x = 1023, y = 1223, IMAGE = {x = 900, y = 920}},
        {x = 1607, y = 1223, IMAGE = {x = 1490, y = 920}}
      },

      [4] = {
        {x = 294, y = 1223, IMAGE = {x = 180, y = 920}},
        {x = 780, y = 1223, IMAGE = {x = 660, y = 920}},
        {x = 1265, y = 1223, IMAGE = {x = 1150, y = 920}},
        {x = 1753, y = 1223, IMAGE = {x = 1640, y = 920}}
      },
    },

    TREASURE_CHANCE = {
      FAILED = {
        COLORS = {
          {x = 1444, y = 764, color = 4497109},
          {x = 1398, y = 827, color = 4827123},
          {x = 1568, y = 801, color = 4695271},
          {x = 1505, y = 758, color = 4562382},
          {x = 1390, y = 873, color = 3704746},
          {x = 1488, y = 873, color = 3704746},
          {x = 1573, y = 873, color = 3704746}
          -- {x = 1549, y = 921, color = 1913662},
          -- {x = 1365, y = 983, color = 5023419},
          -- {x = 1504, y = 927, color = 4561065},
          -- {x = 1551, y = 965, color = 5022901}
        }
      },
      TICKET = {
        CONFIRM = {x = 1182, y = 961},
        OPTIONS = {
          DEFROT = {
            name = "DEFROT",
            x = 244,
            y = 1204,
            COLOR = { AVAILABLE = 163319 }
          },
          MAURICE = {
            name = "MAURICE",
            x = 602,
            y = 1201,
            COLOR = { AVAILABLE = 229368 }
          },
          ADELHEID = {
            name = "ADELHEID",
            x = 959,
            y = 1198,
            COLOR = { AVAILABLE = 229368 }
          },
          MARYUS = {
            name = "MARYUS",
            x = 1358,
            y = 1254,
            COLOR = { AVAILABLE = 12552455 }
          },
          CHARLOT = {
            name = "CHARLOT",
            x = 1818,
            y = 1252,
            COLOR = { UNAVAILABLE = 2557952 }
          }
        }
      },

      COMPLETE = {
        CONFIRM = {x = 1033, y = 1236},
        COLORS = {
          {x = 223, y = 1060, color = 7222581},
          {x = 323, y = 1060, color = 8144699},
          {x = 423, y = 1060, color = 7222581},
          {x = 523, y = 1060, color = 7222581},
          {x = 623, y = 1060, color = 7222581},
          {x = 723, y = 1060, color = 7222581},
          {x = 823, y = 1060, color = 7222581},
          {x = 923, y = 1060, color = 7222581},
          {x = 1023, y = 1060, color = 8210748},
          {x = 1123, y = 1060, color = 7222581},
          {x = 1223, y = 1060, color = 7222581},
          {x = 1323, y = 1060, color = 7222581},
          {x = 1423, y = 1060, color = 7222581},
          {x = 1523, y = 1060, color = 7222581},
          {x = 1623, y = 1060, color = 7222581},
          {x = 1723, y = 1060, color = 8210748},
          {x = 1823, y = 1060, color = 7222581}
        }
      }
    },

    BOSS = {
      ENCOUNTERED = {
        COLORS = {
          {x = 1197, y = 735, color = 12788001},
          {x = 1192, y = 836, color = 5969430},
          {x = 1864, y = 737, color = 12656929},
          {x = 1918, y = 773, color = 9772060},
          {x = 1973, y = 815, color = 6559511}
        }
      },

      DEFEATED = {
        COLORS = {
          {x = 224, y = 1271, color = 4074780},
          {x = 1149, y = 1176, color = 478981},
          {x = 1539, y = 1176, color = 544514},
          {x = 1912, y = 1176, color = 16777185},
          {x = 1578, y = 1219, color = 605955}
        },
        ITEMS_CONFIRM = {x = 1808, y = 1233},
        PROCEED = {x = 1112, y = 1060}
      }
    },
  },

  BATTLE_MEMBERS_LIST = {"FIRST", "SECOND", "THIRD", "FOURTH", "FIFTH"},

  GREETING = {
    DIALOG = {
      NOT_GREETED = {
        COLORS = {
          {x = 431, y = 472, color = 11252234},
          {x = 482, y = 463, color = 16514028},
          {x = 535, y = 472, color = 10923530},
          {x = 483, y = 493, color = 11712266},
          {x = 432, y = 526, color = 10069002},
          {x = 548, y = 557, color = 920070},
          {x = 971, y = 531, color = 16777215},
          {x = 1654, y = 512, color = 15459014},
          {x = 450, y = 783, color = 15064256},
          {x = 684, y = 770, color = 1229064},
          {x = 889, y = 772, color = 962569},
          {x = 1026, y = 772, color = 15261891},
          {x = 1161, y = 775, color = 1973790},
          {x = 1405, y = 767, color = 5131596},
          {x = 1612, y = 772, color = 15129792}
        },

        STICKERS = {
          x = 486,
          y = 502
        },

        CLOSE = {
          x = 1691,
          y = 262
        }
      },

      GREETED = {
        COLORS = {
          {x = 392, y = 396, color = 15261635},
          {x = 447, y = 529, color = 10857482},
          {x = 535, y = 472, color = 15130049},
          {x = 504, y = 554, color = 16711412},
          {x = 535, y = 600, color = 10134538},
          {x = 553, y = 617, color = 4734251},
          {x = 978, y = 601, color = 16645370},
          {x = 1587, y = 366, color = 15064000},
          {x = 685, y = 797, color = 14998206},
          {x = 917, y = 814, color = 2236706},
          {x = 1160, y = 806, color = 2500134},
          {x = 1532, y = 805, color = 15195842}
        },

        STICKERS = {
          x = 483,
          y = 564
        },

        CLOSE = {
          x = 1696,
          y = 337
        }
      },

      STICKER_SEL = {
        ONE   = {x = 377,  y = 528},
        TWO   = {x = 970,  y = 528},
        THREE = {x = 1531, y = 528},
        FOUR  = {x = 377,  y = 780},
        FIVE  = {x = 970,  y = 780},
        SIX   = {x = 1531, y = 780},
        SEVEN = {x = 377,  y = 1029},
        EIGHT = {x = 970,  y = 1029},
        NINE  = {x = 1531, y = 1029},

        LIST = {
          ONE   = {x = 172, y = 1276},
          TWO   = {
            x = 422,
            y = 1276,
            BORDER = {
              {x = 292, y = 1300},
              {x = 307, y = 1298},
              {x = 324, y = 1270},
              {x = 498, y = 1253},
              {x = 516, y = 1272},
              {x = 527, y = 1273}
            }
          },
          THREE = {x = 645, y = 1276},
          FOUR  = {x = 889, y = 1276},
          FIVE  = {x = 1122, y = 1276},
          SIX   = {x = 1359, y = 1276},
          SEVEN = {x = 1592, y = 1276},
          EIGHT = {x = 1832, y = 1276}
        }
      }
    }
  },

  FRIENDS_LIST = {
    FIRST = {
      GREET = {x = 1863, y = 530},
      RANK_BORDER = {
        {x = 598, y = 438},
        {x = 598, y = 481},
        {x = 599, y = 516},
        {x = 606, y = 539},
        {x = 626, y = 543},
        {x = 657, y = 524},
        {x = 682, y = 503},
        {x = 713, y = 477},
        {x = 738, y = 454},
        {x = 758, y = 424},
        {x = 743, y = 400},
        {x = 707, y = 401},
        {x = 659, y = 398}
      }
    },

    SECOND = {
      GREET = {x = 1881, y = 855}
    },

    THIRD = {
      GREET = {x = 1881, y = 1187},
      CENTER = {x = 1491, y = 1219}
    },
  },

  UNITED_BATTLE = {
    HOME = {
      SP_MISSION = {
        x = 1942,
        y = 1225
      }
    }
  }
}
