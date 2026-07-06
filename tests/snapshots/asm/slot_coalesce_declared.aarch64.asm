
slot_coalesce_declared.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	sub	x16, x29, #0x28
               	str	x8, [x16]
               	sub	x1, x29, #0x20
               	str	x0, [x1]
               	sub	x1, x29, #0x20
               	mov	x17, #0x5555            // =21845
               	eor	x2, x0, x17
               	str	x2, [x1, #0x8]
               	sub	x1, x29, #0x20
               	add	x2, x0, #0x9
               	str	x2, [x1, #0x10]
               	sub	x1, x29, #0x20
               	mov	x17, #0x3               // =3
               	mul	x0, x0, x17
               	str	x0, [x1, #0x18]
               	sub	x0, x29, #0x20
               	mov	x16, x0
               	sub	x17, x29, #0x28
               	ldr	x17, [x17]
               	ldr	x0, [x16]
               	str	x0, [x17]
               	ldr	x0, [x16, #0x8]
               	str	x0, [x17, #0x8]
               	ldr	x0, [x16, #0x10]
               	str	x0, [x17, #0x10]
               	ldr	x0, [x16, #0x18]
               	str	x0, [x17, #0x18]
               	mov	x0, x17
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<useq>:
               	str	x0, [sp, #-0x10]!
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x0, x29, #0x20
               	ldur	x1, [x29, #0x10]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x1, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [x1, #0x18]
               	str	x10, [x0, #0x18]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x20
               	ldr	x0, [x0]
               	sub	x1, x29, #0x20
               	ldr	x1, [x1, #0x8]
               	add	x0, x0, x1
               	sub	x1, x29, #0x20
               	ldr	x1, [x1, #0x10]
               	add	x0, x0, x1
               	sub	x1, x29, #0x20
               	ldr	x1, [x1, #0x18]
               	add	x0, x0, x1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret

<simple>:
               	mov	x2, #0x0                // =0
               	mov	x1, x2
               	b	<addr>
               	mov	x17, #0x3               // =3
               	mul	x3, x2, x17
               	add	x3, x3, #0x7
               	add	x1, x1, x3
               	add	x2, x2, #0x1
               	cmp	x2, x0
               	b.lt	<addr>
               	mov	x0, x1
               	ret

<heavy>:
               	mov	x2, #0x0                // =0
               	mov	x1, x2
               	b	<addr>
               	mov	x17, #0x3               // =3
               	mul	x3, x2, x17
               	add	x4, x3, #0x7
               	add	x1, x1, x4
               	add	x4, x2, x2
               	add	x4, x4, x2
               	sub	x3, x4, x3
               	add	x1, x1, x3
               	mov	x17, #0x9               // =9
               	mul	x3, x2, x17
               	sub	x3, x3, x3
               	add	x1, x1, x3
               	add	x2, x2, #0x1
               	cmp	x2, x0
               	b.lt	<addr>
               	mov	x0, x1
               	ret

<sum8>:
               	str	x0, [sp, #-0x10]!
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	sub	x0, x29, #0x40
               	ldur	x1, [x29, #0x10]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x1, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [x1, #0x18]
               	str	x10, [x0, #0x18]
               	ldr	x10, [x1, #0x20]
               	str	x10, [x0, #0x20]
               	ldr	x10, [x1, #0x28]
               	str	x10, [x0, #0x28]
               	ldr	x10, [x1, #0x30]
               	str	x10, [x0, #0x30]
               	ldr	x10, [x1, #0x38]
               	str	x10, [x0, #0x38]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x40
               	ldr	x0, [x0]
               	sub	x1, x29, #0x40
               	ldr	x1, [x1, #0x8]
               	add	x0, x0, x1
               	sub	x1, x29, #0x40
               	ldr	x1, [x1, #0x10]
               	add	x0, x0, x1
               	sub	x1, x29, #0x40
               	ldr	x1, [x1, #0x18]
               	add	x0, x0, x1
               	sub	x1, x29, #0x40
               	ldr	x1, [x1, #0x20]
               	add	x0, x0, x1
               	sub	x1, x29, #0x40
               	ldr	x1, [x1, #0x28]
               	add	x0, x0, x1
               	sub	x1, x29, #0x40
               	ldr	x1, [x1, #0x30]
               	add	x0, x0, x1
               	sub	x1, x29, #0x40
               	ldr	x1, [x1, #0x38]
               	add	x0, x0, x1
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret

<build>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x120
               	sub	x16, x29, #0x120
               	str	x8, [x16]
               	add	x1, x0, #0x1
               	add	x2, x0, #0x2
               	add	x3, x0, #0x3
               	add	x4, x0, #0x4
               	add	x5, x0, #0x5
               	add	x6, x0, #0x6
               	add	x7, x0, #0x7
               	add	x1, x0, x1
               	add	x1, x1, x2
               	add	x1, x1, x3
               	add	x1, x1, x4
               	add	x1, x1, x5
               	add	x1, x1, x6
               	add	x1, x1, x7
               	add	x2, x1, #0x1
               	add	x3, x1, #0x2
               	add	x4, x1, #0x3
               	add	x5, x1, #0x4
               	add	x6, x1, #0x5
               	add	x7, x1, #0x6
               	add	x8, x1, #0x7
               	add	x2, x1, x2
               	add	x2, x2, x3
               	add	x2, x2, x4
               	add	x2, x2, x5
               	add	x2, x2, x6
               	add	x2, x2, x7
               	add	x2, x2, x8
               	add	x3, x2, #0x1
               	add	x4, x2, #0x2
               	add	x5, x2, #0x3
               	add	x6, x2, #0x4
               	add	x7, x2, #0x5
               	add	x8, x2, #0x6
               	add	x9, x2, #0x7
               	add	x3, x2, x3
               	add	x3, x3, x4
               	add	x3, x3, x5
               	add	x3, x3, x6
               	add	x3, x3, x7
               	add	x3, x3, x8
               	add	x3, x3, x9
               	sub	x4, x29, #0x118
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x5]
               	str	x10, [x4]
               	ldr	x10, [x5, #0x8]
               	str	x10, [x4, #0x8]
               	ldr	x10, [x5, #0x10]
               	str	x10, [x4, #0x10]
               	ldr	x10, [x5, #0x18]
               	str	x10, [x4, #0x18]
               	ldr	x10, [x5, #0x20]
               	str	x10, [x4, #0x20]
               	ldr	x10, [x5, #0x28]
               	str	x10, [x4, #0x28]
               	ldr	x10, [x5, #0x30]
               	str	x10, [x4, #0x30]
               	ldr	x10, [x5, #0x38]
               	str	x10, [x4, #0x38]
               	ldr	x10, [sp], #0x10
               	sub	x4, x29, #0x118
               	str	x0, [x4]
               	add	x4, x0, #0x1
               	sub	x5, x29, #0x118
               	str	x4, [x5, #0x8]
               	add	x4, x0, #0x2
               	sub	x5, x29, #0x118
               	str	x4, [x5, #0x10]
               	add	x4, x0, #0x3
               	sub	x5, x29, #0x118
               	str	x4, [x5, #0x18]
               	add	x4, x0, #0x4
               	sub	x5, x29, #0x118
               	str	x4, [x5, #0x20]
               	add	x4, x0, #0x5
               	sub	x5, x29, #0x118
               	str	x4, [x5, #0x28]
               	add	x4, x0, #0x6
               	sub	x5, x29, #0x118
               	str	x4, [x5, #0x30]
               	sub	x1, x1, x1
               	add	x0, x0, x1
               	sub	x1, x2, x2
               	add	x0, x0, x1
               	sub	x1, x3, x3
               	add	x0, x0, x1
               	sub	x1, x29, #0x118
               	str	x0, [x1, #0x38]
               	sub	x0, x29, #0x118
               	mov	x16, x0
               	sub	x17, x29, #0x120
               	ldr	x17, [x17]
               	ldr	x0, [x16]
               	str	x0, [x17]
               	ldr	x0, [x16, #0x8]
               	str	x0, [x17, #0x8]
               	ldr	x0, [x16, #0x10]
               	str	x0, [x17, #0x10]
               	ldr	x0, [x16, #0x18]
               	str	x0, [x17, #0x18]
               	ldr	x0, [x16, #0x20]
               	str	x0, [x17, #0x20]
               	ldr	x0, [x16, #0x28]
               	str	x0, [x17, #0x28]
               	ldr	x0, [x16, #0x30]
               	str	x0, [x17, #0x30]
               	ldr	x0, [x16, #0x38]
               	str	x0, [x17, #0x38]
               	mov	x0, x17
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x1f0
               	stp	x20, x21, [sp]
               	str	x19, [sp, #0x10]
               	mov	x20, #0x32              // =50
               	mov	x0, x20
               	bl	<addr>
               	mov	x21, x0
               	mov	x0, x20
               	bl	<addr>
               	cmp	x21, x0
               	cset	x0, eq
               	mov	x1, #0xabcd             // =43981
               	movk	x1, #0x1234, lsl #16
               	stur	x1, [x29, #-0x10]
               	sub	x1, x29, #0x10
               	ldr	x2, [x1]
               	mov	x17, #0xfeed            // =65261
               	eor	x2, x2, x17
               	str	x2, [x1]
               	sxtw	x0, w0
               	mov	x2, #0x0                // =0
               	cbz	x0, <addr>
               	ldur	x0, [x29, #-0x10]
               	mov	x17, #0x5520            // =21792
               	movk	x17, #0x1234, lsl #16
               	cmp	x0, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x2, ne
               	mov	x7, #0x0                // =0
               	mov	x0, x7
               	mov	x1, x7
               	b	<addr>
               	sub	x3, x29, #0x50
               	sxtw	x4, w0
               	add	x5, x4, #0x3e8
               	sxtw	x5, w5
               	str	x5, [x3, x4, lsl #3]
               	add	x3, x0, #0x3e8
               	sxtw	x3, w3
               	add	x1, x1, x3
               	sxtw	x0, w0
               	add	x0, x0, #0x1
               	sxtw	x3, w0
               	cmp	x3, #0x6
               	b.lt	<addr>
               	mov	x3, #0x0                // =0
               	b	<addr>
               	sub	x0, x29, #0x50
               	sxtw	x4, w3
               	ldr	x0, [x0, x4, lsl #3]
               	add	x7, x7, x0
               	sxtw	x0, w3
               	add	x3, x0, #0x1
               	sxtw	x0, w3
               	cmp	x0, #0x6
               	b.lt	<addr>
               	sxtw	x0, w2
               	mov	x20, #0x0               // =0
               	cbz	x0, <addr>
               	cmp	x7, x1
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x20, ne
               	mov	x0, #0x7b               // =123
               	sub	x8, x29, #0x170
               	bl	<addr>
               	sub	x0, x29, #0x170
               	sub	x1, x29, #0x90
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [x0, #0x10]
               	str	x10, [x1, #0x10]
               	ldr	x10, [x0, #0x18]
               	str	x10, [x1, #0x18]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sxtw	x0, w20
               	mov	x2, #0x0                // =0
               	cbz	x0, <addr>
               	sub	x0, x29, #0x90
               	bl	<addr>
               	mov	x17, #0x579e            // =22430
               	cmp	x0, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x2, ne
               	mov	x1, #0x0                // =0
               	cbz	x2, <addr>
               	sub	x0, x29, #0x90
               	ldr	x0, [x0]
               	cmp	x0, #0x7b
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x1, ne
               	mov	x20, #0x0               // =0
               	cbz	x1, <addr>
               	sub	x0, x29, #0x90
               	ldr	x0, [x0, #0x18]
               	cmp	x0, #0x171
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x20, ne
               	mov	x0, #0xa                // =10
               	sub	x8, x29, #0x1c8
               	bl	<addr>
               	sub	x0, x29, #0x1c8
               	sub	x1, x29, #0xf8
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [x0, #0x10]
               	str	x10, [x1, #0x10]
               	ldr	x10, [x0, #0x18]
               	str	x10, [x1, #0x18]
               	ldr	x10, [x0, #0x20]
               	str	x10, [x1, #0x20]
               	ldr	x10, [x0, #0x28]
               	str	x10, [x1, #0x28]
               	ldr	x10, [x0, #0x30]
               	str	x10, [x1, #0x30]
               	ldr	x10, [x0, #0x38]
               	str	x10, [x1, #0x38]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sxtw	x0, w20
               	mov	x2, #0x0                // =0
               	cbz	x0, <addr>
               	sub	x0, x29, #0xf8
               	bl	<addr>
               	cmp	x0, #0x65
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x2, ne
               	sxtw	x0, w2
               	cmp	x0, #0x0
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1f0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1f0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
