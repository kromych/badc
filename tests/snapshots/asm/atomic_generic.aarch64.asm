
atomic_generic.aarch64:	file format elf64-littleaarch64

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
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	mov	x0, #0x7788             // =30600
               	movk	x0, #0x5566, lsl #16
               	movk	x0, #0x3344, lsl #32
               	movk	x0, #0x1122, lsl #48
               	stur	x0, [x29, #-0x30]
               	sub	x0, x29, #0x30
               	ldar	x0, [x0]
               	mov	x17, #0x7788            // =30600
               	movk	x17, #0x5566, lsl #16
               	movk	x17, #0x3344, lsl #32
               	movk	x17, #0x1122, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0x28]
               	mov	x1, #0xcafe             // =51966
               	movk	x1, #0xbeef, lsl #16
               	movk	x1, #0xdead, lsl #32
               	sub	x2, x29, #0x28
               	stlr	x1, [x2]
               	ldur	x1, [x29, #-0x28]
               	mov	x17, #0xcafe            // =51966
               	movk	x17, #0xbeef, lsl #16
               	movk	x17, #0xdead, lsl #32
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x2a               // =42
               	stur	w1, [x29, #-0x20]
               	sub	x1, x29, #0x20
               	ldr	w1, [x1]
               	cmp	w1, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	w0, [x29, #-0x18]
               	sub	x1, x29, #0x18
               	mov	x2, #0xfff9             // =65529
               	movk	x2, #0xffff, lsl #16
               	str	w2, [x1]
               	ldursw	x1, [x29, #-0x18]
               	cmn	w1, #0x7
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x1000             // =4096
               	stur	x1, [x29, #-0x10]
               	sub	x1, x29, #0x10
               	ldapr	x1, [x1]
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
