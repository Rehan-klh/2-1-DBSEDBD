import { useState } from 'react';

export default function Login({ onLogin, onSwitch, notice, clearNotice }) {
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');
  const [busy, setBusy] = useState(false);

  async function handleSubmit(event) {
    event.preventDefault();
    clearNotice();
    setBusy(true);
    try {
      await onLogin({ username, password });
    } finally {
      setBusy(false);
    }
  }

  return (
    <section className="auth-layout">
      <div className="auth-intro">
        <span className="eyebrow">STUDENT RECORDS</span>
        <h2>Good to see you.</h2>
        <p>Sign in to manage your student directory.</p>
      </div>
      <form className="panel auth-panel" onSubmit={handleSubmit}>
        <h3>Log in</h3>
        {notice && <p className={`notice ${notice.type}`} role="status">{notice.text}</p>}
        <label>
          Username
          <input autoComplete="username" value={username} onChange={(event) => setUsername(event.target.value)} required />
        </label>
        <label>
          Password
          <input type="password" autoComplete="current-password" value={password} onChange={(event) => setPassword(event.target.value)} required />
        </label>
        <button className="button primary full-width" disabled={busy} type="submit">
          {busy ? 'Signing in…' : 'Log in'}
        </button>
        <p className="form-footnote">New here? <button className="text-button" onClick={onSwitch} type="button">Create an account</button></p>
      </form>
    </section>
  );
}