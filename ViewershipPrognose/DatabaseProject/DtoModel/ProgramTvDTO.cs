using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DatabaseProject.DtoModel
{
    public class ProgramTvDTO
    {
        public int Id { get; set; }

        public string Name { get; set; }

        public DateTime StartDate { get; set; }

        public DateTime EndDate { get; set; }

        public virtual ProgramTypeDTO Type { get; set; }

        public virtual StationDTO Station { get; set; }
    }
}
