$import("Foundation/Foundation.j").
$import("AppKit/AppKit.j")
(function() {


$implementation("CPFoo", "CPObject",
    "CPObject", "_foo",
    "CPString", "_bar",
    
    "-initWithFoo:bar:", function(self, _cmd, foo, bar) {
    
    },
    
    "+fooWithFoo:bar", function(self, _cmd, foo, bar) {
    
    }
);


}).
$import("foobar")();
