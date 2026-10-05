
builtin_ffs.aarch64:	file format elf64-littleaarch64

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
               	mov	x0, #0xff0000           // =16711680
               	stur	w0, [x29, #-0x10]
               	ldursw	x0, [x29, #-0x10]
               	rbit	w1, w0
               	clz	w1, w1
               	mov	x0, #0x0                // =0
               	cmp	w1, #0x20
               	csinc	w1, w0, w1, eq
               	cmp	w1, #0x11
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	w0, [x29, #-0x8]
               	ldursw	x1, [x29, #-0x8]
               	rbit	w1, w1
               	clz	w1, w1
               	cmp	w1, #0x20
               	csinc	w1, w0, w1, eq
               	cbz	w1, <addr>
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
