﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class Direccion
    {

        public int Id_direccion { get; set; }
        public string  Calle { get; set; }
        public string Numero { get; set; }
        public string Localidad { get; set;}
        public string CodigoPostal { get; set; }
    }
}
