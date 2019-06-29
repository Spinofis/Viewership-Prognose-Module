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
            try
            {
                AutoMapperInitializer.InitializeMapping();
                TvGuideImporter tvGuideImporter = new TvGuideImporter();
                Console.WriteLine("Import started. Time:" + DateTime.Now);
                tvGuideImporter.RunImport();
                Console.ReadLine();
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.ToString());
                Console.WriteLine("Press any key...");
                Console.ReadKey();
            }
        }
    }
}
