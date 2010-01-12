@import "JSKit.j"

autoAliasAll();

aliasSelectorC(CPObject, "alloc", "alloc");
//aliasSelectorI(CPObject, "init", "init");
//aliasSelectorI(CPArray, "init", "init");
aliasSelectorC(CPArray, "arrayWithArray:", "arrayWithArray");


var a = [[CPObject alloc] init];
print(a);

var a = CPObject._("alloc")._("init");
print(a);

var a = CPObject.alloc().init();
print(a);

/*
asdf = function() {
    call_super(arguments);
    objj_msgSendSuper{super_class:arguments.callee.base, object:self}, _cmd, arguments);
}
asdf.base = "CPObject";
asdf();
*/

var a = [CPArray arrayWithArray:["A", "B", "C"]];
print(a);

var a = CPArray._("arrayWithArray:", ["A", "B", "C"]);
print(a);

var a = CPArray._({ arrayWithArray:["A", "B", "C"] });
print(a);

var a = CPArray.arrayWithArray(["A", "B", "C"]);
print(a);
