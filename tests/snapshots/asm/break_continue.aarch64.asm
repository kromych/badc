
break_continue.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	sxtw	x2, w0
               	cmp	x2, #0xa
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x0, w0
               	add	x0, x0, #0x1
               	b	<addr>
               	sxtw	x2, w0
               	cmp	x2, #0x5
               	b.ne	<addr>
               	b	<addr>
               	sxtw	x0, w1
               	ret
               	b	<addr>
               	sxtw	x2, w0
               	asr	x3, x2, #63
               	lsr	x3, x3, #63
               	add	x2, x2, x3
               	mov	x17, #0x1               // =1
               	and	x2, x2, x17
               	sub	x2, x2, x3
               	cmp	x2, #0x0
               	b.ne	<addr>
               	b	<addr>
               	add	x1, x1, x0
               	sxtw	x1, w1
               	b	<addr>
