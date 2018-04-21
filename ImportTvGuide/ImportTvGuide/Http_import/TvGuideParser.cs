using ImportTvGuide.DtoModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading;
using System.Threading.Tasks;

namespace ImportTvGuide.Http_import
{
    public static class TvGuideParser
    {
        public static ICollection<ProgramTvDTO> GetTvGuide()
        {
            List<ProgramTvDTO> programList = new List<ProgramTvDTO>();
            //mainCell.*\n+\s+.*\n+\s+<span class="left">([0-9]{1,2}:[0-9]{1,2})  czas
            //mainCell.*\n+\s+.*\n+\s+<span class="left">[0-9]{1,2}:[0-9]{1,2}.*\n+\s+.*\n+\s+(.*) nazwa
            //mainCell.*\n+\s+.*\n+\s+<span class="left">[0-9]{1,2}:[0-9]{1,2}.*\n+\s+.*\n+\s+.*\n+\s+<span class="info">(.*) kategoria
            string htmlNextDay = String.Empty;
            string html = HtmlImporter.GetImportTvGuide(Settings.Default.TvGuideURL);
            Regex regex = new Regex(Settings.Default.TimeRegex);
            MatchCollection times = regex.Matches(html);
            regex = new Regex(Settings.Default.NameRegex);
            MatchCollection names = regex.Matches(html);
            regex = new Regex(Settings.Default.TypeRegex);
            MatchCollection types = regex.Matches(html);

            int min = times.Count;
            if (names.Count < min)
                min = names.Count;
            if (types.Count < min)
                min = types.Count;
            DateTime startProcessingDate = DateTime.Parse(Settings.Default.StartDate);
            DateTime endProcessingDate = DateTime.Parse(Settings.Default.EndDate);
            DateTime currentProcessingDate = startProcessingDate;

            if (startProcessingDate.Date > endProcessingDate.Date)
            {
                Console.WriteLine("Data rozpoczecia przetwarzania jest wcześniejsza niż" +
                    "data zkonczenia przetwarzania!");
                Thread.Sleep(5000);
                return null;
            }

            if (min == 0)
            {
                Console.WriteLine("Nie znaleziono wyników!");
                Thread.Sleep(5000);
                return null;
            }

            int interval = (int)endProcessingDate.Subtract(startProcessingDate).TotalDays;

            for (int j = 0; j < interval; j++)
            {
                for (int i = 0; i < min; i++)
                {
                    string timeStart = times[i].Result("$1");
                    string timeEnd = String.Empty;
                    if (i + 1 < times.Count)
                    {
                        timeEnd = times[i + 1].ToString();
                    }
                    else
                    {
                        htmlNextDay = HtmlImporter.GetImportTvGuide(Settings.Default.TvGuideURL.
                           Replace(currentProcessingDate.ToString("yyyy-MM-dd"), currentProcessingDate.AddDays(1).ToString("yyyy-MM-dd")));
                        Regex regexNextDay = new Regex(Settings.Default.TimeRegex);
                        MatchCollection timesNextDay = regex.Matches(html);
                        timeEnd = timesNextDay[0].ToString();
                    }
                    int startSubstring = types[i].ToString().IndexOf(' ') + 1;
                    int endSubstring = types[i].ToString().IndexOf('<');
                    int lenghtSubstring = types[i].Length - (startSubstring + 1) - (types[i].Length - endSubstring + 1);
                    Program_typeDTO programType = new Program_typeDTO()
                    {
                        prt_name = types[i].ToString().Substring(startSubstring, lenghtSubstring)
                    };
                    string programName = names[i].ToString().Replace("<p>", "");
                    programName = programName.Replace("<\\p>", "");
                    int timeSepPos = timeStart.IndexOf(':');
                    int hourStart = Int32.Parse(timeStart.Substring(0, timeSepPos));
                    int minStart = Int32.Parse(timeStart.Substring(timeSepPos + 1, timeStart.Length - timeSepPos + 1));

                    timeSepPos = timeEnd.IndexOf(':');
                    int hourEnd = Int32.Parse(timeEnd.Substring(0, timeSepPos));
                    int minEnd = Int32.Parse(timeEnd.Substring(timeSepPos + 1, timeEnd.Length - timeSepPos + 1));

                    ProgramTvDTO program = new ProgramTvDTO()
                    {
                        Program_type = programType,
                        pr_name = programName,
                        we_start_date = currentProcessingDate.AddHours(hourStart).AddMinutes(minStart),
                        we_end_date = currentProcessingDate.AddHours(hourEnd).AddMinutes(minEnd)
                    };

                    programList.Add(program);
                }
                html = htmlNextDay;
                regex = new Regex(Settings.Default.NameRegex);
                names = regex.Matches(html);
                regex = new Regex(Settings.Default.TypeRegex);
                types = regex.Matches(html);
            }

            return null;
        }
    }
}
