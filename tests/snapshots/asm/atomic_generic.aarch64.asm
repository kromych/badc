
atomic_generic.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x30
               	mov	x0, #0x7788             // =30600
               	movk	x0, #0x5566, lsl #16
               	movk	x0, #0x3344, lsl #32
               	movk	x0, #0x1122, lsl #48
               	stur	x0, [x29, #-0x28]
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0x30]
               	sub	x1, x29, #0x28
               	ldar	x2, [x1]
               	sub	x1, x29, #0x30
               	str	x2, [x1]
               	ldur	x2, [x29, #-0x30]
               	mov	x17, #0x7788            // =30600
               	movk	x17, #0x5566, lsl #16
               	movk	x17, #0x3344, lsl #32
               	movk	x17, #0x1122, lsl #48
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	x0, [x29, #-0x20]
               	mov	x2, #0xcafe             // =51966
               	movk	x2, #0xbeef, lsl #16
               	movk	x2, #0xdead, lsl #32
               	stur	x2, [x29, #-0x30]
               	sub	x2, x29, #0x20
               	ldr	x3, [x1]
               	stlr	x3, [x2]
               	ldur	x2, [x29, #-0x20]
               	mov	x17, #0xcafe            // =51966
               	movk	x17, #0xbeef, lsl #16
               	movk	x17, #0xdead, lsl #32
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x2a               // =42
               	stur	w2, [x29, #-0x18]
               	stur	w0, [x29, #-0x30]
               	sub	x2, x29, #0x18
               	ldr	w2, [x2]
               	str	w2, [x1]
               	ldursw	x2, [x29, #-0x30]
               	cmp	w2, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	w0, [x29, #-0x10]
               	mov	x2, #-0x7               // =-7
               	stur	w2, [x29, #-0x30]
               	sub	x2, x29, #0x10
               	ldr	w3, [x1]
               	str	w3, [x2]
               	ldursw	x2, [x29, #-0x10]
               	mov	x17, #-0x7              // =-7
               	cmp	w2, w17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x1000             // =4096
               	stur	x2, [x29, #-0x8]
               	stur	x0, [x29, #-0x30]
               	sub	x2, x29, #0x8
               	ldar	x2, [x2]
               	str	x2, [x1]
               	ldur	x1, [x29, #-0x30]
               	mov	x17, #0x1000            // =4096
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
