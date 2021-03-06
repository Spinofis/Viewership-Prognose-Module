﻿using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading.Tasks;

namespace ImportTvGuide.Http_import
{
    public static class HtmlImporter
    {
        public static string GetHtml(string url)
        {
                WebRequest webRequest = WebRequest.Create(url);
                WebResponse webResponse = webRequest.GetResponse();
                Stream contentStream = webResponse.GetResponseStream();
                string html = String.Empty;
                using (var streamReader = new StreamReader(contentStream))
                {
                    html = streamReader.ReadToEnd();
                }

                return html;
        }
    }
}
