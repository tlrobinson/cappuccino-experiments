// Run:
//   objj FunctionForwarder/example.j 
// Results:
//   _cmd=whatever:
//   arguments=<CPNotification 0x00003a>

@import "FunctionForwarder.j"

@import <Foundation/CPNotificationCenter.j>

[[CPNotificationCenter defaultCenter]
    addObserver:function() {
        print("_cmd="+this._cmd);
        print("arguments="+Array.prototype.slice.call(arguments).join(","));
    }
    selector:@selector(whatever:)
    name:"FunctionForwarderTestNotification"
    object:nil
];

[[CPNotificationCenter defaultCenter] postNotificationName:"FunctionForwarderTestNotification" object:nil userInfo:nil];
