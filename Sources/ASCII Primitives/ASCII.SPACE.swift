// ASCII.SPACE.swift
// swift-ascii-primitives
//
// Section 4.2: SPACE (INCITS 4-1986)

extension ASCII {
    /// Section 4.2: SPACE (0x20)
    ///
    /// Namespace for the SPACE character, which uniquely serves both as a graphic character and a control character.
    ///
    /// ## Overview
    ///
    /// SPACE (0x20) occupies a special position in the US-ASCII character set as the only character
    /// with a dual interpretation. Per INCITS 4-1986 Section 4.2, "The character SPACE is both a
    /// graphic character and a control character." This dual nature reflects its fundamental role
    /// in text representation and formatting.
    ///
    /// Unlike the 94 other graphic characters (0x21-0x7E) which have distinct visual glyphs,
    /// SPACE represents the **absence** of a graphic symbol while still being considered a graphic
    /// character. This paradoxical property makes it essential for word separation in human-readable
    /// text while also serving as a formatting control for device positioning.
    ///
    /// ## Dual Interpretation
    ///
    /// **As a Graphic Character**:
    /// - Has a visual representation consisting of the **absence of a graphic symbol**
    /// - Provides word separation and spacing in text
    /// - Counted as part of the 95 graphic characters (including SPACE, 0x20-0x7E)
    /// - Essential for human-readable text formatting
    ///
    /// **As a Control Character (Format Effector)**:
    /// - Acts as a format effector that advances the active position
    /// - Causes the print/display position to move one character position forward
    /// - Similar in function to other format effectors (TAB, CR, LF)
    /// - Controls physical positioning of subsequent characters
    ///
    /// ## Standards Compliance
    ///
    /// This implementation strictly follows INCITS 4-1986 (R2022) Section 4.2, which states:
    ///
    /// > "The character SPACE is both a graphic character and a control character. As a graphic
    /// > character, it has a visual representation consisting of the absence of a graphic symbol.
    /// > As a control character, it acts as a format effector that causes the active position to
    /// > be advanced one character position."
    ///
    /// ## Usage
    ///
    /// ```swift
    /// // Access SPACE character
    /// let space = ASCII.SPACE.sp  // 0x20
    ///
    /// // Use in word separation
    /// let bytes: [UInt8] = [
    ///     ASCII.GraphicCharacters.H,
    ///     ASCII.GraphicCharacters.i,
    ///     ASCII.SPACE.sp,
    ///     ASCII.GraphicCharacters.t,
    ///     ASCII.GraphicCharacters.h,
    ///     ASCII.GraphicCharacters.e,
    ///     ASCII.GraphicCharacters.r,
    ///     ASCII.GraphicCharacters.e
    /// ]
    ///
    /// // Check for whitespace (includes SPACE)
    /// let byte: UInt8 = 0x20
    /// if ASCII.whitespaces.contains(byte) {
    ///     print("Is whitespace")  // Executes
    /// }
    /// ```
    ///
    /// ## See Also
    ///
    /// - ``ASCII/whitespaces``
    /// - ``GraphicCharacters``
    /// - ``ControlCharacters``
    public enum SPACE {}
}

extension ASCII.SPACE {
    /// SPACE (0x20) - The dual-nature whitespace character
    ///
    /// The authoritative definition of the SPACE character in US-ASCII.
    ///
    /// **Acronym**: SP
    ///
    /// ## Dual Nature
    ///
    /// This character is unique in the ASCII standard because it is interpreted both as a graphic
    /// character and as a control character:
    ///
    /// - **Graphic interpretation**: Represents the absence of a visible symbol, providing word
    ///   separation and spacing in text
    /// - **Control interpretation**: Acts as a format effector that advances the active position
    ///   by one character position
    ///
    /// ## Usage
    ///
    /// ```swift
    /// // Direct byte value
    /// let space = ASCII.SPACE.sp  // 0x20
    ///
    /// // Word separation in byte arrays
    /// let greeting: [UInt8] = [
    ///     ASCII.GraphicCharacters.H,
    ///     ASCII.GraphicCharacters.i,
    ///     ASCII.SPACE.sp,  // Word separator
    ///     ASCII.GraphicCharacters.t,
    ///     ASCII.GraphicCharacters.h,
    ///     ASCII.GraphicCharacters.e,
    ///     ASCII.GraphicCharacters.r,
    ///     ASCII.GraphicCharacters.e
    /// ]
    ///
    /// // Part of whitespace set
    /// let isWhitespace = ASCII.whitespaces.contains(ASCII.SPACE.sp)  // true
    /// ```
    ///
    /// ## See Also
    ///
    /// - ``ASCII/whitespaces``
    /// - ``ASCII/SPACE``
    public static let sp: UInt8 = 0x20
}
