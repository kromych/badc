
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
               	rbit	w0, w0
               	clz	w0, w0
               	add	x1, x0, #0x1
               	lsr	x0, x0, #5
               	sub	x0, x0, #0x1
               	and	x0, x1, x0
               	cmp	w0, #0x11
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x8]
               	ldursw	x1, [x29, #-0x8]
               	rbit	w1, w1
               	clz	w1, w1
               	add	x2, x1, #0x1
               	lsr	x1, x1, #5
               	sub	x1, x1, #0x1
               	and	x1, x2, x1
               	cbz	w1, <addr>
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
