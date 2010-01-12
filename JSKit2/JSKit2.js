function $import(id) {
    var imports = [id];
    var initiate = function(program) {
        var count = 0;
        var counter = function() {
            count++;
            if (count === imports.length && program)
                program();
        }
        
        for (var i = 0; i < imports.length; i++) {
            
            objj_import(imports[i], false, counter);
        }
        
        return { $import : $import };
    }
    initiate.$import = function(id) {
        imports.push(id);
        return initiate;
    }
    return initiate;
}

function $implementation(className, superclassName) {
    print("className="+className);
    print("superclassName="+superclassName);
    for (var i = 2; i < arguments.length; i++) {
        var first = arguments[i],
            second = arguments[i+1];
        print(typeof second)
        switch (typeof second) {
            case "string" :
                print("ivar:");
                break;
            case "function" :
                print("func:");
                break;
            default :
                throw "JSKit $implementation error";
        }
        print(first + " => " + second)
        i++;
    }
}

// 
// $import("Foundation/Foundation.j").
// $import("AppKit/AppKit.j")
// (function() {
// 
// $implementation("CPFoo", "CPObject",
// "CPObject", "_foo",
// "CPString", "_bar",
// 
// "-initWithFoo:bar:", function(self, _cmd, foo, bar) {
//     
// },
// 
// "+fooWithFoo:bar", function(self, _cmd, foo, bar) {
//     
// }
// 
// );
// 
// }).
// $import("foobar")();
