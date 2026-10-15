import { useState } from 'react';

const emptyStudent = { name: '', age: '', course: '', email: '' };

export default function StudentForm({ student, onSave, onCancel }) {
  const [form, setForm] = useState(student
    ? { name: student.name, age: student.age, course: student.course, email: student.email }
    : emptyStudent);
  const [busy, setBusy] = useState(false);

  function updateField(event) {
    setForm({ ...form, [event.target.name]: event.target.value });
  }

  async function handleSubmit(event) {
    event.preventDefault();
    setBusy(true);
    try {
      await onSave({ ...form, age: Number(form.age) });
    } finally {
      setBusy(false);
    }
  }

  return (
    <form className="panel student-form" onSubmit={handleSubmit}>
      <div className="panel-heading">
        <div>
          <span className="eyebrow">STUDENT DETAILS</span>
          <h3>{student ? 'Edit student' : 'Add a student'}</h3>
        </div>
        {student && <button className="text-button" onClick={onCancel} type="button">Cancel</button>}
      </div>
      <div className="fields-grid">
        <label>
          Name
          <input name="name" value={form.name} onChange={updateField} required />
        </label>
        <label>
          Age
          <input name="age" type="number" min="16" value={form.age} onChange={updateField} required />
        </label>
        <label>
          Course
          <input name="course" value={form.course} onChange={updateField} required />
        </label>
        <label>
          Email
          <input name="email" type="email" value={form.email} onChange={updateField} required />
        </label>
      </div>
      <div className="form-actions">
        <button className="button primary" disabled={busy} type="submit">
          {busy ? 'Saving…' : student ? 'Save changes' : 'Add student'}
        </button>
        {student && <button className="button secondary" onClick={onCancel} type="button">Cancel</button>}
      </div>
    </form>
  );
}