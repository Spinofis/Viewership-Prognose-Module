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
        public  ICollection<ProgramTypeDTO> GetProgramTypes()
        {
            using (var context = new Model())
            {
                try
                {
                    var obj = (from prt in context.Program_type
                               select new ProgramTypeDTO()
                               {
                                   Id = prt.prt_id,
                                   Name = prt.prt_name
                               }).ToList();
                    return obj;
                }
                catch (Exception ex)
                {
                    Console.WriteLine(ex.ToString());
                    return null;
                }
            }
        }

        public ProgramTypeDTO SaveProgramType(ProgramTypeDTO programTypeDTO)
        {
            using (var context = new Model())
            {
                try
                {
                    Program_type program_Type = new Program_type();
                    program_Type = Mapper.Map(programTypeDTO, program_Type);
                    context.Program_type.Add(program_Type);
                    context.SaveChanges();
                    programTypeDTO.Id = program_Type.prt_id;
                    return programTypeDTO;
                }
                catch (Exception ex)
                {
                    Console.WriteLine(ex.ToString());
                    return null;
                }
            }
        }
    }
}
