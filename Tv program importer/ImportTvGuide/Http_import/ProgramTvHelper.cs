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
        public static void SetEndDateToAllProgram(List<ProgramTvDto> programs)
        {
            for (int i = 0; i < programs.Count - 1; i++)
            {
                programs[i].end_date = programs[i + 1].start_date;
            }
            if (programs.Count > 0)
                programs[programs.Count - 1].end_date = new DateTime(2100, 01, 01);
        }

        public static List<ProgramTypeDto> GetTypesFromPrograms(List<ProgramTvDto> programs)
        {
            List<ProgramTypeDto> programTypes = new List<ProgramTypeDto>();
            List<string> programTypesNames = programs
                .GroupBy(x => x.type_name)
                .Select(x => x.FirstOrDefault()?.type_name)
                .ToList();
            programTypesNames
                .ForEach(x => programTypes.Add(new ProgramTypeDto() { name = x }));
            return programTypes;
        }
    }
}
