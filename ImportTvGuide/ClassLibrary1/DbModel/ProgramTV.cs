namespace DatabaseProject.DbModel
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("ProgramTV")]
    public partial class ProgramTV
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int pr_id { get; set; }

        [Required]
        [StringLength(200)]
        public string pr_name { get; set; }

        public DateTime aud_data { get; set; }

        public DateTime pr_start_date { get; set; }

        public DateTime pr_end_date { get; set; }

        public int pr_sta_id { get; set; }

        public int pr_prt_id { get; set; }

        public virtual Program_type Program_type { get; set; }

        public virtual Station Station { get; set; }
    }
}
