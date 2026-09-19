
has_builtin_clrsb.aarch64:	file format elf64-littleaarch64

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
               	mov	x0, #0xff               // =255
               	stur	w0, [x29, #-0x8]
               	mov	x0, #-0x400             // =-1024
               	stur	x0, [x29, #-0x10]
               	ldursw	x0, [x29, #-0x8]
               	lsl	x1, x0, #1
               	eor	x0, x0, x1
               	orr	x0, x0, #0x1
               	clz	w0, w0
               	cmp	w0, #0x17
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x10]
               	lsl	x1, x0, #1
               	eor	x0, x0, x1
               	orr	x0, x0, #0x1
               	clz	x0, x0
               	cmp	w0, #0x35
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
