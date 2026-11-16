
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
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	mov	x0, #0x64               // =100
               	bl	<addr>
               	add	x1, x0, #0x5
               	cmp	w1, #0x69
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
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
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x41c              // =1052
               	bl	<addr>
               	str	x0, [sp, #0x8]
               	mov	x0, #0x502              // =1282
               	bl	<addr>
               	sub	x0, x0, #0x363
               	ldr	x16, [sp, #0x8]
               	add	x1, x16, x0
               	cmp	w1, #0x5bb
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xc8               // =200
               	bl	<addr>
               	and	x0, x0, #0xff
               	add	x0, x0, #0x3c
               	and	x1, x0, #0xff
               	cmp	w1, #0x4
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x20
               	mov	x2, #0x0                // =0
               	mov	x1, #0xa00000000        // =42949672960
               	stur	x1, [x29, #-0x20]
               	mov	x1, #0x14               // =20
               	movk	x1, #0x1e, lsl #32
               	stur	x1, [x29, #-0x18]
               	mov	x1, #0x28               // =40
               	stur	w1, [x29, #-0x10]
               	stur	x0, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	ldrsw	x1, [x0, #0xc]
               	cmp	w1, #0x1e
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, x2
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
