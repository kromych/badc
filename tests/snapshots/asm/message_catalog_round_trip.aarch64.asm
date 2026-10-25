
message_catalog_round_trip.aarch64:	file format elf64-littleaarch64

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
               	stp	x20, x21, [sp, #-0x180]!
               	stp	x29, x30, [sp, #0x170]
               	add	x29, sp, #0x170
               	sub	x0, x29, #0x158
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldr	w16, [x1, #0x10]
               	str	w16, [x0, #0x10]
               	ldrh	w16, [x1, #0x14]
               	strh	w16, [x0, #0x14]
               	ldrb	w16, [x1, #0x16]
               	strb	w16, [x0, #0x16]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x170]
               	ldp	x20, x21, [sp], #0x180
               	ret
               	sub	x0, x29, #0x158
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x170]
               	ldp	x20, x21, [sp], #0x180
               	ret
               	sub	x0, x29, #0x140
               	mov	x1, #0x40               // =64
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	sub	x3, x29, #0x158
               	bl	<addr>
               	sub	x0, x29, #0x100
               	mov	x1, #0x40               // =64
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	sub	x3, x29, #0x158
               	bl	<addr>
               	sub	x0, x29, #0x140
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	mov	x20, x0
               	cbnz	x20, <addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x170]
               	ldp	x20, x21, [sp], #0x180
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, x20
               	bl	<addr>
               	mov	x0, x20
               	bl	<addr>
               	sub	x0, x29, #0xc0
               	mov	x1, #0xc0               // =192
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	sub	x3, x29, #0x100
               	sub	x4, x29, #0x140
               	bl	<addr>
               	sub	x0, x29, #0xc0
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x20, #0x4               // =4
               	sub	x0, x29, #0x100
               	bl	<addr>
               	sub	x0, x29, #0x140
               	bl	<addr>
               	sub	x0, x29, #0x158
               	bl	<addr>
               	mov	x0, x20
               	ldp	x29, x30, [sp, #0x170]
               	ldp	x20, x21, [sp], #0x180
               	ret
               	sub	x0, x29, #0x100
               	mov	x1, #0x1                // =1
               	bl	<addr>
               	mov	x21, x0
               	mov	x17, #-0x1              // =-1
               	cmp	x21, x17
               	b.ne	<addr>
               	mov	x20, #0x5               // =5
               	b	<addr>
               	mov	x1, #0x1                // =1
               	mov	x2, #0x2                // =2
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x0, x21
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x20, #0x6               // =6
               	mov	x1, #0x7                // =7
               	mov	x2, #0x3                // =3
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x0, x21
               	bl	<addr>
               	cbnz	w20, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x20, #0x7               // =7
               	mov	x1, #0x1                // =1
               	mov	x2, #0x9                // =9
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x0, x21
               	bl	<addr>
               	cbnz	w20, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x20, #0x8               // =8
               	mov	x0, x21
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	cbnz	w20, <addr>
               	mov	x20, #0x9               // =9
               	b	<addr>
               	mov	x20, #0x0               // =0
               	b	<addr>
