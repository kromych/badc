
kr_old_style_def.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	sxtw	x0, w0
               	sub	x0, x0, x2
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	add	x0, x0, x1
               	ret
               	ldrb	w0, [x0]
               	ret
               	mov	x0, #0x1                // =1
               	mov	x1, #0x0                // =0
               	sub	x0, x0, x0
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	add	x0, x0, x1
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0xa                // =10
               	mov	x1, #0x5                // =5
               	mov	x2, #0x3                // =3
               	sub	x0, x0, x2
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	add	x0, x0, x1
               	cmp	x0, #0xc
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0xd0
               	ldrb	w0, [x0]
               	cmp	x0, #0x5a
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	mov	x0, #0x0                // =0
               	ret
