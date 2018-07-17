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
    public class TvGuideParser
    {
        private List<ProgramTypeDTO> programTypes = new List<ProgramTypeDTO>();

        public List<ProgramTvDTO> GetTvProgramList()
        {
            List<ProgramTvDTO> programList = new List<ProgramTvDTO>();
            string url = Settings.Default.TvGuideURL;
            DateTime prevDate;

            for (DateTime currentDate = Settings.Default.StartDate; currentDate <= Settings.Default.EndDate; currentDate = currentDate.AddDays(1))
            {
                programList.AddRange(GetProgramFromOneDay(url, currentDate.Date));
                url = url.Replace(currentDate.ToString("yyyy-MM-dd"), currentDate.AddDays(1).ToString("yyy-MM-dd"));
            }
            return programList;
        }

        private List<ProgramTvDTO> GetProgramFromOneDay(string url, DateTime currentDate)
        {
            List<ProgramTvDTO> programList = new List<ProgramTvDTO>();
            string html = HtmlImporter.GetHtml(url);
            string detailLink, detailURL;
            ProgramTvDTO programTv = new ProgramTvDTO();
            Regex regexDetailLink = new Regex(Settings.Default.DetailLink);
            MatchCollection matchDetailsLinks = regexDetailLink.Matches(html);
            Regex regexTimeStarts = new Regex(Settings.Default.TimeStartRegex);
            MatchCollection matchTimeStarts = regexTimeStarts.Matches(html);
            TimeSpan programTime = new TimeSpan(0, 0, 0, 0), prevProgramTime = new TimeSpan(0, 0, 0, 0);
            bool isNextDay = false, isDayAdded = false;

            /*iterujemy od 1 bo na 1 pozycji zbędny element*/
            for (int i = 1; i < matchDetailsLinks.Count; i++)
            {
                programTv = new ProgramTvDTO();
                //godzina staru
                prevProgramTime = programTime;
                programTime = TimeSpan.Parse(matchTimeStarts[i - 1].Result("$1"));
                if (isNextDay && !isDayAdded && currentDate.Add(programTime.Subtract(prevProgramTime)).Hour < 12)
                {
                    programTv.StartDate = currentDate = currentDate.AddDays(1);
                    isDayAdded = true;
                }
                programTv.StartDate = currentDate = currentDate.Add(programTime.Subtract(prevProgramTime));

                if (currentDate.Hour > 12)
                    isNextDay = true;
                programList.Add(programTv);
                //detail link
                detailLink = matchDetailsLinks[i].Result("$2");
                detailURL = string.Concat(Settings.Default.BaseUrl, detailLink);
                FillProgramWithDataFromDetailLink(detailURL, programTv);
            }
            return programList;
        }

        private void FillProgramWithDataFromDetailLink(string Url, ProgramTvDTO programTv)
        {
            string detailHtml = HtmlImporter.GetHtml(Url);
            Regex regexNames = new Regex(Settings.Default.NameRegex);
            MatchCollection matchNames = regexNames.Matches(detailHtml);
            Regex regexTypes = new Regex(Settings.Default.TypeRegex);
            MatchCollection matchTypes = regexTypes.Matches(detailHtml);
            Regex regexDuration = new Regex(Settings.Default.DurationRegex);
            MatchCollection matchesDuration = regexDuration.Matches(detailHtml);
            programTv.Name = matchNames[0].Result("$1");
            //programTv.Type = new ProgramTypeDTO() { Name = matchTypes[0].Result("$1") };
            // programTv.EndDate = programTv.StartDate.AddMinutes();
        }


        public ProgramTypeDTO GetProgramType(string programUrl)
        {

            return null;
        }

        public ProgramTvDTO GetProgramDetail(string programUrl)
        {
            return null;
        }

        //public ICollection<ProgramTvDTO> GetTvGuide()
        //{
        //    DbLogic dbLogic = new DbLogic();

        //    ICollection<ProgramTypeDTO> programTypes = dbLogic.GetProgramTypes();


        //    ICollection<ProgramTvDTO> programList = new List<ProgramTvDTO>();

        //    for (DateTime currentDate = Settings.Default.StartDate; currentDate <= Settings.Default.EndDate; currentDate = currentDate.AddDays(1))
        //    {
        //        string currentDateString;
        //        string nextDateString;
        //        string guideUrl = Settings.Default.TvGuideURL;
        //        string html = HtmlImporter.GetHtml(guideUrl);
        //        string htmlNextDay;
        //        Regex regex = new Regex(Settings.Default.DetailLink);
        //        MatchCollection detailLinks = regex.Matches(html);
        //        regex = new Regex(Settings.Default.TimeStartRegex);
        //        MatchCollection timesStart = regex.Matches(html);
        //        for (int i = 1; i < detailLinks.Count; i++)
        //        {
        //            string htmlDetail = HtmlImporter.GetHtml(Settings.Default.BaseUrl + detailLinks[i].Result("$2"));
        //            regex = new Regex(Settings.Default.TypeRegex);
        //            ProgramTypeDTO programType = new ProgramTypeDTO();
        //            Match type = regex.Match(htmlDetail);
        //            programType.Name = type.Result("$1");
        //            if (!programTypes.Select(x => x.Name).Contains(programType.Name))
        //            {
        //                try
        //                {
        //                    programType = dbLogic.SaveProgramType(programType);
        //                }
        //                catch (Exception ex)
        //                {
        //                    Console.WriteLine(ex.ToString());
        //                }
        //                programTypes.Add(programType);
        //            }

        //            ProgramTvDTO programTv = new ProgramTvDTO();
        //            programTv.Station = new StationDTO() { Id = Settings.Default.StationId };
        //            programTv.Type = programType;
        //            string startTimeString = timesStart[i].Result("$1");
        //            TimeSpan startProgramTimeSpan = TimeSpan.Parse(startTimeString);
        //            TimeSpan endProgramTimeSpan;
        //            if (i + 1 < detailLinks.Count)
        //                endProgramTimeSpan = TimeSpan.Parse(timesStart[i + 1].Result("$1"));
        //            else
        //            {
        //                currentDateString = currentDate.Date.ToString("yyyy-MM-dd");
        //                nextDateString = currentDate.AddDays(1).Date.ToString("yyyy-MM-dd");
        //                guideUrl = guideUrl.Replace(currentDateString, nextDateString);
        //                htmlNextDay = HtmlImporter.GetHtml(guideUrl);
        //                regex = new Regex(Settings.Default.TimeStartRegex);
        //                endProgramTimeSpan = TimeSpan.Parse(regex.Matches(htmlNextDay)[1].Result("$1"));
        //            }
        //            DateTime startProgramDate, endProgramDate, startAdvertDate, endAdvertDate;

        //            if (Math.Abs(new TimeSpan(23, 59, 59).Subtract(startProgramTimeSpan).Hours) > 12)
        //                startProgramDate = currentDate.AddDays(1).Add(startProgramTimeSpan);
        //            else
        //                startProgramDate = currentDate.Add(startProgramTimeSpan);

        //            regex = new Regex(Settings.Default.DurationRegex);
        //            int duration = Int32.Parse(regex.Match(htmlDetail).Result("$1"));

        //            if (Math.Abs(new TimeSpan(23, 59, 59).Subtract(endProgramTimeSpan).Hours) > 12)
        //                endProgramDate = currentDate.AddDays(1).Add(endProgramTimeSpan);
        //            else
        //                endProgramDate = currentDate.Add(endProgramTimeSpan);

        //            if (duration > 0)
        //            {
        //                endAdvertDate = endProgramDate;
        //                endProgramDate.Date.Add(startProgramTimeSpan).AddMinutes(duration);
        //                startAdvertDate = startProgramDate.AddMinutes(duration);
        //                ProgramTvDTO advert = new ProgramTvDTO();
        //                advert.StartDate = startAdvertDate;
        //                advert.EndDate = endAdvertDate;
        //                advert.Type = programTypes.Where(x => x.Id == 1).First();
        //                advert.Station = new StationDTO() { Id = Settings.Default.StationId };
        //                programList.Add(advert);
        //            }

        //            programTv.StartDate = startProgramDate;
        //            programTv.EndDate = endProgramDate;
        //            programList.Add(programTv);
        //        }
        //    }
        //    return programList;
        //}
    }
}
