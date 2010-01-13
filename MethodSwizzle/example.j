@import <Foundation/Foundation.j>

@import "MethodSwizzle.j"

@implementation Foo : CPObject
{
}
- (void)foo
{
    return "foo";
}
- (void)bar
{
    return "bar";
}
@end

var x = [Foo new];

print("calling foo: " + [x foo]);
print("calling bar: " + [x bar]);

print(" *** swizzling 'foo' and 'bar'");
MethodSwizzle([Foo class], @selector(foo), @selector(bar));

print("calling foo: " + [x foo]);
print("calling bar: " + [x bar]);

// works with categories too!
@implementation Foo (SomeCategory)
- (void)baz
{
    return "baz";
}
@end

print(" *** swizzling 'foo' and 'baz'");
MethodSwizzle([Foo class], @selector(foo), @selector(baz));

print("calling foo: " + [x foo]);
print("calling bar: " + [x bar]);
print("calling baz: " + [x baz]);
