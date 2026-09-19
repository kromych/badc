
unsigned_compound_assign.aarch64:	file format elf64-littleaarch64

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

<rtu>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	stur	w0, [x29, #-0x8]
               	ldur	w0, [x29, #-0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<rtul>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x0, #0x3e8              // =1000
               	stur	x0, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	str	x20, [sp, #-0x40]!
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	mov	x0, #0x64               // =100
               	bl	<addr>
               	add	x0, x0, #0x5
               	mov	x17, #0x69              // =105
               	eor	x1, x0, x17
               	cbz	w1, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	w0, w0
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	bl	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	mov	x0, #0x3e8              // =1000
               	bl	<addr>
               	add	x1, x0, #0x19f
               	cmp	x1, #0x587
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	mov	x0, #0x41c              // =1052
               	bl	<addr>
               	mov	x20, x0
               	mov	x0, #0x502              // =1282
               	bl	<addr>
               	sub	x0, x0, #0x363
               	add	x0, x20, x0
               	mov	x17, #0x5bb             // =1467
               	eor	x1, x0, x17
               	cbz	w1, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	w0, w0
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	bl	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	mov	x0, #0xc8               // =200
               	bl	<addr>
               	and	x0, x0, #0xff
               	add	x0, x0, #0x3c
               	and	x1, x0, #0xff
               	eor	x0, x1, #0x4
               	cbz	w0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	sub	x0, x29, #0x18
               	mov	x1, #0x0                // =0
               	str	w1, [x0]
               	mov	x2, #0xa                // =10
               	str	w2, [x0, #0x4]
               	mov	x2, #0x14               // =20
               	str	w2, [x0, #0x8]
               	mov	x2, #0x1e               // =30
               	str	w2, [x0, #0xc]
               	mov	x2, #0x28               // =40
               	str	w2, [x0, #0x10]
               	stur	x0, [x29, #-0x20]
               	ldur	x0, [x29, #-0x20]
               	ldrsw	x2, [x0, #0xc]
               	cmp	w2, #0x1e
               	b.eq	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x0, [x0, #0xc]
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	bl	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	mov	x0, x1
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
