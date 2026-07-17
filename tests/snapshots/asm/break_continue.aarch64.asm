
break_continue.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	b	<addr>
               	cmp	x2, #0x5
               	b.eq	<addr>
               	asr	x3, x2, #63
               	lsr	x3, x3, #63
               	add	x4, x2, x3
               	mov	x17, #0x1               // =1
               	and	x4, x4, x17
               	sub	x3, x4, x3
               	cmp	x3, #0x0
               	b.ne	<addr>
               	b	<addr>
               	add	x0, x0, x1
               	sxtw	x0, w0
               	add	x1, x2, #0x1
               	sxtw	x2, w1
               	cmp	x2, #0xa
               	b.lt	<addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ret
               	b	<addr>
