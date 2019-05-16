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
        public int ChannelId { get; set; }
        public string Url { get; set; }
        private List<ProgramTypeDto> programTypes = new List<ProgramTypeDto>();


        public List<ProgramTvDto> GetTvProgramList(int channelId, string url)
        {
            this.ChannelId = channelId;
            this.Url = url;
            List<ProgramTvDto> programList = new List<ProgramTvDto>();
            DateTime prevDate;
            int i = 0;
            for (DateTime currentDate = Settings.Default.StartDate; currentDate <= Settings.Default.EndDate; currentDate = currentDate.AddDays(1))
            {
                programList.AddRange(GetProgramFromOneDay(Url, currentDate.Date));
                //if (i % 30 == 0 && i != 0)
                Url = Url.Replace(currentDate.ToString("yyyy-MM-dd"), currentDate.AddDays(1).ToString("yyy-MM-dd"));
                Console.WriteLine("Channel {0} processed {1} days", ChannelId, i++);
            }
            return programList;
        }

        private List<ProgramTvDto> GetProgramFromOneDay(string url, DateTime currentDate)
        {
            List<ProgramTvDto> programList = new List<ProgramTvDto>();
            string html = HtmlImporter.GetHtml(url);
            string detailLink, detailURL;
            ProgramTvDto programTv = new ProgramTvDto();
            Regex regexDetailLink = new Regex(Settings.Default.DetailLink);
            MatchCollection matchDetailsLinks = regexDetailLink.Matches(html);
            Regex regexTimeStarts = new Regex(Settings.Default.TimeStartRegex);
            MatchCollection matchTimeStarts = regexTimeStarts.Matches(html);
            TimeSpan programTime = new TimeSpan(0, 0, 0, 0), prevProgramTime = new TimeSpan(0, 0, 0, 0);
            bool isNextDay = false, isDayAdded = false;

            /*iterujemy od 1 bo na 1 pozycji zbędny element*/
            for (int i = 1; i < matchDetailsLinks.Count; i++)
            {
                programTv = new ProgramTvDto();
                //godzina staru
                prevProgramTime = programTime;
                programTime = TimeSpan.Parse(matchTimeStarts[i - 1].Result("$1"));
                if (isNextDay && !isDayAdded && currentDate.Add(programTime.Subtract(prevProgramTime)).Hour < 12)
                {
                    programTv.start_date = currentDate = currentDate.AddDays(1);
                    isDayAdded = true;
                }
                programTv.start_date = currentDate = currentDate.Add(programTime.Subtract(prevProgramTime));

                if (currentDate.Hour > 12)
                    isNextDay = true;
                programList.Add(programTv);
                //detail link
                detailLink = matchDetailsLinks[i].Result("$2");
                detailURL = string.Concat(Settings.Default.BaseUrl, detailLink);
                FillProgramWithDataFromDetailLink(detailURL, programTv, isNextDay);
                programTv.id_chan = ChannelId;
            }
            return programList;
        }

        private void FillProgramWithDataFromDetailLink(string Url, ProgramTvDto programTv, bool isNextDay)
        {
            string detailHtml = HtmlImporter.GetHtml(Url);
            Regex regexNames = new Regex(Settings.Default.NameRegex);
            MatchCollection matchNames = regexNames.Matches(detailHtml);
            Regex regexTypes = new Regex(Settings.Default.TypeRegex);
            MatchCollection matchTypes = regexTypes.Matches(detailHtml);
            Regex regexDuration = new Regex(Settings.Default.DurationRegex);
            MatchCollection matchesDuration = regexDuration.Matches(detailHtml);
            programTv.name = matchNames[0].Result("$1");
            if (matchTypes.Count > 0)
                programTv.type_name = matchTypes[0].Result("$1");
            else
                programTv.type_name = "Brak";
        }
    }
}
