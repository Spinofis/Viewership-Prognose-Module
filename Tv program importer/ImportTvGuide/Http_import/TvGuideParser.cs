﻿using DatabaseProject.DbLogic;
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
                FillProgramWithDataFromDetailLink(detailURL, programTv, isNextDay);
            }
            return programList;
        }

        private void FillProgramWithDataFromDetailLink(string Url, ProgramTvDTO programTv, bool isNextDay)
        {
            string detailHtml = HtmlImporter.GetHtml(Url);
            Regex regexNames = new Regex(Settings.Default.NameRegex);
            MatchCollection matchNames = regexNames.Matches(detailHtml);
            Regex regexTypes = new Regex(Settings.Default.TypeRegex);
            MatchCollection matchTypes = regexTypes.Matches(detailHtml);
            Regex regexDuration = new Regex(Settings.Default.DurationRegex);
            MatchCollection matchesDuration = regexDuration.Matches(detailHtml);
            programTv.Name = matchNames[0].Result("$1");
            if (matchTypes.Count > 0)
                programTv.Type = new ProgramTypeDTO() { Name = matchTypes[0].Result("$1") };
            else
                programTv.Type = new ProgramTypeDTO() { Name = "Brak" };
        }
    }
}