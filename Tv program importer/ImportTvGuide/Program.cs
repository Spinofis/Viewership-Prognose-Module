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
                //Console.WriteLine("Importing channel:" + Settings.Default.ChannelName);
                tvGuideImporter.RunImport();
                //Console.WriteLine("Tv guide parsed. Time:" + DateTime.Now + " Program count: " + tvGuideImporter.programs.Count);
                //string content = string.Join("\n", tvGuideImporter.programs.Select(x => x.start_date));
                //File.WriteAllText(@"C:\Users\Bartek\Desktop\tv.txt", content);
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
