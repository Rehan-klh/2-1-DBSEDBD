import { useState } from 'react';

export default function Register({ onRegister, onSwitch, notice, clearNotice }) {
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');
  const [busy, setBusy] = useState(false);

  async function handleSubmit(event) {
    event.preventDefault();
    clearNotice();
    setBusy(true);
    try {
      await onRegister({ username, password });
    } finally {
      setBusy(false);
    }
  }

  return (
    <section className="auth-layout">
      <div className="auth-intro">
        <span className="eyebrow">STUDENT RECORDS</span>
        <h2>A tidy place for every record.</h2>
        <p>Create an account to get started.</p>
      </div>
      <form className="panel auth-panel" onSubmit={handleSubmit}>
        <h3>Create account</h3>
        {notice && <p className={`notice ${notice.type}`} role="status">{notice.text}</p>}
        <label>
          Username
          <input autoComplete="username" value={username} onChange={(event) => setUsername(event.target.value)} required />
        </label>
        <label>
          Password
          <input type="password" autoComplete="new-password" value={password} onChange={(event) => setPassword(event.target.value)} required />
        </label>
        <button className="button primary full-width" disabled={busy} type="submit">
          {busy ? 'Creating account…' : 'Register'}
        </button>
        <p className="form-footnote">Already have an account? <button className="text-button" onClick={onSwitch} type="button">Log in</button></p>
      </form>
    </section>
  );
}