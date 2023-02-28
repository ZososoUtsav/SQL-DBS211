/*
Name: utsav gautam
*/
#include <iostream>
#include <occi.h>

using oracle::occi::Connection;
using oracle::occi::Environment;

using namespace oracle::occi;
using namespace std;

int main()
{

    Environment *env = nullptr;
    Connection *conn = nullptr;
    string user = "dbs211_231zaa50";
    string password = "101100"; // replace with real password
    string constr = "myoracle12c.senecacollege.ca:1521/oracle12c";

    // define a reference to an object statement
    Statement *stmt = nullptr;

    // define a reference to an object resultset
    ResultSet *rs = nullptr;

    try
    {
        env = Environment::createEnvironment(Environment::DEFAULT);
        {
            conn = env->createConnection(user, password, constr);
            cout << "Connection is Successfull" << endl;

            // employee report
            // call method createStatement() to create an statement object
            stmt = conn->createStatement("SELECT e.employeenumber, e.firstname, e.lastname, "
                                         "o.phone, e.extension FROM employees e "
                                         "LEFT JOIN offices o "
                                         "ON e.officecode = o.officecode "
                                         "WHERE e.officecode IN '1'"
                                         "ORDER BY e.employeenumber");

            stmt->executeQuery();

            // store the result set
            rs = stmt->executeQuery();

            if (!rs->next())
            {
                // if the result set is empty
                cout << "ResultSet is empty." << endl;
            }
            else
            {
                // if the result set in not empty
                cout << endl;
                cout << "------------------------- Report 1 (Employee Report) -----------------------------------" << endl;
                cout << "Employee ID   First Name         Last Name          Phone             Extension" << endl;
                cout << "------------  -----------------  -----------------  ----------------  ---------" << endl;

                do
                {
                    cout.setf(ios::left);
                    cout.width(14);
                    cout << rs->getInt(1);
                    cout.width(19);
                    cout << rs->getString(2);
                    cout.width(19);
                    cout << rs->getString(3);
                    cout.width(18);
                    cout << rs->getString(4);
                    cout.width(6);
                    cout << rs->getString(5) << endl;
                    cout.unsetf(ios::left);

                } while (rs->next()); // if there is more rows, iterate
            }

            // manager report
            // call method createStatement() to create an statement object
            stmt = conn->createStatement("SELECT DISTINCT (m.employeenumber), m.firstname, m.lastname, "
                                         "o.phone, m.extension FROM employees m "
                                         "JOIN employees e "
                                         "ON m.employeenumber = e.reportsto "
                                         "LEFT JOIN offices o "
                                         "ON m.officecode = o.officecode "
                                         "ORDER BY m.employeenumber");

            stmt->executeQuery();

            // store the result set
            rs = stmt->executeQuery();

            if (!rs->next())
            {
                // if the result set is empty
                cout << "ResultSet is empty." << endl;
            }
            else
            {
                // if the result set in not empty

                cout << endl;
                cout << "------------------------- Report 2 (Manager Report) -----------------------------------" << endl;
                cout << "Employee ID   First Name         Last Name          Phone             Extension" << endl;
                cout << "------------  -----------------  -----------------  ----------------  ---------" << endl;

                do
                {
                    cout.setf(ios::left);
                    cout.width(14);
                    cout << rs->getInt(1);
                    cout.width(19);
                    cout << rs->getString(2);
                    cout.width(19);
                    cout << rs->getString(3);
                    cout.width(18);
                    cout << rs->getString(4);
                    cout.width(6);
                    cout << rs->getString(5) << endl;
                    cout.unsetf(ios::left);

                } while (rs->next()); // if there is more rows, iterate
            }

            conn->terminateStatement(stmt);

            Environment::terminateEnvironment(env);
        }
    }
    catch (SQLException &sqlExcp)
    {
        cout << sqlExcp.getErrorCode() << ": " << sqlExcp.getMessage();
    }

    return 0;
}
