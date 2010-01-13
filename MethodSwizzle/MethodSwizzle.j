/*
 * MethodSwizzle.j
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

// straight port of MethodSwizzle implementation at
// http://www.cocoadev.com/index.pl?MethodSwizzling

function MethodSwizzle(/*Class*/ aClass, /*SEL*/ orig_sel, /*SEL*/ alt_sel)
{
    // First, look for the methods
    var orig_method = class_getInstanceMethod(aClass, orig_sel);
    var alt_method = class_getInstanceMethod(aClass, alt_sel);

    // If both are found, swizzle them
    if ((orig_method != nil) && (alt_method != nil))
    {
        var temp1 = orig_method.method_types;
        orig_method.method_types = alt_method.method_types;
        alt_method.method_types = temp1;

        var temp2 = orig_method.method_imp;
        orig_method.method_imp = alt_method.method_imp;
        alt_method.method_imp = temp2;
    }
}
