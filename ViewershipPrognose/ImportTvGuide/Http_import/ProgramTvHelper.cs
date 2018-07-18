using DatabaseProject.DtoModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ImportTvGuide.Http_import
{
    public static class ProgramTvHelper
    {
        public static void SetEndDateToAllProgram(List<ProgramTvDTO> programs)
        {
            for (int i = 0; i < programs.Count - 1; i++)
            {
                programs[i].EndDate = programs[i + 1].StartDate;
            }
            if (programs.Count > 0)
                programs[programs.Count - 1].EndDate = new DateTime(2100, 01, 01);
        }

        public static List<ProgramTypeDTO> GetTypesFromPrograms(List<ProgramTvDTO> programs)
        {
            var obj = programs.Select(x => x.Type).GroupBy(x => x.Name);
            return obj.Select(x => x.FirstOrDefault()).ToList();
        }
    }
}
