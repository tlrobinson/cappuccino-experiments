/*
 * FunctionForwarder.j
 *
 * Created by Thomas Robinson.
 * Copyright 2009, 280 North, Inc.
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
 */

@import <Foundation/CPObject.j>

// these should be imported by CPObject but aren't:
@import <Foundation/CPException.j>
@import <Foundation/CPInvocation.j>
@import <Foundation/CPNull.j>

// create a shell class for forwarding messages sent to Function objects
@implementation _FunctionForwarder : CPObject
{
}

- (CPMethodSignature)methodSignatureForSelector:(SEL)selector
{
    return YES;
}

- (void)forwardInvocation:(CPInvocation)invocation
{
    // this particular implementation provides "self" and "_cmd" in the "this" object
    // and the remaining arguments as the function's arguments
    var _this = {
        self : invocation._arguments[0],
        _cmd : invocation._arguments[1]
    }
    var _arguments = invocation._arguments.slice(2)
    
    return self.apply(_this, _arguments);
}
@end

// toll-free brdige Function to _FunctionForwarder:
Function.prototype.isa = _FunctionForwarder;

