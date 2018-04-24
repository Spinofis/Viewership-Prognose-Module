namespace ImportTvGuide.DbModel
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class Program_type
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int prt_id { get; set; }

        [Required]
        public string prt_name { get; set; }

        public DateTime aud_data { get; set; }
    }
}
