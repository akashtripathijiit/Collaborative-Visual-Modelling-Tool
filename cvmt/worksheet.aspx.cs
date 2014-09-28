using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

namespace cvmt
{
    public partial class worksheet : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void button(object sender, EventArgs e)
        {
        
             /*SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["cmvtConnectionString"].ConnectionString);
               conn.Open();
               string query_max_no = "SELECT MAX(p_number) FROM projects";
               SqlCommand query_max = new SqlCommand(query_max_no, conn);
               object result = query_max.ExecuteScalar();
               int proj_no = Convert.ToInt32( result.ToString());
               proj_no++;
               string insert_new_proj = "INSERT INTO projects VALUES (@p_number, @user_id, @p_name, @shared_by)";
               SqlCommand insert_proj = new SqlCommand(insert_new_proj , conn);
               insert_proj.Parameters.Add(new SqlParameter("@p_number", proj_no));
               insert_proj.Parameters.Add(new SqlParameter("@user_id", "fake"));
               insert_proj.Parameters.Add(new SqlParameter("@p_name","fake_proj"));
               insert_proj.Parameters.Add(new SqlParameter("@shared_by", "farji"));

              
               Response.Write("heyyyyyy here !!! = " + insert_proj.ExecuteNonQuery());
            */

        }

        public void create_new_file(object sender, EventArgs e)
        {   
            string u_name = (string)Session["u_name"];
            //filename.Text = "";

        }
    }
}