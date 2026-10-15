import { useEffect, useState } from 'react';
import { api } from './api.js';
import Login from './components/Login.jsx';
import Register from './components/Register.jsx';
import StudentForm from './components/StudentForm.jsx';
import StudentList from './components/StudentList.jsx';

export default function App() {
  const [token, setToken] = useState(() => localStorage.getItem('studentRecordsToken'));
  const [username, setUsername] = useState(() => localStorage.getItem('studentRecordsUsername') || '');
  const [students, setStudents] = useState([]);
  const [authView, setAuthView] = useState('login');
  const [editingStudent, setEditingStudent] = useState(null);
  const [showForm, setShowForm] = useState(false);
  const [notice, setNotice] = useState(null);

  function clearSession(message) {
    localStorage.removeItem('studentRecordsToken');
    localStorage.removeItem('studentRecordsUsername');
    setToken(null);
    setUsername('');
    setStudents([]);
    setEditingStudent(null);
    setShowForm(false);
    if (message) setNotice({ type: 'error', text: message });
  }

  async function refreshStudents(currentToken = token) {
    try {
      const data = await api.getStudents(currentToken);
      setStudents(Array.isArray(data) ? data : []);
    } catch (error) {
      if (error.status === 401 || error.status === 403) {
        clearSession(error.message);
      } else {
        setNotice({ type: 'error', text: error.message });
      }
    }
  }

  useEffect(() => {
    if (token) refreshStudents(token);
  }, [token]);

  async function handleLogin(details) {
    try {
      const result = await api.login(details);
      localStorage.setItem('studentRecordsToken', result.token);
      localStorage.setItem('studentRecordsUsername', details.username);
      setUsername(details.username);
      setNotice(null);
      setToken(result.token);
    } catch (error) {
      setNotice({ type: 'error', text: error.message === 'Request failed. Check the information and try again.'
        ? 'Invalid username or password.'
        : error.message });
    }
  }

  async function handleRegister(details) {
    try {
      const result = await api.register(details);
      setAuthView('login');
      setNotice({ type: 'success', text: result?.message || 'Account created. You can now log in.' });
    } catch (error) {
      setNotice({ type: 'error', text: error.message });
    }
  }

  async function handleSave(student) {
    try {
      if (editingStudent) {
        await api.updateStudent(token, editingStudent.id, student);
      } else {
        await api.createStudent(token, student);
      }
      setNotice({ type: 'success', text: editingStudent ? 'Student updated.' : 'Student added.' });
      setEditingStudent(null);
      setShowForm(false);
      await refreshStudents();
    } catch (error) {
      if (error.status === 401 || error.status === 403) clearSession(error.message);
      else setNotice({ type: 'error', text: error.message });
    }
  }

  async function handleDelete(student) {
    if (!window.confirm(`Delete ${student.name}'s record?`)) return;
    try {
      await api.deleteStudent(token, student.id);
      setNotice({ type: 'success', text: 'Student deleted.' });
      await refreshStudents();
    } catch (error) {
      if (error.status === 401 || error.status === 403) clearSession(error.message);
      else setNotice({ type: 'error', text: error.message });
    }
  }

  function startEditing(student) {
    setEditingStudent(student);
    setShowForm(true);
    setNotice(null);
  }

  function startAdding() {
    setEditingStudent(null);
    setShowForm(true);
    setNotice(null);
  }

  function cancelForm() {
    setEditingStudent(null);
    setShowForm(false);
  }

  return (
    <main className="app-shell">
      <header className="topbar">
        <a className="brand" href="/" aria-label="Student Records home">
          <span className="brand-mark">SR</span>
          <span>Student Records</span>
        </a>
        {token && (
          <div className="account-tools">
            <span className="signed-in"><span className="online-dot" />{username}</span>
            <button className="button secondary small" onClick={() => clearSession()} type="button">Log out</button>
          </div>
        )}
      </header>

      {token ? (
        <div className="dashboard">
          <div className="page-heading">
            <div>
              <span className="eyebrow">OVERVIEW</span>
              <h1>Your students</h1>
              <p>Keep student details organized in one place.</p>
            </div>
            {!showForm && <button className="button primary add-button" onClick={startAdding} type="button"><span>+</span> Add student</button>}
          </div>
          {notice && <p className={`notice dashboard-notice ${notice.type}`} role="status">{notice.text}</p>}
          {showForm && <StudentForm key={editingStudent?.id || 'new'} student={editingStudent} onSave={handleSave} onCancel={cancelForm} />}
          <StudentList students={students} onEdit={startEditing} onDelete={handleDelete} />
        </div>
      ) : (
        <div className="auth-area">
          {authView === 'login' ? (
            <Login
              onLogin={handleLogin}
              onSwitch={() => { setAuthView('register'); setNotice(null); }}
              notice={notice}
              clearNotice={() => setNotice(null)}
            />
          ) : (
            <Register
              onRegister={handleRegister}
              onSwitch={() => { setAuthView('login'); setNotice(null); }}
              notice={notice}
              clearNotice={() => setNotice(null)}
            />
          )}
        </div>
      )}
      <footer className="page-footer">Student Records <span>·</span> Secure student directory</footer>
    </main>
  );
}