using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ImportTvGuide.DtoModel
{
    public class WeatherDTO
    {
        public int we_id { get; set; }
        public int we_temperature { get; set; }

        public int? we_wind_speed { get; set; }

        public DateTime we_start_date { get; set; }

        public DateTime we_end_date { get; set; }

        public DateTime aud_data { get; set; }
    }
}
