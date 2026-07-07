
kr_old_style_def.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	sxtw	x0, w0
               	sub	x0, x0, x2
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	add	x0, x0, x1
               	ret

<first>:
               	ldrb	w0, [x0]
               	ret

<main>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w0, [x0]
               	cmp	x0, #0x5a
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x2                // =2
               	ret
