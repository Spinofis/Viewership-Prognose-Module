using DatabaseProject.DbLogic;
using DatabaseProject.DtoModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace ImportTvGuide.Http_import
{
    public class TvGuideImporter
    {
        DbLogic db = new DbLogic();
        Task[] tasks = new Task[16];

        public void RunImport()
        {
            var channels = db.GetChannelsList();
            int i = 0;
            foreach (ChannelDto channel in channels)
            {
                tasks[i++] = Task.Factory.StartNew(() => StartImportChannel(channel.id, channel.program_url));
            }
            Task.WaitAll(tasks);
            Console.WriteLine("Removing incorrect data...");
            db.DeleteProgramsWithIncorrectEndDate();
            Console.WriteLine("Import has finished!");
        }

        public void StartImportChannel(int channelId, string url)
        {
            List<ProgramTvDto> programs = new List<ProgramTvDto>();
            List<ProgramTypeDto> programTypes = new List<ProgramTypeDto>();
            TvGuideParser tvGuideParser = new TvGuideParser();
            programs = tvGuideParser.GetTvProgramList(channelId, url);
            ProgramTvHelper.SetEndDateToAllProgram(programs);
            programTypes = ProgramTvHelper.GetTypesFromPrograms(programs);
            Console.WriteLine("Import of channel " + channelId + " parsed");
            db.SaveProgramTypes(programTypes);
            db.SavePrograms(programs);
            Console.WriteLine("Import of channel " + channelId + " ended");
        }
    }
}
