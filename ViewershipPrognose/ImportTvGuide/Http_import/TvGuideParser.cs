using DatabaseProject.DbLogic;
using DatabaseProject.DtoModel;
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
        private static ICollection<ProgramTypeDTO> programTypes = new List<ProgramTypeDTO>();
        public static ICollection<ProgramTvDTO> GetTvGuide()
        {
            DbLogic dbLogic = new DbLogic();

            programTypes = dbLogic.GetProgramTypes();


            ICollection<ProgramTvDTO> programList = new List<ProgramTvDTO>();

            for (DateTime currentDate = Settings.Default.StartDate; currentDate <= Settings.Default.EndDate; currentDate.AddDays(1))
            {
                string currentDateString;
                string nextDateString;
                string guideUrl = Settings.Default.TvGuideURL;
                string html = HtmlImporter.GetHtml(guideUrl);
                string htmlNextDay;
                Regex regex = new Regex(Settings.Default.DetailLink);
                MatchCollection detailLinks = regex.Matches(html);
                regex = new Regex(Settings.Default.TimeStartRegex);
                MatchCollection timesStart = regex.Matches(html);
                for (int i = 1; i < detailLinks.Count; i++)
                {
                    string htmlDetail = HtmlImporter.GetHtml(Settings.Default.BaseUrl + detailLinks[i].Result("$2"));
                    regex = new Regex(Settings.Default.TypeRegex);
                    ProgramTypeDTO programType = new ProgramTypeDTO();
                    Match type = regex.Match(htmlDetail);
                    programType.Name = type.Result("$1");
                    if (!programTypes.Select(x => x.Name).Contains(programType.Name))
                    {
                        try
                        {
                            programType = dbLogic.SaveProgramType(programType);
                        }
                        catch (Exception ex)
                        {
                            Console.WriteLine(ex.ToString());
                        }
                        programTypes.Add(programType);
                    }

                    ProgramTvDTO programTv = new ProgramTvDTO();
                    programTv.Station = new StationDTO() { Id = Settings.Default.StationId };
                    programTv.Type = programType;
                    string startTimeString = timesStart[i].Result("$1");
                    TimeSpan startProgramTimeSpan = TimeSpan.Parse(startTimeString);
                    TimeSpan endProgramTimeSpan;
                    if (i + 1 < detailLinks.Count)
                        endProgramTimeSpan = TimeSpan.Parse(timesStart[i + 1].Result("$1"));
                    else
                    {
                        currentDateString = currentDate.Date.ToString("yyyy-MM-dd");
                        nextDateString = currentDate.AddDays(1).Date.ToString("yyyy-MM-dd");
                        guideUrl = guideUrl.Replace(currentDateString, nextDateString);
                        htmlNextDay = HtmlImporter.GetHtml(guideUrl);
                        regex = new Regex(Settings.Default.TimeStartRegex);
                        endProgramTimeSpan = TimeSpan.Parse(regex.Matches(htmlNextDay)[1].Result("$1"));
                    }
                    DateTime startProgramDate, endProgramDate, startAdvertDate, endAdvertDate;

                    if (Math.Abs(new TimeSpan(23, 59, 59).Subtract(startProgramTimeSpan).Hours) > 12)
                        startProgramDate = currentDate.AddDays(1).Add(startProgramTimeSpan);
                    else
                        startProgramDate = currentDate.Add(startProgramTimeSpan);

                    regex = new Regex(Settings.Default.DurationRegex);
                    int duration = Int32.Parse(regex.Match(htmlDetail).Result("$1"));

                    if (Math.Abs(new TimeSpan(23, 59, 59).Subtract(endProgramTimeSpan).Hours) > 12)
                        endProgramDate = currentDate.AddDays(1).Add(endProgramTimeSpan);
                    else
                        endProgramDate = currentDate.Add(endProgramTimeSpan);

                    if (duration > 0)
                    {
                        endAdvertDate = endProgramDate;
                        endProgramDate.Date.Add(startProgramTimeSpan).AddMinutes(duration);
                        startAdvertDate = startProgramDate.AddMinutes(duration);
                        ProgramTvDTO advert = new ProgramTvDTO();
                        advert.StartDate = startAdvertDate;
                        advert.EndDate = endAdvertDate;
                        advert.Type = programTypes.Where(x => x.Id == 1).First();
                        advert.Station = new StationDTO() { Id = Settings.Default.StationId };
                        programList.Add(advert);
                    }

                    programTv.StartDate = startProgramDate;
                    programTv.EndDate = endProgramDate;
                    programList.Add(programTv);
                }
            }
            return programList;
        }


        //public static ICollection<ProgramTvDTO> GetTvGuide()
        //{
        //    List<ProgramTvDTO> programList = new List<ProgramTvDTO>();
        //    //mainCell.*\n+\s+.*\n+\s+<span class="left">([0-9]{1,2}:[0-9]{1,2})  czas
        //    //mainCell.*\n+\s+.*\n+\s+<span class="left">[0-9]{1,2}:[0-9]{1,2}.*\n+\s+.*\n+\s+(.*) nazwa
        //    //mainCell.*\n+\s+.*\n+\s+<span class="left">[0-9]{1,2}:[0-9]{1,2}.*\n+\s+.*\n+\s+.*\n+\s+<span class="info">(.*) kategoria
        //    string htmlNextDay = String.Empty;
        //    string html = HtmlImporter.GetImportTvGuide(Settings.Default.TvGuideURL);
        //    Regex regex = new Regex(Settings.Default.TimeRegex);
        //    MatchCollection times = regex.Matches(html);
        //    regex = new Regex(Settings.Default.NameRegex);
        //    MatchCollection names = regex.Matches(html);
        //    regex = new Regex(Settings.Default.TypeRegex);
        //    MatchCollection types = regex.Matches(html);

        //    int min = times.Count;
        //    if (names.Count < min)
        //        min = names.Count;
        //    if (types.Count < min)
        //        min = types.Count;
        //    DateTime startProcessingDate = DateTime.Parse(Settings.Default.StartDate);
        //    DateTime endProcessingDate = DateTime.Parse(Settings.Default.EndDate);
        //    DateTime currentProcessingDate = startProcessingDate;

        //    if (startProcessingDate.Date > endProcessingDate.Date)
        //    {
        //        Console.WriteLine("Data rozpoczecia przetwarzania jest wcześniejsza niż" +
        //            "data zkonczenia przetwarzania!");
        //        Thread.Sleep(5000);
        //        return null;
        //    }

        //    if (min == 0)
        //    {
        //        Console.WriteLine("Nie znaleziono wyników!");
        //        Thread.Sleep(5000);
        //        return null;
        //    }

        //    int interval = (int)endProcessingDate.Subtract(startProcessingDate).TotalDays;

        //    for (int j = 0; j < interval; j++)
        //    {
        //        for (int i = 0; i < min; i++)
        //        {
        //            string timeStart = times[i].Result("$1");
        //            string timeEnd = String.Empty;
        //            if (i + 1 < times.Count)
        //            {
        //                timeEnd = times[i + 1].Result("$1").ToString();
        //            }
        //            else
        //            {
        //                htmlNextDay = HtmlImporter.GetImportTvGuide(Settings.Default.TvGuideURL.
        //                   Replace(currentProcessingDate.ToString("yyyy-MM-dd"), currentProcessingDate.AddDays(1).ToString("yyyy-MM-dd")));
        //                Regex regexNextDay = new Regex(Settings.Default.TimeRegex);
        //                MatchCollection timesNextDay = regex.Matches(html);
        //                timeEnd = timesNextDay[0].ToString();
        //            }
        //            string prt_name = types[i].Result("$1").ToString();
        //            int startSubstring;
        //            if (prt_name.Contains("odc.&thinsp"))
        //                startSubstring = prt_name.IndexOf(',') + 2;
        //            else
        //                startSubstring = 0;
        //            int endSubstring = prt_name.IndexOf('<');
        //            int lenghtSubstring = endSubstring - startSubstring;
        //            prt_name = prt_name.Substring(startSubstring, lenghtSubstring);
        //            Program_typeDTO programType = new Program_typeDTO()
        //            {
        //                prt_name = prt_name,
        //            };
        //            string programName = names[i].Result("$1").ToString().Replace("<p>", "");
        //            programName = programName.Replace("</p>", "");
        //            int timeSepPos = timeStart.IndexOf(':');
        //            int hourStart = Int32.Parse(timeStart.Substring(0, timeSepPos));
        //            int minStart = Int32.Parse(timeStart.Substring(timeSepPos + 1, timeStart.Length - (timeSepPos + 1)));

        //            timeSepPos = timeEnd.IndexOf(':');
        //            int hourEnd = Int32.Parse(timeEnd.Substring(0, timeSepPos));
        //            int minEnd = Int32.Parse(timeEnd.Substring(timeSepPos + 1, timeEnd.Length - (timeSepPos + 1)));

        //            ProgramTvDTO program = new ProgramTvDTO()
        //            {
        //                Program_type = programType,
        //                pr_name = programName,
        //                we_start_date = currentProcessingDate.AddHours(hourStart).AddMinutes(minStart),
        //                we_end_date = currentProcessingDate.AddHours(hourEnd).AddMinutes(minEnd)
        //            };

        //            programList.Add(program);
        //        }
        //        html = htmlNextDay;
        //        regex = new Regex(Settings.Default.NameRegex);
        //        names = regex.Matches(html);
        //        regex = new Regex(Settings.Default.TypeRegex);
        //        types = regex.Matches(html);
        //    }

        //    return null;
        //}
    }
}
