
posix_message_queue_round_trip.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<_start>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1

<main>:
               	stp	x20, x21, [sp, #-0x120]!
               	stp	x29, x30, [sp, #0x110]
               	add	x29, sp, #0x110
               	mov	x20, #0x0               // =0
               	stur	w20, [x29, #-0xf8]
               	stur	x20, [x29, #-0x80]
               	stur	x20, [x29, #-0x68]
               	stur	x20, [x29, #-0x60]
               	stur	x20, [x29, #-0x58]
               	stur	x20, [x29, #-0x50]
               	stur	x20, [x29, #-0x48]
               	mov	x0, #0x4                // =4
               	stur	x0, [x29, #-0x78]
               	mov	x0, #0x40               // =64
               	stur	x0, [x29, #-0x70]
               	b	<addr>
               	bl	<addr>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x11
               	b.ne	<addr>
               	cmp	w20, #0x3e8
               	b.eq	<addr>
               	add	x20, x20, #0x1
               	bl	<addr>
               	mov	x3, x0
               	mov	x4, x20
               	sub	x0, x29, #0xe0
               	mov	x1, #0x20               // =32
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	bl	<addr>
               	sub	x0, x29, #0xe0
               	mov	x1, #0xc2               // =194
               	mov	x2, #0x180              // =384
               	sub	x3, x29, #0x80
               	bl	<addr>
               	mov	x21, x0
               	cmn	w21, #0x1
               	b.eq	<addr>
               	cmn	w21, #0x1
               	b.ne	<addr>
               	bl	<addr>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x26
               	mov	x17, #0xb               // =11
               	csel	x0, xzr, x17, eq
               	ldp	x29, x30, [sp, #0x110]
               	ldp	x20, x21, [sp], #0x120
               	ret
               	sub	x0, x29, #0xe0
               	bl	<addr>
               	mov	x0, x21
               	sub	x1, x29, #0x40
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0xc                // =12
               	b	<addr>
               	ldur	x0, [x29, #-0x38]
               	cmp	x0, #0x4
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x30]
               	cmp	x0, #0x40
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x28]
               	cbz	x0, <addr>
               	mov	x0, #0xd                // =13
               	b	<addr>
               	mov	x0, x21
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x4                // =4
               	mov	x3, #0x1                // =1
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, x21
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x5                // =5
               	mov	x3, #0x7                // =7
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0xe                // =14
               	b	<addr>
               	mov	x0, x21
               	sub	x1, x29, #0x40
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	ldur	x0, [x29, #-0x28]
               	cmp	x0, #0x2
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	b	<addr>
               	mov	x0, x21
               	sub	x1, x29, #0xc0
               	mov	x2, #0x40               // =64
               	sub	x3, x29, #0xf8
               	bl	<addr>
               	cmp	x0, #0x5
               	b.ne	<addr>
               	ldur	w0, [x29, #-0xf8]
               	cmp	w0, #0x7
               	b.ne	<addr>
               	sub	x0, x29, #0xc0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x10               // =16
               	b	<addr>
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0xf0
               	bl	<addr>
               	ldur	x0, [x29, #-0xf0]
               	add	x0, x0, #0x5
               	stur	x0, [x29, #-0xf0]
               	mov	x0, x21
               	sub	x1, x29, #0xc0
               	mov	x2, #0x40               // =64
               	sub	x3, x29, #0xf8
               	sub	x4, x29, #0xf0
               	bl	<addr>
               	cmp	x0, #0x4
               	b.ne	<addr>
               	ldur	w0, [x29, #-0xf8]
               	cmp	w0, #0x1
               	b.ne	<addr>
               	sub	x0, x29, #0xc0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x11               // =17
               	b	<addr>
               	mov	x0, x21
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x6                // =6
               	mov	x3, #0x3                // =3
               	sub	x4, x29, #0xf0
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x12               // =18
               	b	<addr>
               	mov	x0, x21
               	sub	x1, x29, #0xc0
               	mov	x2, #0x40               // =64
               	mov	x3, #0x0                // =0
               	bl	<addr>
               	cmp	x0, #0x6
               	b.eq	<addr>
               	mov	x0, #0x13               // =19
               	b	<addr>
               	mov	x0, #0x800              // =2048
               	stur	x0, [x29, #-0x80]
               	mov	x0, x21
               	sub	x1, x29, #0x80
               	sub	x2, x29, #0x40
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	ldur	x0, [x29, #-0x40]
               	cbz	x0, <addr>
               	mov	x0, #0x14               // =20
               	b	<addr>
               	mov	x0, x21
               	sub	x1, x29, #0xc0
               	mov	x2, #0x40               // =64
               	mov	x3, #0x0                // =0
               	bl	<addr>
               	cmn	x0, #0x1
               	b.ne	<addr>
               	bl	<addr>
               	ldrsw	x0, [x0]
               	cmp	w0, #0xb
               	b.eq	<addr>
               	mov	x0, #0x15               // =21
               	b	<addr>
               	mov	x0, x21
               	sub	x1, x29, #0xc0
               	mov	x2, #0x8                // =8
               	mov	x3, #0x0                // =0
               	bl	<addr>
               	cmn	x0, #0x1
               	b.ne	<addr>
               	bl	<addr>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x5a
               	b.eq	<addr>
               	mov	x0, #0x16               // =22
               	b	<addr>
               	mov	x0, x21
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	mov	x16, #0x17              // =23
               	csel	x0, x16, xzr, ne
               	b	<addr>
