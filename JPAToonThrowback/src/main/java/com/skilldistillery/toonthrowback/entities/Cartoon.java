package com.skilldistillery.toonthrowback.entities;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import com.fasterxml.jackson.annotation.JsonIgnore;



@Entity
public class Cartoon {
	
	@Id
	@GeneratedValue(strategy= GenerationType.IDENTITY)
	private int id;
	
	private String image;
	
	private String name;
	
	private String description;
	
	private String url;
	
	private boolean active;
	
	@Column(name="airing_date")
	private LocalDateTime airingDate;
	
	@Column(name="finale_date")
	private LocalDateTime finaleDate;
	
	@CreationTimestamp
	@Column(name="created_date")
	private LocalDateTime createdDate;
	
	@UpdateTimestamp
	@Column(name="updated_date")
	private LocalDateTime updatedDate;
	
	@ManyToOne
	@JoinColumn(name="user_id")
	private User user;
	
	@ManyToMany
	@JoinTable(name="favorite", 
			   joinColumns = @JoinColumn(name="cartoon_id"), 
			   inverseJoinColumns= @JoinColumn(name="user_id"))
	private List<User> userFavs;
	
	@ManyToOne
	@JoinColumn(name="network_id")
	private Network network;
	
	@ManyToOne
	@JoinColumn(name="rating_id")
	private Rating rating;
	
	@ManyToOne
	@JoinColumn(name="creator_id")
	private Creator creator;
	
	@JsonIgnore
	@OneToMany(mappedBy="cartoon")
	private List<Comment> comment;
	
	@JsonIgnore
	@OneToMany(mappedBy="cartoon")
	private List<Fact> facts;
	
	@JsonIgnore
	@OneToMany(mappedBy="cartoon")
	private List<Trivia> trivias;
	
	@JsonIgnore
	@OneToMany(mappedBy="cartoon")
	private List<Merchandise> merch;
	
	@JsonIgnore
	@OneToMany(mappedBy="cartoon")
	private List<Media> media;
	
/////////////////////////////////////////////////////////////////////////////////	

	public List<Media> getMedia() {
		return media;
	}

	public void setMedia(List<Media> media) {
		this.media = media;
	}

	public Cartoon() {
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public boolean isActive() {
		return active;
	}

	public void setActive(boolean active) {
		this.active = active;
	}

	public LocalDateTime getAiringDate() {
		return airingDate;
	}

	public void setAiringDate(LocalDateTime airingDate) {
		this.airingDate = airingDate;
	}

	public LocalDateTime getFinaleDate() {
		return finaleDate;
	}

	public void setFinaleDate(LocalDateTime finaleDate) {
		this.finaleDate = finaleDate;
	}

	public LocalDateTime getCreatedDate() {
		return createdDate;
	}

	public void setCreatedDate(LocalDateTime createdDate) {
		this.createdDate = createdDate;
	}

	public LocalDateTime getUpdatedDate() {
		return updatedDate;
	}

	public void setUpdatedDate(LocalDateTime updatedDate) {
		this.updatedDate = updatedDate;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public List<User> getUserFavs() {
		return userFavs;
	}

	public void setUserFavs(List<User> userFavs) {
		this.userFavs = userFavs;
	}

	public Network getNetwork() {
		return network;
	}

	public void setNetwork(Network network) {
		this.network = network;
	}

	public Rating getRating() {
		return rating;
	}

	public void setRating(Rating rating) {
		this.rating = rating;
	}

	public Creator getCreator() {
		return creator;
	}

	public void setCreator(Creator creator) {
		this.creator = creator;
	}

	public List<Comment> getComment() {
		return comment;
	}

	public void setComment(List<Comment> comment) {
		this.comment = comment;
	}

	public List<Fact> getFacts() {
		return facts;
	}

	public void setFacts(List<Fact> facts) {
		this.facts = facts;
	}

	public List<Trivia> getTrivias() {
		return trivias;
	}

	public void setTrivias(List<Trivia> trivias) {
		this.trivias = trivias;
	}

	public List<Merchandise> getMerch() {
		return merch;
	}

	public void setMerch(List<Merchandise> merch) {
		this.merch = merch;
	}

	@Override
	public String toString() {
		return "Cartoon [id=" + id + ", image=" + image + ", name=" + name + ", description=" + description + ", url="
				+ url + ", active=" + active + ", airingDate=" + airingDate + ", finaleDate=" + finaleDate
				+ ", createdDate=" + createdDate + ", updatedDate=" + updatedDate + ", user=" + user + ", network="
				+ network + ", rating=" + rating + ", creator=" + creator + "]";
	}

	@Override
	public int hashCode() {
		return Objects.hash(id);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Cartoon other = (Cartoon) obj;
		return id == other.id;
	}

}
