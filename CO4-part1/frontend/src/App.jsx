import { useEffect, useState } from 'react';

const API_URL = 'http://localhost:3000/students';
const emptyForm = { name: '', age: '', course: '', email: '' };

function App() {
  const [students, setStudents] = useState([]);
  const [form, setForm] = useState(emptyForm);
  const [editingId, setEditingId] = useState(null);
  const [loading, setLoading] = useState(true);
  const [saving, setSaving] = useState(false);
  const [error, setError] = useState('');

  const loadStudents = async () => {
    try {
      setLoading(true);
      setError('');
      const response = await fetch(API_URL);
      const data = await response.json();

      if (!response.ok) {
        throw new Error(data.message || 'Could not load students.');
      }

      setStudents(data);
    } catch (requestError) {
      setError(requestError.message || 'Could not connect to the API.');
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    loadStudents();
  }, []);

  const handleChange = (event) => {
    setForm({ ...form, [event.target.name]: event.target.value });
  };

  const resetForm = () => {
    setForm(emptyForm);
    setEditingId(null);
  };

  const handleSubmit = async (event) => {
    event.preventDefault();
    setSaving(true);
    setError('');

    const isEditing = Boolean(editingId);
    const url = isEditing ? `${API_URL}/${editingId}` : API_URL;

    try {
      const response = await fetch(url, {
        method: isEditing ? 'PATCH' : 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ ...form, age: Number(form.age) })
      });
      const data = await response.json();

      if (!response.ok) {
        throw new Error(data.message || 'Could not save student.');
      }

      resetForm();
      await loadStudents();
    } catch (requestError) {
      setError(requestError.message || 'Could not save student.');
    } finally {
      setSaving(false);
    }
  };

  const startEditing = (student) => {
    setEditingId(student._id);
    setForm({
      name: student.name,
      age: student.age,
      course: student.course,
      email: student.email
    });
    setError('');
    window.scrollTo({ top: 0, behavior: 'smooth' });
  };

  const deleteStudent = async (id) => {
    if (!window.confirm('Delete this student?')) return;

    try {
      setError('');
      const response = await fetch(`${API_URL}/${id}`, { method: 'DELETE' });
      const data = await response.json();

      if (!response.ok) {
        throw new Error(data.message || 'Could not delete student.');
      }

      if (editingId === id) resetForm();
      await loadStudents();
    } catch (requestError) {
      setError(requestError.message || 'Could not delete student.');
    }
  };

  return (
    <main className="page-shell">
      <header className="page-header">
        <p className="eyebrow">Student Records</p>
        <h1>Manage your students</h1>
        <p className="subtitle">Add, update, and remove student records from your database.</p>
      </header>

      <section className="content-grid">
        <form className="student-form" onSubmit={handleSubmit}>
          <h2>{editingId ? 'Edit student' : 'Add student'}</h2>
          <label>
            Name
            <input name="name" value={form.name} onChange={handleChange} required />
          </label>
          <label>
            Age
            <input name="age" type="number" min="16" max="100" value={form.age} onChange={handleChange} required />
          </label>
          <label>
            Course
            <input name="course" value={form.course} onChange={handleChange} required />
          </label>
          <label>
            Email
            <input name="email" type="email" value={form.email} onChange={handleChange} required />
          </label>
          <div className="form-actions">
            <button type="submit" disabled={saving}>
              {saving ? 'Saving...' : editingId ? 'Update student' : 'Add student'}
            </button>
            {editingId && (
              <button type="button" className="secondary-button" onClick={resetForm}>
                Cancel
              </button>
            )}
          </div>
        </form>

        <section className="records-section">
          <div className="section-heading">
            <h2>All students</h2>
            <span>{students.length} record{students.length === 1 ? '' : 's'}</span>
          </div>
          {error && <p className="message error-message">{error}</p>}
          {loading ? (
            <p className="message">Loading students...</p>
          ) : students.length === 0 ? (
            <p className="message">No students found. Add the first record.</p>
          ) : (
            <div className="table-wrapper">
              <table>
                <thead>
                  <tr>
                    <th>Name</th>
                    <th>Age</th>
                    <th>Course</th>
                    <th>Email</th>
                    <th>Actions</th>
                  </tr>
                </thead>
                <tbody>
                  {students.map((student) => (
                    <tr key={student._id}>
                      <td data-label="Name">{student.name}</td>
                      <td data-label="Age">{student.age}</td>
                      <td data-label="Course">{student.course}</td>
                      <td data-label="Email">{student.email}</td>
                      <td data-label="Actions" className="actions-cell">
                        <button className="text-button" onClick={() => startEditing(student)}>Edit</button>
                        <button className="text-button delete-button" onClick={() => deleteStudent(student._id)}>Delete</button>
                      </td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          )}
        </section>
      </section>
    </main>
  );
}

export default App;
