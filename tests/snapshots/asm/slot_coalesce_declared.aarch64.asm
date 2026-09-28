
slot_coalesce_declared.aarch64:	file format elf64-littleaarch64

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

<build>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	stur	x8, [x29, #-0x48]
               	mov	x1, #0xa                // =10
               	sub	x0, x29, #0x40
               	stp	xzr, xzr, [x0]
               	stp	xzr, xzr, [x0, #0x10]
               	stp	xzr, xzr, [x0, #0x20]
               	stp	xzr, xzr, [x0, #0x30]
               	str	x1, [x0]
               	mov	x2, #0xb                // =11
               	str	x2, [x0, #0x8]
               	mov	x2, #0xc                // =12
               	str	x2, [x0, #0x10]
               	mov	x2, #0xd                // =13
               	str	x2, [x0, #0x18]
               	mov	x2, #0xe                // =14
               	str	x2, [x0, #0x20]
               	mov	x2, #0xf                // =15
               	str	x2, [x0, #0x28]
               	mov	x2, #0x10               // =16
               	str	x2, [x0, #0x30]
               	str	x1, [x0, #0x38]
               	mov	x16, x0
               	ldur	x17, [x29, #-0x48]
               	ldp	x0, x1, [x16]
               	stp	x0, x1, [x17]
               	ldp	x0, x1, [x16, #0x10]
               	stp	x0, x1, [x17, #0x10]
               	ldp	x0, x1, [x16, #0x20]
               	stp	x0, x1, [x17, #0x20]
               	ldp	x0, x1, [x16, #0x30]
               	stp	x0, x1, [x17, #0x30]
               	mov	x0, x17
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	str	x20, [sp, #-0x60]!
               	stp	x29, x30, [sp, #0x50]
               	add	x29, sp, #0x50
               	mov	x3, #0x3                // =3
               	mov	x4, #0x9                // =9
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	mul	x2, x0, x3
               	add	x5, x2, #0x7
               	add	x1, x1, x5
               	add	x5, x0, x0
               	add	x5, x5, x0
               	sub	x2, x5, x2
               	add	x2, x1, x2
               	mul	x1, x0, x4
               	sub	x1, x1, x1
               	add	x1, x2, x1
               	add	x0, x0, #0x1
               	cmp	w0, #0x32
               	b.lt	<addr>
               	mov	x3, #0x3                // =3
               	mov	x0, #0x0                // =0
               	mov	x2, x0
               	mul	x4, x0, x3
               	add	x4, x4, #0x7
               	add	x2, x2, x4
               	add	x0, x0, #0x1
               	cmp	w0, #0x32
               	b.lt	<addr>
               	cmp	x1, x2
               	mov	x0, #0xabcd             // =43981
               	movk	x0, #0x1234, lsl #16
               	stur	x0, [x29, #-0x8]
               	sub	x0, x29, #0x8
               	ldr	x2, [x0]
               	mov	x17, #0xfeed            // =65261
               	eor	x2, x2, x17
               	str	x2, [x0]
               	mov	x20, #0x0               // =0
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x8]
               	mov	x17, #0x5520            // =21792
               	movk	x17, #0x1234, lsl #16
               	cmp	x0, x17
               	cset	x0, eq
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	cbz	x0, <addr>
               	mov	x20, #0x1               // =1
               	mov	x0, #0xa                // =10
               	sub	x8, x29, #0x40
               	bl	<addr>
               	sub	x0, x29, #0x40
               	ldr	x1, [x0]
               	ldr	x2, [x0, #0x8]
               	ldr	x3, [x0, #0x10]
               	ldr	x4, [x0, #0x18]
               	ldr	x5, [x0, #0x20]
               	ldr	x6, [x0, #0x28]
               	ldr	x7, [x0, #0x30]
               	ldr	x0, [x0, #0x38]
               	cbz	x20, <addr>
               	add	x1, x1, x2
               	add	x1, x1, x3
               	add	x1, x1, x4
               	add	x1, x1, x5
               	add	x1, x1, x6
               	add	x1, x1, x7
               	add	x0, x1, x0
               	cmp	x0, #0x65
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x20, [sp], #0x60
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x20, [sp], #0x60
               	ret
               	mov	x0, x20
               	b	<addr>
               	mov	x0, x20
               	b	<addr>
               	mov	x0, x20
               	b	<addr>
               	mov	x0, x20
               	b	<addr>
