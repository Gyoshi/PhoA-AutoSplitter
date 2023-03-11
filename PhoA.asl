/*
indices and item IDs used here came from this:
google sheet explaining save file data by Pimez: https://docs.google.com/spreadsheets/d/1AsOEO6XCPuL29ej32D46gu-Uj5CbhDqaEGVwEBiGTBI/
*/

state("PhoenotopiaAwakening") {}

startup {
    // -- Metadata --
    //Items and Upgrades
    vars.itemMeta = new Dictionary<string, Tuple<bool,string,int,int>> { // key: (default setting, type, index, ID)
        {"Slingshot         パチンコ",              Tuple.Create(true,      "Tool",     0,      30)},
        {"Anuri Pearlstone  アヌリの宝珠",          Tuple.Create(false,     "Item",     0,      98)},
        {"Golem Head        謎のゴーレムヘッド",    Tuple.Create(true,      "Status",   262,    21)},
        {"Composite Bat     コンポジット・バット",  Tuple.Create(false,     "Status",   257,    7)},
        {"Lisa's ID Card    リサのＩⅮカード",       Tuple.Create(false,     "Item",     0,      122)},
        {"Bandit's Flute    盗賊の笛",              Tuple.Create(true,      "Tool",     0,      29)},
        {"Bombs             ボム",                  Tuple.Create(false,     "Tool",     0,      31)},
        {"Concentration     コンセントレーション",      Tuple.Create(false,     "Status",   239,    16)},
        {"Sonic Spear       ソニック・スピア",          Tuple.Create(true,      "Tool",     0,      33)},
        {"Royal Hymn        王家の讃美歌",              Tuple.Create(false,     "Status",   252,    126)},
        {"Double Crossbow   ダブル・クロスボウ",         Tuple.Create(false,     "Tool",     0,      38)},
        {"Spheralis Shard   スフィアラリスのかけら",    Tuple.Create(true,      "Item",     0,      36)},
        {"Spheralis         スフィアラリス",            Tuple.Create(true,      "Tool",     0,      35)}
    };
    vars.statusOffset = 232;
    vars.has = new Dictionary<string, int>(vars.itemMeta.Count);
    foreach (string key in vars.itemMeta.Keys) {vars.has[key] = 0;}
    vars.had = new Dictionary<string, int>(vars.has);
        
    // Flags
    vars.flagMeta = new Dictionary<string, Tuple<bool,int>> { // key: (default setting, index)
        {"Lockpick Flag         アダルん家",            Tuple.Create(true,      27)},
        {"Games Begin           隠れんぼの始まり",      Tuple.Create(false,     29)},
        {"Free Fran             フラン先生の解放",      Tuple.Create(false,     186)},
        {"Wrecker               レッカー",              Tuple.Create(true,      41)},
        {"Fix Bart              バートの修理",          Tuple.Create(false,     42)},
        {"Thomas Kidnapped      トーマスの誘拐",        Tuple.Create(false,     43)},
        {"Katash 1              カターシュ１",          Tuple.Create(true,      507)},
        {"Tower of Dog          番犬の塔",              Tuple.Create(true,      552)},
        {"Tower of the King     王者の塔",              Tuple.Create(true,      553)},
        {"Tower of the Queen    王妃の塔",              Tuple.Create(true,      551)},
        {"Mother Computer 1     マザコンⅠ",             Tuple.Create(false,     558)},
        {"Megalith Station      メガリス・ステーション",    Tuple.Create(true,      628)},
        {"Gate to ADAM          最深部のADAMへの隔壁",  Tuple.Create(true,      631)}
        // "Beat the Game" handled individually
    };
    
    // Locations
    vars.roomMeta = new Dictionary<string, Tuple<bool,string>> { // key: (default setting, room)
        {"Enter Doki Forest         ドキの森",              Tuple.Create(false,     "p1_duri_forest_01")},
        {"Enter Atai Region         アタイのフィールド",    Tuple.Create(false,     "P1_world_map_SW")} ,
        {"Bridge Skip               ブリッジ・スキップ",    Tuple.Create(true,      "p1_bridge_daetai_02")},
        {"Enter Daea Region         デイアのフィールド",    Tuple.Create(false,     "p1_world_map_c")},
        {"Enter Aqua Line           秘密の地下道",         Tuple.Create(false,     "P1_daea_sewers_01")}, // yup some of these have capital P's for no discernable reason
        {"Enter Castle Dungeons     城の牢獄",              Tuple.Create(false,     "P1_dungeon_00")},
        {"Enter Cosette Region      コセットのフィールド",    Tuple.Create(false,     "p1_world_map_c2")},
        {"Enter Scorchlands         スコーチランド",        Tuple.Create(true,      "p1_scorchlands_00")},
        {"Enter Mul Caves           ミュール洞窟の外",      Tuple.Create(true,      "p1_mul_caves_00")},
        {"Enter Mul Caves Nest      ミュール洞窟の巣",      Tuple.Create(false,     "p1_mul_caves_02")},
        {"Enter SPHERE              スフィアのビル",        Tuple.Create(false,     "p1_sphere_garden_01")},
        {"Enter E.D.E.N.            E.D.E.N.",              Tuple.Create(false,     "p1_phoenix_sub")}
    };
    vars.visited = new List<string>();
    
    // -- Settings --
    settings.Add("Items and Upgrades     アイテム", true);
    settings.Add("Miscellaneous Flags    フラグ", true);
    settings.Add("Locations              場所", true);
    
    foreach(string key in vars.itemMeta.Keys) {
        bool defaultSetting = vars.itemMeta[key].Item1;
        settings.Add(key, defaultSetting, null, "Items and Upgrades     アイテム");
    }
    foreach(string key in vars.flagMeta.Keys) {
        bool defaultSetting = vars.flagMeta[key].Item1;
        settings.Add(key, defaultSetting, null, "Miscellaneous Flags    フラグ");
    }
    settings.Add("Beat the Game         ゲームクリア", true, null, "Miscellaneous Flags    フラグ");
    foreach(string key in vars.roomMeta.Keys) {
        bool defaultSetting = vars.roomMeta[key].Item1;
        settings.Add(key, defaultSetting, null, "Locations              場所");
    }
    
    // Items and upgrades
    settings.SetToolTip("Anuri Pearlstone  アヌリの宝珠", "Splits each time you pick up a pearlstone");
    settings.SetToolTip("Golem Head        謎のゴーレムヘッド", "Pick up the mysterious golem head from its crash site in the Anuri Temple");

    // Flags
    settings.SetToolTip("Lockpick Flag         アダルん家", "Find out Adar's house is locked by inspecting the door");
    settings.SetToolTip("Games Begin           隠れんぼの始まり", "Entrust the lockpicking to Garnet and start Hide & Seek with the kids");
    settings.SetToolTip("Wrecker               レッカー", "Defeat the Wrecker in Thomas' Lab");
    settings.SetToolTip("Fix Bart              バートの修理", "Have Thomas fix Bart('s golem head)");    
    settings.SetToolTip("Katash 1              カターシュ１", "Defeat Katash atop the White Towers");
    settings.SetToolTip("Gate to ADAM          最深部のADAMへの隔壁", "Open the final gate in EDEN with 6 chrystalis");
    settings.SetToolTip("Beat the Game         ゲームクリア", "Any% timer stop (after Katash 2)");
    
    // Locations
    settings.SetToolTip("Locations              場所", "These only trigger when you enter the location for the first time");
    settings.SetToolTip("Bridge Skip               ブリッジ・スキップ", "Enter the middle room of Kingdom Bridge for the first time");
    settings.SetToolTip("Enter Mul Caves           ミュール洞窟の外", "The room with the save before the caves proper");
    settings.SetToolTip("Enter Mul Caves Nest      ミュール洞窟の巣", "The first room with the white nest thingies");
    settings.SetToolTip("Enter SPHERE              スフィアのビル", "Specifically the building itself, not directly from the overworld");
    
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
    // Set in-game timer starting time
    vars.startTime = current.globalTimer;
}

update
{
    //print("DEBUG : " + current.room);
    foreach (var elem in vars.itemMeta) {
        string key = elem.Key;
        string type = elem.Value.Item2;
        int index = elem.Value.Item3 - vars.statusOffset;
        int id = elem.Value.Item4;

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
        int index = vars.flagMeta[key].Item2;
        if (!old.flags[index] && current.flags[index]) {
            print("SPLIT : " + key);
            return settings[key];
        }
    }
    // Locations
    foreach (string key in vars.roomMeta.Keys) {
        string roomName = vars.roomMeta[key].Item2;
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

gameTime
{
    return TimeSpan.FromSeconds((current.globalTimer-vars.startTime)/60.0);
}