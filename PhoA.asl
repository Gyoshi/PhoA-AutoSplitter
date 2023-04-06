/*
indices and item IDs used here came from this:
google sheet explaining save file data by Pimez: https://docs.google.com/spreadsheets/d/1AsOEO6XCPuL29ej32D46gu-Uj5CbhDqaEGVwEBiGTBI/
*/

state("PhoenotopiaAwakening") {}

startup {
    // -- Metadata --
    //Items and Upgrades
    vars.itemMeta = new Dictionary<string, Tuple<string,int,int>> { // key: (type, index, ID)
        {"Slingshot",               Tuple.Create("Tool",     0,      30)},
        {"Anuri Pearlstone",        Tuple.Create("Item",     0,      98)},
        {"Mysterious Golem Head",   Tuple.Create("Status",   262,    21)},
        {"Composite Bat",           Tuple.Create("Status",   257,    7)},
        {"Lisa's ID Card",          Tuple.Create("Item",     0,      122)},
        {"Bandit's Flute",          Tuple.Create("Tool",     0,      29)},
        {"Bombs",                   Tuple.Create("Tool",     0,      31)},
        {"Concentration",           Tuple.Create("Status",   239,    16)},
        {"Sonic Spear",             Tuple.Create("Tool",     0,      33)},
        {"Royal Hymn",              Tuple.Create("Status",   252,    126)},
        {"Double Crossbow",         Tuple.Create("Tool",     0,      38)},
        {"Spheralis Shard",         Tuple.Create("Item",     0,      36)},
        {"Spheralis",               Tuple.Create("Tool",     0,      35)}
    };
    vars.statusOffset = 232;
    vars.has = new Dictionary<string, int>(vars.itemMeta.Count);
    foreach (string key in vars.itemMeta.Keys) {vars.has[key] = 0;}
    vars.had = new Dictionary<string, int>(vars.has);
        
    // Flags
    vars.flagMeta = new Dictionary<string, int> { // number is p1_bool index (row number in excel)
        {"Lockpick Flag",           27},
        {"Games Begin",             29},
        {"Free Fran",               186},
        {"Wrecker",                 41},
        {"Fix Bart",                42},
        {"Thomas Kidnapped",        43},
        {"Katash 1",                507},
        {"Tower of Dog",            552},
        {"Tower of the King",       553},
        {"Tower of the Queen",      551},
        {"Mother Computer 1",       558},
        {"Megalith Station Gate",   628},
        {"Gate to ADAM",            631}
        // "Beat the Game" handled individually
    };
    
    // Locations
    vars.roomMeta = new Dictionary<string, string> {  // yup some of these have capital P's for no discernable reason
        {"Enter Doki Forest",       "p1_duri_forest_01"},
        {"Enter Atai Region",       "P1_world_map_SW"},
        {"Bridge Skip",             "p1_bridge_daetai_02"},
        {"Enter Daea Region",       "p1_world_map_c"},
        {"Enter Aqua Line",         "P1_daea_sewers_01"},
        {"Enter Castle Dungeons",   "P1_dungeon_00"},
        {"Enter White Tower",       "P1_towers_00"},
        {"Climb White Tower",       "P1_tower_boss"},
        {"Enter Cosette Region",    "p1_world_map_c2"},
        {"Enter Scorchlands",       "p1_scorchlands_00"},
        {"Enter Mul Caves",         "p1_mul_caves_00"},
        {"Enter Mul Caves Nest",    "p1_mul_caves_02"},
        {"Enter SPHERE",            "p1_sphere_garden_01"},
        {"Enter E.D.E.N.",          "p1_phoenix_sub"},
        {"Enter Lab D",             "p1_phoenix_lab_mr_01"},
        {"Enter Lab F",             "p1_phoenix_lab_lr_01"}
    };
    vars.visited = new List<string>();
    
    // -- Settings --
    // Items and upgrades
    settings.Add("Items and Upgrades",  true, "Items and Upgrades     アイテム");

    settings.Add("Slingshot",               true,   "Slingshot         パチンコ", "Items and Upgrades");
    settings.Add("Anuri Pearlstone",        false,  "Anuri Pearlstone  アヌリの宝珠", "Items and Upgrades");
    settings.Add("Mysterious Golem Head",   true,   "Golem Head        謎のゴーレムヘッド", "Items and Upgrades");
    settings.Add("Composite Bat",           false,  "Composite Bat     コンポジットバット", "Items and Upgrades");
    settings.Add("Lisa's ID Card",          false,  "Lisa's ID Card    リサのＩⅮカード", "Items and Upgrades");
    settings.Add("Bandit's Flute",          true,   "Bandit's Flute    盗賊の笛", "Items and Upgrades");
    settings.Add("Bombs",                   false,  "Bombs             ボム", "Items and Upgrades");
    settings.Add("Concentration",           false,  "Concentration     コンセントレーション", "Items and Upgrades");
    settings.Add("Sonic Spear",             true,   "Sonic Spear       ソニックスピア", "Items and Upgrades");
    settings.Add("Royal Hymn",              false,  "Royal Hymn        王家の讃美歌", "Items and Upgrades");
    settings.Add("Double Crossbow",         false,  "Double Crossbow   ダブルクロスボウ", "Items and Upgrades");
    settings.Add("Spheralis Shard",         true,   "Spheralis Shard   スフィアラリスのかけら", "Items and Upgrades");
    settings.Add("Spheralis",               true,   "Spheralis         スフィアラリス", "Items and Upgrades");
    
    settings.SetToolTip("Anuri Pearlstone", "Splits each time you pick up a pearlstone");
    settings.SetToolTip("Mysterious Golem Head", "Pick up the mysterious golem head from its crash site in the Anuri Temple");
    
    // Flags
    settings.Add("Miscellaneous Flags", true, "Miscellaneous Flags    フラグ");

    settings.Add("Lockpick Flag",           true,   "Lockpick Flag         アダルん家", "Miscellaneous Flags");
    settings.Add("Games Begin",             false,  "Games Begin           隠れんぼの始まり", "Miscellaneous Flags");
    settings.Add("Free Fran",               false,  "Free Fran             フラン先生の解放", "Miscellaneous Flags");
    settings.Add("Wrecker",                 true,   "Wrecker               レッカー", "Miscellaneous Flags");
    settings.Add("Fix Bart",                false,  "Fix Bart              バートの修理", "Miscellaneous Flags");
    settings.Add("Thomas Kidnapped",        false,  "Thomas Kidnapped      トーマスの誘拐", "Miscellaneous Flags");
    settings.Add("Katash 1",                true,   "Katash 1              カターシュ１", "Miscellaneous Flags");
    settings.Add("Tower of Dog",            true,   "Tower of Dog          番犬の塔", "Miscellaneous Flags");
    settings.Add("Tower of the King",       true,   "Tower of the King     王者の塔", "Miscellaneous Flags");
    settings.Add("Tower of the Queen",      true,   "Tower of the Queen    王妃の塔", "Miscellaneous Flags");
    settings.Add("Mother Computer 1",       false,  "Mother Computer 1     マザコン１", "Miscellaneous Flags");
    settings.Add("Megalith Station Gate",   true,   "Megalith Station      メガリスステーション", "Miscellaneous Flags");
    settings.Add("Gate to ADAM",            true,   "Gate to ADAM          最深部のADAMへの隔壁", "Miscellaneous Flags");
    settings.Add("Beat the Game",           true,   "Beat the Game         ゲームクリア", "Miscellaneous Flags");
    
    settings.SetToolTip("Lockpick Flag", "Find out Adar's house is locked by inspecting the door");
    settings.SetToolTip("Games Begin", "Entrust the lockpicking to Garnet and start Hide & Seek with the kids");
    settings.SetToolTip("Wrecker", "Defeat the Wrecker in Thomas' Lab");
    settings.SetToolTip("Fix Bart", "Have Thomas fix Bart('s golem head)");    
    settings.SetToolTip("Katash 1", "Defeat Katash atop the White Towers");
    settings.SetToolTip("Gate to ADAM", "Open the final gate in EDEN with 6 chrystalis");
    settings.SetToolTip("Beat the Game", "Any% timer stop (after Katash 2)");

    // Locations
    settings.Add("Locations",           true, "Locations              場所");

    settings.Add("Enter Doki Forest",       false,   "Enter Doki Forest         ドキの森", "Locations");
    settings.Add("Enter Atai Region",       false,   "Enter Atai Region         アタイのフィールド", "Locations");
    settings.Add("Bridge Skip",             true,    "Bridge Skip               ブリッジスキップ", "Locations");
    settings.Add("Enter Daea Region",       false,   "Enter Daea Region         デイアのフィールド", "Locations");
    settings.Add("Enter Aqua Line",         false,   "Enter Aqua Line           秘密の地下道", "Locations");
    settings.Add("Enter Castle Dungeons",   false,   "Enter Castle Dungeons     城の牢獄", "Locations");
    settings.Add("Enter White Tower",       false,   "Enter White Towers        城の塔", "Locations");
    settings.Add("Climb White Tower",       false,   "Climb White Towers        城の塔の登り切り", "Locations");
    settings.Add("Enter Cosette Region",    false,   "Enter Cosette Region      コセットのフィールド", "Locations");
    settings.Add("Enter Scorchlands",       true,    "Enter Scorchlands         スコーチランド", "Locations");
    settings.Add("Enter Mul Caves",         true,    "Enter Mul Caves           ミュール洞窟の外", "Locations");
    settings.Add("Enter Mul Caves Nest",    false,   "Enter Mul Caves Nest      ミュール洞窟の巣", "Locations");
    settings.Add("Enter SPHERE",            false,   "Enter SPHERE              スフィアのビル", "Locations");
    settings.Add("Enter E.D.E.N.",          false,   "Enter E.D.E.N.            E.D.E.N.", "Locations");
    settings.Add("Enter Lab D",             false,   "Enter E.D.E.N. Lab D      D", "Locations");
    settings.Add("Enter Lab F",             false,   "Enter E.D.E.N. Lab F      F", "Locations");
    
    settings.SetToolTip("Locations", "These only trigger when you enter the location for the first time");
    settings.SetToolTip("Bridge Skip", "Enter the middle room of Kingdom Bridge");
    settings.SetToolTip("Enter White Tower", "Enter the base of the towers (room next to balcony)");
    settings.SetToolTip("Climb White Tower", "Enter the room with the save before the Katash fight");
    settings.SetToolTip("Enter Mul Caves", "The room with the save before the caves proper");
    settings.SetToolTip("Enter Mul Caves Nest", "The first room with the white nest thingies");
    settings.SetToolTip("Enter SPHERE", "Specifically the building itself, not directly from the overworld");
    
    // Load asl-help
    Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Unity");

    refreshRate = 35;
}

init {
    print("start init sleep");
    Thread.Sleep(3000);
    print("end init sleep");
    //TODO: figure out crash on game launch:
    vars.Helper.TryLoad = (Func<dynamic, bool>)(mono => {
        vars.Helper["inChoiceMode"] = mono.Make<bool>("PT2", "director", "_in_CHOICE_mode");
        vars.Helper["allowInterrupt"] = mono.Make<bool>("PT2", "director", "allow_player_interrupt");
        vars.Helper["globalTimer"] = mono.Make<int>("PT2", "director", "global_timer");
        
        vars.Helper["toolInv"] = mono.MakeArray<int>("PT2", "save_file", "_tool_IDs");
        vars.Helper["itemInv"] = mono.MakeArray<int>("PT2", "save_file", "_item_IDs");
        vars.Helper["itemCount"] = mono.MakeArray<int>("PT2", "save_file", "_item_ID_count");
        vars.Helper["statusInv"] = mono.MakeArray<int>("PT2", "save_file", "_status_inventory"); // tuskStrike-lifeRing
        //vars.Helper["stats"] = mono.MakeArray<int>("PT2", "save_file", "_general_ints"); // playtime-critters
        vars.Helper["flags"] = mono.MakeArray<bool>("PT2", "save_file", "_booleans");
        
        vars.Helper["room"] = mono.MakeString("PT2", "_room_to_load");
        vars.Helper["level_load_in_progress"] = mono.Make<bool>("PT2", "level_load_in_progress");
        
        return true; 
    });
}

start
{
    return (current.room == "cutscene_intro") && (old.inChoiceMode && !current.inChoiceMode);
}

onStart {
    // Reset visited locations
    vars.visited.Clear();
}

update
{
    // print("DEBUG : " + current.room);
    foreach (var elem in vars.itemMeta) {
        string key = elem.Key;
        string type = elem.Value.Item1;
        int index = elem.Value.Item2 - vars.statusOffset;
        int id = elem.Value.Item3;

        vars.had[key] = vars.has[key];
        int numItems = 0;
        switch (type) {
            case ("Status") :
                if (current.statusInv[index]==id)
                    numItems = 1;
                break;
            case ("Item") :
                for (int i = 0; i < current.itemInv.Length; i++)
                {
                    if (current.itemInv[i] == id)
                    {
                        numItems = current.itemCount[i];
                        break;
                    }
                }
                break;
            case ("Tool") :
                if (((int[])current.toolInv).Any(x => x == id))
                    numItems = 1;
                break;
        }
        vars.has[key] = numItems;
    }
}

split {
    // Items and Upgrades    
    foreach (var key in vars.itemMeta.Keys) {
        if (vars.has[key] > vars.had[key]) {
            print("SPLIT : " + key);
            return settings[key];
        }
    }
    // Flags
    foreach (string key in vars.flagMeta.Keys) {
        int index = vars.flagMeta[key];
        if (!old.flags[index] && current.flags[index]) {
            print("SPLIT : " + key);
            return settings[key];
        }
    }
    // Locations
    foreach (string key in vars.roomMeta.Keys) {
        string roomName = vars.roomMeta[key];
        if ((current.room==roomName) && !vars.visited.Contains(roomName)) {
            print("SPLIT : " + key);
            vars.visited.Add(roomName);
            return settings[key];
        }
    }
    // Any% Stop
    if ((current.room == "p1_phoenix_pods") && (old.allowInterrupt && !current.allowInterrupt)) {
        return settings["Beat the Game"];
    }
}

isLoading
{
    return (old.globalTimer == current.globalTimer) && (current.level_load_in_progress || old.level_load_in_progress);
}