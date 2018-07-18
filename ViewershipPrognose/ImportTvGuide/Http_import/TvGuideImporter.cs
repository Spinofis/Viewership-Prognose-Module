using DatabaseProject.DtoModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ImportTvGuide.Http_import
{
    public class TvGuideImporter
    {
        public List<ProgramTvDTO> programs = new List<ProgramTvDTO>();
        public List<ProgramTypeDTO> programTypes = new List<ProgramTypeDTO>();

        public void RunImport()
        {
            programs = new TvGuideParser().GetTvProgramList();
            ProgramTvHelper.SetEndDateToAllProgram(programs);
            programTypes = ProgramTvHelper.GetTypesFromPrograms(programs);
        }
    }
}
