using ImportTvGuide.DbModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ImportTvGuide.DtoModel
{
    public class ProgramTvDTO
    {
        public int pr_id { get; set; }

        public string pr_name { get; set; }

        public DateTime we_start_date { get; set; }

        public DateTime we_end_date { get; set; }

        public virtual Program_typeDTO Program_type { get; set; }
    }
}
