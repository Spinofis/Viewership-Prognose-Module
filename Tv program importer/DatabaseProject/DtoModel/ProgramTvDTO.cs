using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DatabaseProject.DtoModel
{
    public class ProgramTvDto
    {
        public int id { get; set; }

        public int? id_prg_type { get; set; }

        public int? id_chan { get; set; }

        public string name { get; set; }
        public string type_name { get; set; }

        public DateTime? start_date { get; set; }

        public DateTime? end_date { get; set; }
    }
}
