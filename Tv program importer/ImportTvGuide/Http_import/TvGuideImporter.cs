using DatabaseProject.DbLogic;
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
        public List<ProgramTvDto> programs = new List<ProgramTvDto>();
        public List<ProgramTypeDto> programTypes = new List<ProgramTypeDto>();

        public void RunImport()
        {
            programs = new TvGuideParser().GetTvProgramList();
            ProgramTvHelper.SetEndDateToAllProgram(programs);
            programTypes = ProgramTvHelper.GetTypesFromPrograms(programs);
            DbLogic db = new DbLogic();
            db.SaveProgramTypes(programTypes);
            db.SavePrograms(programs);
        }
    }
}
