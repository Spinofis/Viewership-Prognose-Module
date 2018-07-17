using DatabaseProject;
using DatabaseProject.DtoModel;
using ImportTvGuide.Http_import;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
namespace ImportTvGuide
{
    class Program
    {
        static void Main(string[] args)
        {
            AutoMapperInitializer.InitializeMapping();
            //Console.WriteLine("Import started.");
            List<ProgramTvDTO> programs = new TvGuideParser().GetTvProgramList();
            string content = string.Join("\n", programs.Select(x => x.StartDate));
            File.WriteAllText(@"C:\Users\Bartek\Desktop\tv.txt", content);
            //new TvGuideParser().GetTvGuide();
        }
    }
}
