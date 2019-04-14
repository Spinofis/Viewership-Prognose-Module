namespace DatabaseProject.DbModel
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class Program_tv
    {
        public int id { get; set; }

        public int? id_prg_type { get; set; }

        public int? id_chan { get; set; }

        [StringLength(50)]
        public string name { get; set; }

        public DateTime? start_date { get; set; }

        public DateTime? end_date { get; set; }

        public virtual Channels Channels { get; set; }

        public virtual Program_type Program_type { get; set; }
    }
}
