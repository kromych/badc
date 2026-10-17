
string_literal_initializes_every_character_array.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1

<literals>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	sub	x0, x29, #0x38
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldrb	w16, [x1, #0x10]
               	strb	w16, [x0, #0x10]
               	sub	x1, x29, #0x20
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldrb	w16, [x2, #0x10]
               	strb	w16, [x1, #0x10]
               	sub	x1, x29, #0x60
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	w16, [x2]
               	str	w16, [x1]
               	sub	x1, x29, #0x58
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	w16, [x2]
               	str	w16, [x1]
               	sub	x1, x29, #0x50
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrb	w16, [x2]
               	strb	w16, [x1]
               	sub	x1, x29, #0x48
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrh	w16, [x2]
               	strh	w16, [x1]
               	sub	x1, x29, #0x40
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x16, [x2]
               	str	x16, [x1]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sub	x0, x29, #0x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldurb	w0, [x29, #-0x5e]
               	mov	x17, #0x7a              // =122
               	eor	x0, x0, x17
               	cbnz	w0, <addr>
               	ldurb	w0, [x29, #-0x56]
               	mov	x17, #0x7a              // =122
               	eor	x0, x0, x17
               	cbnz	w0, <addr>
               	ldurb	w0, [x29, #-0x50]
               	mov	x17, #0x62              // =98
               	eor	x0, x0, x17
               	cbnz	w0, <addr>
               	ldurb	w0, [x29, #-0x47]
               	mov	x17, #0x63              // =99
               	eor	x0, x0, x17
               	cbnz	w0, <addr>
               	ldurb	w0, [x29, #-0x3b]
               	mov	x17, #0x64              // =100
               	eor	x0, x0, x17
               	cbz	w0, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret

<members>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w1, [x0, #0x3]
               	mov	x17, #0x5               // =5
               	eor	x1, x1, x17
               	cbnz	w1, <addr>
               	ldrsw	x0, [x0, #0x8]
               	cbz	w0, <addr>
               	mov	x0, #0x7                // =7
               	ret
               	mov	x0, #0x0                // =0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x71               // =113
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x71               // =113
               	bl	<addr>
               	b	<addr>
