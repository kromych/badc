
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
               	sub	sp, sp, #0x10
               	mov	x0, #0x7788             // =30600
               	movk	x0, #0x5566, lsl #16
               	movk	x0, #0x3344, lsl #32
               	movk	x0, #0x1122, lsl #48
               	stur	x0, [x29, #-0x10]
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0x8]
               	sub	x1, x29, #0x10
               	ldr	x3, [x1]
               	sub	x2, x29, #0x8
               	str	x3, [x2]
               	ldur	x3, [x29, #-0x8]
               	mov	x17, #0x7788            // =30600
               	movk	x17, #0x5566, lsl #16
               	movk	x17, #0x3344, lsl #32
               	movk	x17, #0x1122, lsl #48
               	cmp	x3, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	x0, [x29, #-0x10]
               	mov	x3, #0xcafe             // =51966
               	movk	x3, #0xbeef, lsl #16
               	movk	x3, #0xdead, lsl #32
               	stur	x3, [x29, #-0x8]
               	ldr	x3, [x2]
               	str	x3, [x1]
               	ldur	x3, [x29, #-0x10]
               	mov	x17, #0xcafe            // =51966
               	movk	x17, #0xbeef, lsl #16
               	movk	x17, #0xdead, lsl #32
               	cmp	x3, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x3, #0x2a               // =42
               	stur	w3, [x29, #-0x10]
               	stur	w0, [x29, #-0x8]
               	ldrsw	x3, [x1]
               	str	w3, [x2]
               	ldursw	x3, [x29, #-0x8]
               	cmp	w3, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	w0, [x29, #-0x10]
               	mov	x3, #0xfff9             // =65529
               	movk	x3, #0xffff, lsl #16
               	movk	x3, #0xffff, lsl #32
               	movk	x3, #0xffff, lsl #48
               	stur	w3, [x29, #-0x8]
               	ldrsw	x3, [x2]
               	str	w3, [x1]
               	ldursw	x3, [x29, #-0x10]
               	mov	x17, #0xfff9            // =65529
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	w3, w17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x3, #0x1000             // =4096
               	stur	x3, [x29, #-0x10]
               	stur	x0, [x29, #-0x8]
               	ldr	x1, [x1]
               	str	x1, [x2]
               	ldur	x1, [x29, #-0x8]
               	mov	x17, #0x1000            // =4096
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
