
builtin_parity.aarch64:	file format elf64-littleaarch64

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
               	mov	x0, #0x1234             // =4660
               	stur	w0, [x29, #-0x8]
               	ldur	w0, [x29, #-0x8]
               	fmov	s16, w0
               	cnt	v16.8b, v16.8b
               	addv	b16, v16.8b
               	fmov	w0, s16
               	and	x0, x0, #0x1
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xf0f0             // =61680
               	stur	x0, [x29, #-0x10]
               	ldur	x0, [x29, #-0x10]
               	fmov	d16, x0
               	cnt	v16.8b, v16.8b
               	addv	b16, v16.8b
               	fmov	w0, s16
               	tbz	w0, #0x0, <addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
