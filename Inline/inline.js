
// FIXME: make this synchronous and return result
function objj_eval(aString, didCompleteCallback)
{
    var context = new objj_context();
    
    context.didCompleteCallback = didCompleteCallback;
    context.pushFragments(objj_preprocess(aString));
    
    context.evaluate();
}

function objj_process_scripts()
{
    var scripts = document.getElementsByTagName("script");
    for (var i = 0; i < scripts.length; i++)
    {
        if (scripts[i].type === "text/objective-j" && !scripts[i].processed)
        {
            scripts[i].processed = true;
            objj_eval(scripts[i].innerText, objj_process_scripts);
            break;
        }
    }
}

if (window.addEventListener)
    window.addEventListener("load", objj_process_scripts, false);
else if (window.attachEvent)
    window.attachEvent("onload", objj_process_scripts);
