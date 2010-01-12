/*
 * JSKit.j
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

@import <Foundation/Foundation.j>
@import <AppKit/AppKit.j>

// Prior art:
//
// JSCocoa: http://code.google.com/p/jscocoa/
// MacRuby: http://www.macruby.org/
// RubyCocoa: http://rubycocoa.sourceforge.net/
// PyObjC: http://pyobjc.sourceforge.net/

objj_class.prototype._ =
objj_object.prototype._ =
function(arg0)
{
    var args = [],
        selector;
        
    if (arg0 && typeof arg0 === "object")
    {
        var components = [];
        for (var c in arg0)
        {
            components.push(c);
            args.push(arg0[c]);
        }
        selector = components.join(":") + ":";
    }
    else if (typeof arg0 === "string")
        selector = arg0;
    else
        throw new Error("Must provide selector or hash");
    
    if (arguments.length > 1)
        Array.prototype.push.apply(args, Array.prototype.slice.call(arguments, 1));
    
    args.unshift(this, sel_getUid(selector));
    
    return objj_msgSend.apply(null, args);
}

function aliasSelector(aBase, aSelector, aName, aDescription)
{
    if (aBase.hasOwnProperty(aName))
        throw new Error("Conflict aliasing method '"+aName+"' to selector '"+aSelector+"' "+(aDescription||""));
    
    aBase[aName] = function() {
        return objj_msgSend.apply(null, [this, aSelector].concat(Array.prototype.slice.call(arguments)));
    }
    //aBase[aName] = new Function("return objj_msgSend.apply(null, [this, '"+aSelector+"'].concat(Array.prototype.slice.call(arguments)));");
}

function aliasSelectorI(aClass, aSelector, aName)
{
    aliasSelector(aClass.allocator.prototype, aSelector, aName, "on '"+aClass.name+"' instances");
}

function aliasSelectorC(aClass, aSelector, aName)
{
    aliasSelector(aClass, aSelector, aName, "on '"+aClass.name+"' class");
}

function autoAlias(object, stats) {
    stats = stats || {};
    if (stats.debug) print(object.name);
    
    for (var i = 0; i < object.method_list.length; i++) {
        var selector = object.method_list[i].name,
            method = selector;
    
        method = method.replace(/:$/, "");
        //method = method.replace(/_/g, "__");    
        method = method.replace(/:/g, "_");
    
        try {
            aliasSelectorI(object, selector, method);
            
            if (stats.debug) print("    mapped \"" + selector + "\" to \"" + method + "\"");
            stats.mapped++;
        } catch (e) {
            if (stats.debug) print("    FAIL \"" + selector + "\" to \"" + method + "\"");
            stats.errors++;
        }
    }
}

function autoAliasAll() {
    var dbg = false;
    
    var istats = { errors : 0, mapped : 0, start : new Date(), debug : dbg };
    if (istats.debug) print("INSTANCE METHODS:")
    for (var className in REGISTERED_CLASSES)
        autoAlias(REGISTERED_CLASSES[className], istats);
    istats.end = new Date();
    
    var cstats = { errors : 0, mapped : 0, start : new Date(), debug : dbg };
    if (cstats.debug) print("CLASS METHODS:")
    for (var className in REGISTERED_CLASSES)
        autoAlias(REGISTERED_CLASSES[className].isa, cstats);
    cstats.end = new Date();
    
    print("INSTANCE METHODS: mapped="+istats.mapped+" errors="+istats.errors+" elapsed=" + (istats.end - istats.start)+"ms");
    print("CLASS METHODS:    mapped="+cstats.mapped+" errors="+cstats.errors+" elapsed=" + (cstats.end - cstats.start)+"ms");
}
