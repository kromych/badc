
statvfs_layout_and_call.aarch64:	file format elf64-littleaarch64

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
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xf0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sub	x1, x29, #0xe0
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0xe0]
               	cbz	x0, <addr>
               	ldur	x0, [x29, #-0xd8]
               	cbz	x0, <addr>
               	ldur	x0, [x29, #-0xd0]
               	cbz	x0, <addr>
               	ldur	x1, [x29, #-0x90]
               	cbnz	x1, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x1, [x29, #-0xc8]
               	cmp	x1, x0
               	b.hi	<addr>
               	ldur	x1, [x29, #-0xc0]
               	cmp	x1, x0
               	b.hi	<addr>
               	ldur	x0, [x29, #-0xb0]
               	ldur	x1, [x29, #-0xb8]
               	cmp	x0, x1
               	b.ls	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	cmp	w0, #0x0
               	b.ge	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x70
               	str	x0, [sp]
               	bl	<addr>
               	str	x0, [sp, #0x8]
               	ldr	x0, [sp]
               	bl	<addr>
               	ldr	x16, [sp, #0x8]
               	cbnz	w16, <addr>
               	ldur	x0, [x29, #-0x68]
               	ldur	x1, [x29, #-0xd8]
               	cmp	x0, x1
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x60]
               	ldur	x1, [x29, #-0xd0]
               	cmp	x0, x1
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x30]
               	ldur	x1, [x29, #-0xa0]
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
