using AutoMapper;
using DatabaseProject.DbModel;
using DatabaseProject.DtoModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DatabaseProject
{
    public static class AutoMapperInitializer
    {
        public static void InitializeMapping()
        {
            Mapper.Initialize(cfg =>
            {
                cfg.CreateMap<Program_tv, ProgramTvDto>();
                cfg.CreateMap<ProgramTvDto, Program_tv>();
                cfg.CreateMap<Program_type, ProgramTypeDto>();
                cfg.CreateMap<ProgramTypeDto, Program_type>();
                cfg.CreateMap<List<ChannelDto>, List<Channels>>();
            });
        }
    }
}
