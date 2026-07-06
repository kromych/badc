
for_init_multiple_declarators.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x2, #0x0                // =0
               	mov	x0, x2
               	b	<addr>
               	sxtw	x0, w0
               	add	x0, x0, #0x1
               	sxtw	x1, w2
               	add	x2, x1, #0x1
               	sxtw	x1, w2
               	cmp	x1, #0x3
               	b.lt	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x2, #0x0                // =0
               	mov	x0, x2
               	b	<addr>
               	add	x0, x0, #0x2
               	sxtw	x1, w2
               	add	x2, x1, #0x1
               	sxtw	x1, w2
               	cmp	x1, #0x4
               	b.lt	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x8
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	mov	x2, #0x1                // =1
               	mov	x0, x2
               	b	<addr>
               	mul	x0, x0, x2
               	add	x2, x2, #0x1
               	cmp	x2, #0x5
               	b.le	<addr>
               	cmp	x0, #0x78
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	mov	x3, #0x0                // =0
               	mov	x2, #0x2                // =2
               	b	<addr>
               	sxtw	x0, w3
               	add	x3, x0, #0x1
               	sxtw	x0, w2
               	add	x2, x0, #0x1
               	sxtw	x0, w2
               	cmp	x0, #0x5
               	b.lt	<addr>
               	sxtw	x0, w3
               	cmp	x0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	mov	x0, #0x0                // =0
               	ret
