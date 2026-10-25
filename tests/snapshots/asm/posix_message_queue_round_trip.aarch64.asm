
posix_message_queue_round_trip.aarch64:	file format elf64-littleaarch64

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

<round_trip>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x110
               	str	x20, [sp]
               	stur	wzr, [x29, #-0xf8]
               	bl	<addr>
               	mov	x3, x0
               	sub	x0, x29, #0xe0
               	mov	x1, #0x20               // =32
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	bl	<addr>
               	sub	x0, x29, #0x80
               	mov	x1, #0x0                // =0
               	mov	x2, #0x40               // =64
               	bl	<addr>
               	sub	x3, x29, #0x80
               	mov	x0, #0x4                // =4
               	stur	x0, [x29, #-0x78]
               	mov	x0, #0x40               // =64
               	stur	x0, [x29, #-0x70]
               	sub	x0, x29, #0xe0
               	mov	x1, #0xc2               // =194
               	mov	x2, #0x180              // =384
               	bl	<addr>
               	mov	x20, x0
               	mov	x17, #-0x1              // =-1
               	cmp	w20, w17
               	b.ne	<addr>
               	bl	<addr>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x26
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xb                // =11
               	b	<addr>
               	sub	x0, x29, #0xe0
               	bl	<addr>
               	sub	x1, x29, #0x40
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0xc                // =12
               	ldr	x20, [sp]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x38]
               	cmp	x0, #0x4
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x30]
               	cmp	x0, #0x40
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x28]
               	cbz	x0, <addr>
               	mov	x0, #0xd                // =13
               	ldr	x20, [sp]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x4                // =4
               	mov	x3, #0x1                // =1
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x5                // =5
               	mov	x3, #0x7                // =7
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0xe                // =14
               	ldr	x20, [sp]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x40
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	ldur	x0, [x29, #-0x28]
               	cmp	x0, #0x2
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	ldr	x20, [sp]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xc0
               	mov	x2, #0x40               // =64
               	sub	x3, x29, #0xf8
               	mov	x0, x20
               	bl	<addr>
               	cmp	x0, #0x5
               	b.ne	<addr>
               	ldur	w0, [x29, #-0xf8]
               	eor	x0, x0, #0x7
               	cbnz	w0, <addr>
               	sub	x0, x29, #0xc0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x10               // =16
               	ldr	x20, [sp]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0xf0
               	bl	<addr>
               	sub	x4, x29, #0xf0
               	ldur	x0, [x29, #-0xf0]
               	add	x0, x0, #0x5
               	stur	x0, [x29, #-0xf0]
               	sub	x1, x29, #0xc0
               	mov	x2, #0x40               // =64
               	sub	x3, x29, #0xf8
               	mov	x0, x20
               	bl	<addr>
               	cmp	x0, #0x4
               	b.ne	<addr>
               	ldur	w0, [x29, #-0xf8]
               	eor	x0, x0, #0x1
               	cbnz	w0, <addr>
               	sub	x0, x29, #0xc0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x11               // =17
               	ldr	x20, [sp]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x6                // =6
               	mov	x3, #0x3                // =3
               	sub	x4, x29, #0xf0
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x12               // =18
               	ldr	x20, [sp]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xc0
               	mov	x2, #0x40               // =64
               	mov	x3, #0x0                // =0
               	mov	x0, x20
               	bl	<addr>
               	cmp	x0, #0x6
               	b.eq	<addr>
               	mov	x0, #0x13               // =19
               	ldr	x20, [sp]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x80
               	mov	x0, #0x800              // =2048
               	stur	x0, [x29, #-0x80]
               	sub	x2, x29, #0x40
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	ldur	x0, [x29, #-0x40]
               	cbz	x0, <addr>
               	mov	x0, #0x14               // =20
               	ldr	x20, [sp]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xc0
               	mov	x2, #0x40               // =64
               	mov	x3, #0x0                // =0
               	mov	x0, x20
               	bl	<addr>
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	b.ne	<addr>
               	bl	<addr>
               	ldrsw	x0, [x0]
               	cmp	w0, #0xb
               	b.eq	<addr>
               	mov	x0, #0x15               // =21
               	ldr	x20, [sp]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xc0
               	mov	x2, #0x8                // =8
               	mov	x3, #0x0                // =0
               	mov	x0, x20
               	bl	<addr>
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	b.ne	<addr>
               	bl	<addr>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x5a
               	b.eq	<addr>
               	mov	x0, #0x16               // =22
               	ldr	x20, [sp]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x17               // =23
               	ldr	x20, [sp]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	bl	<addr>
               	ldp	x29, x30, [sp], #0x10
               	ret
