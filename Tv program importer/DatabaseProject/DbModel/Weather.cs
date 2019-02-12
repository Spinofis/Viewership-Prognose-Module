namespace DatabaseProject.DbModel
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Weather")]
    public partial class Weather
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int we_id { get; set; }

        public double? we_temperature { get; set; }

        public double? we_wind_speed { get; set; }

        public DateTime? we_start_date { get; set; }

        public DateTime? we_end_date { get; set; }

        public DateTime aud_date { get; set; }
    }
}
