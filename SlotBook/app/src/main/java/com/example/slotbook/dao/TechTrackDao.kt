package com.example.slotbook.dao

import androidx.lifecycle.LiveData
import androidx.room.Dao
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query
import com.example.slotbook.model.TechTrack

@Dao
interface TechTrackDao {

    @Query("SELECT * FROM tech_tracks")
    suspend fun getTracks(): List<TechTrack>

    suspend fun getHardcodedTracks(): List<TechTrack> {
        return listOf(
            TechTrack(1, "Android Development"),
            TechTrack(2, "iOS Development"),
            TechTrack(3, "Web Development"),
            TechTrack(4, "Machine Learning")

        )
    }
}

