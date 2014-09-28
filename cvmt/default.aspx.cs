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
    public partial class index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void submit_click(object sender, EventArgs e)
        {
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["cmvtConnectionString"].ConnectionString);

            string strSql = "INSERT into user_signin(user_name,password) ";
            strSql = strSql + "values(@username,@password)";
            SqlCommand Command = new SqlCommand(strSql, conn);
            Command.CommandType = CommandType.Text;

            string strSql2 = "insert into user_info(user_name,fname,lname) ";
            strSql2 = strSql2 + "values(@username,@fname,@lname)";
            SqlCommand Command2 = new SqlCommand(strSql2, conn);
            Command2.CommandType = CommandType.Text;
            try
            {
                //define the command parameters 
                Command.Parameters.Add(new SqlParameter("@username", SqlDbType.VarChar));
                //Command.Parameters["@CustomerID"].Direction = ParameterDirection.Input;
                //Command.Parameters["@CustomerID"].Size = 20;
                Command.Parameters["@username"].Value = email.Text;

                Command.Parameters.Add(new SqlParameter("@password", SqlDbType.VarChar));
                Command.Parameters["@password"].Value = pass.Text;

                
                conn.Open();
                Command.ExecuteNonQuery();
    
                conn.Close();
            }
            catch
            {
            }
            try {
                Command2.Parameters.Add(new SqlParameter("@username", SqlDbType.VarChar));
                Command2.Parameters["@username"].Value = email.Text;
                Command2.Parameters.Add(new SqlParameter("@fname", SqlDbType.VarChar));
                Command2.Parameters["@fname"].Value = fname.Text;
                Command2.Parameters.Add(new SqlParameter("@lname", SqlDbType.VarChar));
                Command2.Parameters["@lname"].Value = lname.Text;
                conn.Open();
                Command2.ExecuteNonQuery();
                conn.Close();
            }
            catch { }
        }
        protected void Button1_Click(object sender, EventArgs e)
        {
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["cmvtConnectionString"].ConnectionString);
            conn.Open();
            string check_username = "SELECT password FROM user_signin WHERE user_name ='" + u_name.Text + "'";
            SqlCommand username = new SqlCommand(check_username, conn);
            object result = username.ExecuteScalar();
            conn.Close();
            if (result != null)
            {
                if (result.ToString() == password.Text)
                {
                    conn.Open();
                    check_username = "SELECT lname FROM user_info WHERE user_name = '" + u_name.Text + "'";
                    username = new SqlCommand(check_username, conn);
                    result = username.ExecuteScalar();
                    conn.Close();
                    Session["u_name"] = result.ToString();
                    Response.Redirect("worksheet.aspx");
                }
                else
                {
                    warning.Visible= true;
                    warning.Text = "Wrong password";
                }
            }
            else
            {
                warning.Visible = true;
                warning.Text = "Account doesnot exist";
            }
        }
    }
}