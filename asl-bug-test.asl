state("PhoenotopiaAwakening") { }

startup
{
    Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Unity");
}

init
{
  vars.Helper.TryLoad = (Func<dynamic, bool>)(mono =>
  {
    try
    {
      var pt2 = mono["PT2"];
      return true;
    }
    catch
    {
        print("_____YOU CAUGHT A FISH, BOY!____");
      return false;
    }
  });
}

update {
    print("_____it's working____");
}

// [15332] [asl-help] Searching for module with names: mono.dll, mono-2.0-bdwgc.dll, GameAssembly.dll... 
// [15332] [asl-help]   => No module found yet. 
// [15332] [asl-help]   => Retrying 2 more times in 1000ms... 
// [15332] [asl-help]   => Found mono.dll. 
// [15332] [asl-help] Retrieving Unity version... 
// [15332] [asl-help]   => Unity 5.6.5f1. 
// [15332] [asl-help]   => Doesn't look right? You can set the helper's `UnityVersion` manually in 'startup {}': 
// [15332] [asl-help]      `vars.Helper.UnityVersion = new Version(2017, 2);` 
// [15332] [asl-help] Loading Unity mono.v1 structs... 
// [15332] [asl-help]   => Success. 
// [15332] [asl-help] Searching for image 'Assembly-CSharp'... 
// [15332] [asl-help]   => Found at 0xFC33790. 
// [15332] [asl-help]     => class_cache.size is 11. 
// [15332] [asl-help]     => class_cache.table at 0x663F610. 
// [15332] [asl-help] Aborting due to error. 
// [15332] System.Exception: Could not load Mono V1! 
// [15332]    at AslHelp.Mono.Managers.MonoV1Manager..ctor(String version) 
// [15332]    at Unity.MakeManager() 
// [15332]    at AslHelp.HelperBase`1.<<Load>b__31_0>d.MoveNext() 

//---

// [15332] [asl-help] Loading Unity mono.v1 structs... 
// [15332] [asl-help]   => Success. 
// [15332] [asl-help] Searching for image 'Assembly-CSharp'... 
// [15332] [asl-help] Aborting due to error. 
// [15332] AslHelp.MemUtils.Exceptions.NotFoundException: Image 'Assembly-CSharp' Could not be found. Ensure correct spelling. Names are case sensitive. 
// [15332]    at AslHelp.Mono.Models.ImageCache.get_Item(String imageName) 
// [15332]    at AslHelp.Mono.Managers.MonoV1Manager..ctor(String version) 
// [15332]    at Unity.MakeManager() 
// [15332]    at AslHelp.HelperBase`1.<<Load>b__31_0>d.MoveNext() 

//OR

// [15332] [asl-help] Searching for image 'Assembly-CSharp'... 
// [15332] [asl-help]   => Found at 0xF783790. 
// [15332] [asl-help]     => class_cache.size is 11. 
// [15332] [asl-help]     => class_cache.table at 0x62DF920. 
// [15332] [asl-help] Aborting due to error. 
// [15332] System.Exception: Could not load Mono V1! 
// [15332]    at AslHelp.Mono.Managers.MonoV1Manager..ctor(String version) 
// [15332]    at Unity.MakeManager() 
// [15332]    at AslHelp.HelperBase`1.<<Load>b__31_0>d.MoveNext() 

//OR

// [15332] [asl-help] Searching for image 'Assembly-CSharp'... 
// [15332] [asl-help]   => Found at 0xF5D3790. 
// [15332] [asl-help]     => class_cache.size is 163. 
// [15332] [asl-help]     => class_cache.table at 0xF74A350. 
// [15332] [asl-help] 
// [15332] [asl-help] Executing TryLoad... 
// [15332] [asl-help]   => Found at 0xF5D3790. 
// [15332] [asl-help]     => class_cache.size is 163. 
// [15332] [asl-help]     => class_cache.table at 0xF74A350. 
// [15332] [asl-help] Searching for class 'PT2'... 
// [15332] [asl-help] Aborting due to error. 
// [15332] System.NullReferenceException: Object reference not set to an instance of an object. 
// [15332]    at AslHelp.Extensions.StringExt.ToValidIdentifierUnity(String value) 
// [15332]    at AslHelp.Mono.Models.MonoClass.get_Name() 
// [15332]    at AslHelp.Mono.Models.MonoImage.<GetEnumerator>d__13.MoveNext() 
// [15332]    at AslHelp.Collections.CachedEnumerable`2.TryGetValue(TKey key, TValue& value) 
// [15332]    at AslHelp.Mono.Managers.UnityMemManager.GetClass(MonoImage image, String className, Int32 parent) 
// [15332]    at AslHelp.Mono.Managers.UnityMemManager.GetClass(String imageName, String className, Int32 parent) 
// [15332]    at AslHelp.Mono.Managers.UnityMemManager.get_Item(String className, Int32 parents) 
// [15332]    at CompiledScript.<Execute>b__6(Object mono) in c:\Users\Johannes\AppData\Local\Temp\s25zexbt\s25zexbt.0.cs:line 30 
// [15332]    at AslHelp.HelperBase`1.<DoOnLoad>b__32_0(TaskBuilderContext`1 ctx) 
// [15332]    at AslHelp.Tasks.BuilderFunc`1.Invoke(TaskBuilderContext`1 ctx, Object[] args) 
// [15332]    at AslHelp.Tasks.TaskBuilder`1.<AslHelp-Tasks-IFinalizeStage<TResult>-RunAsync>d__25.MoveNext() 
// [15332] --- End of stack trace from previous location where exception was thrown --- 
// [15332]    at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw() 
// [15332]    at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task) 
// [15332]    at System.Runtime.CompilerServices.TaskAwaiter`1.GetResult() 
// [15332]    at AslHelp.HelperBase`1.<DoOnLoad>d__32.MoveNext() 
// [15332] --- End of stack trace from previous location where exception was thrown --- 
// [15332]    at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw() 
// [15332]    at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task) 
// [15332]    at System.Runtime.CompilerServices.TaskAwaiter`1.GetResult() 
// [15332]    at AslHelp.HelperBase`1.<<Load>b__31_0>d.MoveNext() 
