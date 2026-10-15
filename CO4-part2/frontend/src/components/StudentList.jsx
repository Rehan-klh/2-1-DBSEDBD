export default function StudentList({ students, onEdit, onDelete }) {
  return (
    <section className="panel list-panel">
      <div className="panel-heading list-heading">
        <div>
          <span className="eyebrow">DIRECTORY</span>
          <h3>Students <span className="count">{students.length}</span></h3>
        </div>
      </div>
      {students.length === 0 ? (
        <div className="empty-state">
          <span className="empty-mark">+</span>
          <p>No students yet</p>
          <span>Add a student above to start your directory.</span>
        </div>
      ) : (
        <div className="table-scroll">
          <table>
            <thead>
              <tr><th>Name</th><th>Age</th><th>Course</th><th>Email</th><th>Actions</th></tr>
            </thead>
            <tbody>
              {students.map((student) => (
                <tr key={student.id}>
                  <td className="student-name">{student.name}</td>
                  <td>{student.age}</td>
                  <td><span className="course-tag">{student.course}</span></td>
                  <td>{student.email}</td>
                  <td>
                    <div className="row-actions">
                      <button className="button small secondary" onClick={() => onEdit(student)} type="button">Edit</button>
                      <button className="button small danger" onClick={() => onDelete(student)} type="button">Delete</button>
                    </div>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      )}
    </section>
  );
}