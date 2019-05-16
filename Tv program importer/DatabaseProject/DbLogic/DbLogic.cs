using AutoMapper;
using DatabaseProject.DbModel;
using DatabaseProject.DtoModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DatabaseProject.DbLogic
{
    public class DbLogic
    {

        public List<ChannelDto> GetChannelsList()
        {
            using (var context = new Model2())
            {
                var result = context
                    .Channels
                    .Select(x => x)
                    .Where(x => !string.IsNullOrEmpty(x.program_url))
                    .ToList();
                return Mapper.Map<List<Channels>, List<ChannelDto>>(result);
            }
        }
        public ICollection<ProgramTypeDto> GetProgramTypes()
        {
            using (var context = new Model2())
            {
                var obj = (from prt in context.Program_type
                           select prt).ToList();

                return Mapper.Map<ICollection<Program_type>, ICollection<ProgramTypeDto>>(obj);
            }
        }

        public void SaveProgramTypes(List<ProgramTypeDto> programTypes)
        {
            using (var context = new Model2())
            {
                using (var tran = context.Database.BeginTransaction())
                {
                    try
                    {
                        foreach (ProgramTypeDto programTypeDTO in programTypes)
                        {
                            Program_type program_Type = context
                                .Program_type
                                .Where(x => x.name.Equals(programTypeDTO.name))
                                .FirstOrDefault();
                            if (program_Type == null)
                            {
                                program_Type = Mapper.Map<ProgramTypeDto, Program_type>(programTypeDTO);
                                context.Program_type.Add(program_Type);
                            }
                        }
                        context.SaveChanges();
                        tran.Commit();
                    }
                    catch (Exception ex)
                    {
                        tran.Rollback();
                        throw ex;
                    }
                }
            }
        }

        public void SavePrograms(List<ProgramTvDto> programs)
        {
            using (var context = new Model2())
            {
                using (var tran = context.Database.BeginTransaction())
                {
                    try
                    {
                        foreach (ProgramTvDto programDto in programs)
                        {
                            Program_tv program_tv = Mapper.Map<ProgramTvDto, Program_tv>(programDto);
                            Program_type program_Type = context
                                .Program_type
                                .Where(x => x.name.Equals(programDto.type_name))
                                .FirstOrDefault();
                            program_tv.Program_type = program_Type;
                            context.Program_tv.Add(program_tv);
                        }
                        context.SaveChanges();
                        tran.Commit();
                    }
                    catch (Exception ex)
                    {
                        tran.Rollback();
                        throw ex;
                    }
                }
            }
        }

        public void DeleteProgramsWithIncorrectEndDate()
        {
            using (var context = new Model2())
            {

                var programsToDelete = context
                    .Program_tv
                    .Where(x => ((DateTime)x.end_date).Year == 2100)
                    .ToList();
                programsToDelete
                    .ForEach(x => context.Program_tv.Remove(x));
                context.SaveChanges();
            }
        }
    }
}
