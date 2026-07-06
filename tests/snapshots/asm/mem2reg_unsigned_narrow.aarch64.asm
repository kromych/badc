
mem2reg_unsigned_narrow.aarch64:	file format elf64-littleaarch64

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
               	mov	x2, x1
               	b	<addr>
               	add	x0, x0, #0x2c
               	mov	x17, #0x2345            // =9029
               	add	x1, x1, x17
               	add	x2, x2, #0x1
               	sxtw	x2, w2
               	sxtw	x3, w2
               	cmp	x3, #0x3
               	b.lt	<addr>
               	mov	x3, #0x0                // =0
               	sxtw	x0, w0
               	cmp	x0, #0x84
               	b.eq	<addr>
               	add	x0, x3, #0x4
               	sxtw	x3, w0
               	sxtw	x0, w1
               	mov	x17, #0x69cf            // =27087
               	cmp	x0, x17
               	b.eq	<addr>
               	add	x0, x3, #0x8
               	sxtw	x3, w0
               	sxtw	x0, w3
               	ret
               	b	<addr>
               	b	<addr>
               	mov	x3, #0x1                // =1
               	b	<addr>
               	add	x2, x3, #0x2
               	sxtw	x3, w2
               	b	<addr>
