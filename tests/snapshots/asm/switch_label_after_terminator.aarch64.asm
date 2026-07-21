
switch_label_after_terminator.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	sxtw	x0, w0
               	cmp	x0, #0x2
               	b.lt	<addr>
               	cmp	x0, #0x3
               	b.lt	<addr>
               	cmp	x0, #0x3
               	b.eq	<addr>
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	ret
               	mov	x0, #0x3                // =3
               	add	x0, x0, #0x64
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ret
               	cmp	x0, #0x2
               	b.ne	<addr>
               	mov	x0, #0x2                // =2
               	b	<addr>
               	cmp	x0, #0x1
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	b	<addr>

<main>:
               	mov	x0, #0x1                // =1
               	mov	x0, #0x65               // =101
               	mov	x0, #0x2                // =2
               	mov	x0, #0x66               // =102
               	mov	x0, #0x3                // =3
               	mov	x0, #0x67               // =103
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	mov	x0, #0x0                // =0
               	ret
