import styles from './Profile.module.css';

const Profile = (props) => {
    return (
        <div className={styles.container}>
            <img src={props.children} />
        </div>
    );
}

export default Profile;