
switch_default_routing.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400238 <.text+0x18>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x15, #0x63              // =99
               	mov	x14, #0x0               // =0
               	stur	w14, [x29, #-0x10]
               	sxtw	x13, w15
               	b	0x40028c <.text+0x6c>
               	ldursw	x0, [x29, #-0x10]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x15, #0xa               // =10
               	stur	w15, [x29, #-0x10]
               	b	0x400258 <.text+0x38>
               	mov	x15, #0x14              // =20
               	stur	w15, [x29, #-0x10]
               	b	0x400258 <.text+0x38>
               	mov	x15, #0x64              // =100
               	stur	w15, [x29, #-0x10]
               	b	0x400258 <.text+0x38>
               	cmp	x13, #0x1
               	b.eq	0x400268 <.text+0x48>
               	cmp	x13, #0x2
               	b.eq	0x400274 <.text+0x54>
               	b	0x400280 <.text+0x60>
