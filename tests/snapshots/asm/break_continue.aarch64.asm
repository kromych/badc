
break_continue.aarch64:	file format elf64-littleaarch64

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
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	b	<addr>
               	cmp	w0, #0x5
               	b.eq	<addr>
               	sxtw	x2, w0
               	lsr	x3, x2, #63
               	add	x2, x2, x3
               	and	x2, x2, #0x1
               	sub	x2, x2, x3
               	cbnz	x2, <addr>
               	b	<addr>
               	add	x1, x1, x0
               	add	x0, x0, #0x1
               	cmp	w0, #0xa
               	b.lt	<addr>
               	sxtw	x0, w1
               	ret
