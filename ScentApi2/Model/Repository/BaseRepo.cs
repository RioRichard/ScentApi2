namespace ScentApi2.Model.Repository
{
    public class BaseRepo
    {
        protected DataContext Context;

        public BaseRepo(DataContext context)
        {
            Context = context;
        }
    }
}
