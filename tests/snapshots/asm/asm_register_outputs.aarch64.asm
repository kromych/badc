
asm_register_outputs.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x20
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	mov	x0, x0
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0, #0x10]
               	str	x1, [sp]
               	str	x0, [sp, #0x8]
               	ldr	x0, [sp]
               	ldr	x1, [sp, #0x8]
               	add	x0, x0, x1
               	cmp	x0, #0x8
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, #0x18]
               	sub	x16, x29, #0x8
               	str	x16, [sp]
               	str	x0, [sp, #0x8]
               	ldr	x2, [sp, #0x8]
               	mov	w0, w2
               	lsr	w1, w2, #1
               	ldr	x16, [sp]
               	str	w1, [x16]
               	mov	w0, w0
               	ldur	w1, [x29, #-0x8]
               	add	x0, x0, x1
               	mov	x17, #0xe81a            // =59418
               	movk	x17, #0x1b4, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, #0x20]
               	and	x1, x0, #0xff
               	mov	w1, w1
               	and	x0, x0, #0xffff
               	mov	w0, w0
               	and	x1, x1, #0xff
               	and	x0, x0, #0xffff
               	add	x0, x1, x0
               	mov	x17, #0x8a56            // =35414
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, #0x28]
               	mov	x0, x0
               	add	x1, x0, #0x1
               	mov	x17, #0x64              // =100
               	mul	x0, x0, x17
               	add	x0, x0, x1
               	mov	x17, #0x1093            // =4243
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0, #0x30]
               	stur	xzr, [x29, #-0x10]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sub	x2, x29, #0x10
               	str	x2, [x0]
               	mov	x1, x1
               	stur	x1, [x29, #-0x10]
               	ldr	x0, [x0]
               	ldr	x0, [x0]
               	add	x0, x0, x1
               	cmp	x0, #0x16
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, #0x38]
               	sub	x16, x29, #0x10
               	str	x16, [sp]
               	str	x0, [sp, #0x8]
               	ldr	x1, [sp, #0x8]
               	mov	x0, x1
               	ldr	x16, [sp]
               	str	x0, [x16]
               	ldur	x0, [x29, #-0x10]
               	cmp	x0, #0x9
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
