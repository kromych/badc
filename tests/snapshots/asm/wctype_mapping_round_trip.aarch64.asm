
wctype_mapping_round_trip.aarch64:	file format elf64-littleaarch64

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

<main>:
               	stp	x20, x21, [sp, #-0xd0]!
               	stp	x22, x23, [sp, #0x10]
               	str	x24, [sp, #0x20]
               	stp	x29, x30, [sp, #0xc0]
               	add	x29, sp, #0xc0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x21, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x22, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x20, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x23, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x24, x0
               	stur	wzr, [x29, #-0x90]
               	cbz	x21, <addr>
               	cbz	x22, <addr>
               	cbz	x20, <addr>
               	cbz	x23, <addr>
               	cbnz	x24, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0xc0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xd0
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0xc0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xd0
               	ret
               	mov	x0, #0x61               // =97
               	mov	x1, x21
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x31               // =49
               	mov	x1, x21
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0xc0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xd0
               	ret
               	mov	x0, #0x37               // =55
               	mov	x1, x22
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x78               // =120
               	mov	x1, x22
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0xc0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xd0
               	ret
               	mov	x0, #0x20               // =32
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x9                // =9
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0xa                // =10
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0xc0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xd0
               	ret
               	mov	x0, #0x20               // =32
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x61               // =97
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0xc0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xd0
               	ret
               	mov	x0, #0x71               // =113
               	mov	x1, x23
               	bl	<addr>
               	mov	x17, #0x51              // =81
               	eor	x0, x0, x17
               	cbnz	w0, <addr>
               	mov	x0, #0x51               // =81
               	mov	x1, x24
               	bl	<addr>
               	mov	x17, #0x71              // =113
               	eor	x0, x0, x17
               	cbnz	w0, <addr>
               	mov	x0, #0x35               // =53
               	mov	x1, x23
               	bl	<addr>
               	mov	x17, #0x35              // =53
               	eor	x0, x0, x17
               	cbz	w0, <addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0xc0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xd0
               	ret
               	mov	x0, #0x7a               // =122
               	bl	<addr>
               	mov	x17, #0x7a              // =122
               	eor	x0, x0, x17
               	cbnz	w0, <addr>
               	mov	x0, #0x7a               // =122
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x7a
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0xc0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xd0
               	ret
               	sub	x0, x29, #0x80
               	mov	x1, #0x0                // =0
               	mov	x2, #0x80               // =128
               	bl	<addr>
               	sub	x0, x29, #0x90
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x1                // =1
               	sub	x3, x29, #0x80
               	bl	<addr>
               	cmp	x0, #0x1
               	b.ne	<addr>
               	ldur	w0, [x29, #-0x90]
               	cmp	w0, #0x6b
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0xc0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xd0
               	ret
               	sub	x0, x29, #0x80
               	mov	x1, #0x0                // =0
               	mov	x2, #0x80               // =128
               	bl	<addr>
               	sub	x0, x29, #0x88
               	mov	x1, #0x6b               // =107
               	sub	x2, x29, #0x80
               	bl	<addr>
               	cmp	x0, #0x1
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x88]
               	mov	x17, #0x6b              // =107
               	eor	x0, x0, x17
               	cbz	w0, <addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp, #0xc0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xd0
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0xc0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xd0
               	ret
