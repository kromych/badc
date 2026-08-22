
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
               	asr	x3, x2, #63
               	lsr	x3, x3, #63
               	add	x4, x2, x3
               	mov	x17, #0x1               // =1
               	and	x4, x4, x17
               	sub	x3, x4, x3
               	cbnz	x3, <addr>
               	b	<addr>
               	add	x1, x1, x0
               	sxtw	x1, w1
               	add	x0, x2, #0x1
               	cmp	w0, #0xa
               	b.lt	<addr>
               	sxtw	x0, w1
               	ret
