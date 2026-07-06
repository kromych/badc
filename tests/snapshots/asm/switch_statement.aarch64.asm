
switch_statement.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x0, #0x2                // =2
               	mov	x2, #0x0                // =0
               	cmp	x0, #0x2
               	b.lt	<addr>
               	b	<addr>
               	sxtw	x0, w0
               	ret
               	mov	x0, #0xa                // =10
               	b	<addr>
               	mov	x2, #0x14               // =20
               	add	x0, x2, #0x5
               	sxtw	x0, w0
               	b	<addr>
               	mov	x0, #0x64               // =100
               	b	<addr>
               	cmp	x0, #0x1
               	b.eq	<addr>
               	b	<addr>
               	cmp	x0, #0x3
               	b.lt	<addr>
               	b	<addr>
               	cmp	x0, #0x2
               	b.eq	<addr>
               	b	<addr>
               	cmp	x0, #0x3
               	b.eq	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
