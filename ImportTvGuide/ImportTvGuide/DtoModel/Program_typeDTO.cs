using ImportTvGuide.DbModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ImportTvGuide.DtoModel
{
    public class Program_typeDTO
    {
        public int prt_id { get; set; }

        public string prt_name { get; set; }

        public DateTime aud_data { get; set; }

        public virtual ICollection<ProgramTvDTO> Program { get; set; }
    }
}
