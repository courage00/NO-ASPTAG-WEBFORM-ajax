using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HTTPBASE
{
    public partial class Default : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
                if (!IsPostBack)
                {
                   
                }
        }
        //資料頁數
        [WebMethod]
        public static int GetEndpage(string name, string title)
        {
            //抓搜尋 跟初始顯示的頁數
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString();
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                int endpage = 0, datacount = 0;//總頁數 總比數
                int pagelistnum = 5;//每頁顯示數
                string queryString = " select count(EmployeeName) from Employees where 1=1";
                if (!String.IsNullOrEmpty(name))
                {
                    queryString  +="and EmployeeName like '%'+@EmployeeName+'%'";
                }
                if (!String.IsNullOrEmpty(title))
                {
                    queryString+="and Title like '%' + @Title + '%'  ";
                }
                SqlCommand command = new SqlCommand(queryString, connection);
                if (!String.IsNullOrEmpty(name))
                {
                    command.Parameters.AddWithValue("@EmployeeName", name);
                }
                if (!String.IsNullOrEmpty(title))
                {
                    command.Parameters.AddWithValue("@Title", title);
                }
                datacount = (int)command.ExecuteScalar();
                 //總共頁數  每五筆一頁
                if (datacount % pagelistnum == 0)//餘數為0
                {
                    endpage = datacount / pagelistnum;
                }
                else //餘數不等於 0 時
                {
                    endpage = datacount / pagelistnum + 1;
                }
                return endpage;
            }

              
        }

        //得到資料
        [WebMethod]
        public static string GetData(int page ,string name ,string title)
        {
            int startid = (page - 1)*5;
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString();

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                //string queryString = "select EmployeeID,EmployeeName,Title,BirthDate,Address,Salary from Employees where EmployeeName like '%'+@EmployeeName+'%'and Title like '%'+@Title+'%' order by  EmployeeID offset @startid rows fetch next 5 rows only";
                string queryString = " select EmployeeID,EmployeeName,Title,BirthDate,Address,Salary from Employees where 1=1";
                if (!String.IsNullOrEmpty(name))
                {
                    queryString += "and EmployeeName like '%'+@EmployeeName+'%'";
                }
                if (!String.IsNullOrEmpty(title))
                {
                    queryString += "and Title like '%' + @Title + '%'  ";
                }
                queryString += "order by EmployeeID offset @startid rows fetch next 5 rows only";
                SqlCommand command = new SqlCommand(queryString, connection);
                if (!String.IsNullOrEmpty(name))
                {
                    command.Parameters.AddWithValue("@EmployeeName", name);
                }
                if (!String.IsNullOrEmpty(title))
                {
                    command.Parameters.AddWithValue("@Title", title);
                }
                command.Parameters.AddWithValue("@startid", startid);
 
                SqlDataAdapter adapter = new SqlDataAdapter(command);
                DataSet ds = new DataSet();
 
                adapter.Fill(ds);

                string str_json = JsonConvert.SerializeObject(ds.Tables[0], Formatting.Indented);

                return str_json;
                //return name;

            }   
        }
        //儲存新增
        [WebMethod]
        public static string New(string name, string title, string titlec ,string bdate, string hdate, string address, string hphone, string ex, string photopath, string notes, string mgid, string salary)
        {
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString();

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                string queryString = " insert into Employees (EmployeeName,Title,TitleOfCourtesy,BirthDate,HireDate,Address,HomePhone,Extension,PhotoPath,Notes,ManagerID,Salary) values(@EmployeeName,@Title,@TitleOfCourtesy,@BirthDate,@HireDate,@Address,@HomePhone,@Extension,@PhotoPath,@Notes,@ManagerID,@Salary)";

                string birthdate= DateTime.Parse(bdate).ToString("yyyy/MM/dd");
                string hiredate = DateTime.Parse(hdate).ToString("yyyy/MM/dd");
                SqlCommand command = new SqlCommand(queryString, connection);
                command.Parameters.AddWithValue("@EmployeeName", name);
                command.Parameters.AddWithValue("@Title", title);
                command.Parameters.AddWithValue("@TitleOfCourtesy", titlec);
                command.Parameters.AddWithValue("@BirthDate", birthdate);
                command.Parameters.AddWithValue("@HireDate", hiredate);
                command.Parameters.AddWithValue("@Address", address);
                command.Parameters.AddWithValue("@HomePhone", hphone);
                command.Parameters.AddWithValue("@Extension", ex);
                command.Parameters.AddWithValue("@PhotoPath", photopath);
                command.Parameters.AddWithValue("@Notes", notes);
                command.Parameters.AddWithValue("@ManagerID", mgid);
                command.Parameters.AddWithValue("@Salary", salary);
                //command.Parameters.AddWithValue("@EmployeeID", from);

                command.ExecuteNonQuery();
            }

            return "";

        }

        //儲存修改
        [WebMethod]
        public static string SaveEdit(string id, string name, string title, string titlec, string bdate, string hdate, string address, string hphone, string ex, string photopath, string notes, string mgid, string salary)
        {
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString();

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open(); 
                string queryString = " update Employees set  EmployeeName=@EmployeeName,Title=@Title,TitleOfCourtesy=@TitleOfCourtesy,BirthDate=@BirthDate,HireDate=@HireDate,Address=@Address,HomePhone=@HomePhone,Extension=@Extension,PhotoPath=@PhotoPath,Notes=@Notes,ManagerID=@ManagerID,Salary=@Salary where EmployeeID=@EmployeeID";

                string birthdate = DateTime.Parse(bdate).ToString("yyyy/MM/dd");
                string hiredate = DateTime.Parse(hdate).ToString("yyyy/MM/dd");
                SqlCommand command = new SqlCommand(queryString, connection);
                command.Parameters.AddWithValue("@EmployeeName", name);
                command.Parameters.AddWithValue("@Title", title);
                command.Parameters.AddWithValue("@TitleOfCourtesy", titlec);
                command.Parameters.AddWithValue("@BirthDate", birthdate);
                command.Parameters.AddWithValue("@HireDate", hiredate);
                command.Parameters.AddWithValue("@Address", address);
                command.Parameters.AddWithValue("@HomePhone", hphone);
                command.Parameters.AddWithValue("@Extension", ex);
                command.Parameters.AddWithValue("@PhotoPath", photopath);
                command.Parameters.AddWithValue("@Notes", notes);
                command.Parameters.AddWithValue("@ManagerID", mgid);
                command.Parameters.AddWithValue("@Salary", salary);
                command.Parameters.AddWithValue("@EmployeeID", id);

                command.ExecuteNonQuery();
            }

            return "";

        }
        //刪除
        [WebMethod]
        public static string Delete(string id)
        {

            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString();

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                string queryString = " delete from  Employees where EmployeeID=@EmployeeID";

                SqlCommand command = new SqlCommand(queryString, connection);
                command.Parameters.AddWithValue("@EmployeeID", Convert.ToInt32(id));
                command.ExecuteNonQuery();
               
            }
            return "";
        }

        //修改
        [WebMethod]
        public static string Edit(string emid)
        {
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString();

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                string queryString = " select * from  Employees where EmployeeID=@EmployeeID";

                SqlCommand command = new SqlCommand(queryString, connection);
                command.Parameters.AddWithValue("@EmployeeID", emid);
                SqlDataAdapter adapter = new SqlDataAdapter(command);
                DataSet ds = new DataSet();
                adapter.Fill(ds);

                string edit_json = JsonConvert.SerializeObject(ds.Tables[0], Formatting.Indented);

                return edit_json;
            }
    
        }
    }
}