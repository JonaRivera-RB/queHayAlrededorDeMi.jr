//
//  estrellasobtener.swift
//  eatingApp
//
//  Created by misael rivera on 17/01/18.
//  Copyright © 2018 misael rivera. All rights reserved.
//

import Foundation
var estrellai:String = ""
var estrella2i:String = ""
var estrella3i:String = ""
var estrella4i:String = ""
var estrella5i:String = ""

func estrellasAsigar(valoracion:Float)
{
    if valoracion < 1 {
        estrellai = "onestar_empty.png"
        estrella2i = "onestar_empty.png"
        estrella3i = "onestar_empty.png"
        estrella4i = "onestar_empty.png"
        estrella5i = "onestar_empty.png"
    }
    
    else if valoracion < 2 {
        estrellai = "onestar_filled.png"
        estrella2i = "onestar_empty.png"
        estrella3i = "onestar_empty.png"
        estrella4i = "onestar_empty.png"
        estrella5i = "onestar_empty.png"
    }
    else if valoracion < 3
    {
        estrellai = "onestar_filled.png"
        estrella2i = "onestar_filled.png"
        estrella3i = "onestar_empty.png"
        estrella4i = "onestar_empty.png"
        estrella5i = "onestar_empty.png"
    }
    else if valoracion < 4
    {
        estrellai = "onestar_filled.png"
        estrella2i = "onestar_filled.png"
        estrella3i = "onestar_filled.png"
        estrella4i = "onestar_empty.png"
        estrella5i = "onestar_empty.png"
    }
    else if valoracion < 5
    {
        estrellai = "onestar_filled.png"
        estrella2i = "onestar_filled.png"
        estrella3i = "onestar_filled.png"
        estrella4i = "onestar_filled.png"
        estrella5i = "onestar_empty.png"
    }
    else if valoracion == 5.0
    {
        estrellai = "onestar_filled.png"
        estrella2i = "onestar_filled.png"
        estrella3i = "onestar_filled.png"
        estrella4i = "onestar_filled.png"
        estrella5i = "onestar_filled.png"
}
}
