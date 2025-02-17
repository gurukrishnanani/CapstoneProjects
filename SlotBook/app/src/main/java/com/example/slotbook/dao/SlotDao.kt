package com.example.slotbook.dao

import androidx.lifecycle.LiveData
import androidx.room.Dao
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query
import com.example.slotbook.model.Slot
//
@Dao
interface SlotDao {
    @Query("SELECT * FROM slots WHERE trackId = :trackId AND isBooked = 0")
    suspend fun getAvailableSlots(trackId: Int): List<Slot>

    suspend fun getHardcodedSlots(trackId: Int): List<Slot> {
        return when (trackId) {
            1 -> listOf(
                Slot(1, 1, "2025-03-16", "9:00 AM", false),
                Slot(2, 1, "2025-04-16", "10:00 AM", false)
            )
            2 -> listOf(
                Slot(3, 2, "2025-06-17", "01:00 PM", false),
                Slot(4, 2, "2025-05-17", "03:00 PM", false)
            )
            else -> emptyList()
        }
    }
}

