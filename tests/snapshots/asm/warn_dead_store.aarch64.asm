
warn_dead_store.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x4002b8 <.text+0x98>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	mov	x0, #0x1                // =1
               	ret
               	mov	x15, #0x5               // =5
               	sxtw	x14, w15
               	add	x15, x14, #0x1
               	sxtw	x15, w15
               	sxtw	x0, w15
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sxtw	x15, w0
               	mov	x14, #0x1               // =1
               	stur	w14, [x29, #-0x8]
               	cbz	x15, 0x400280 <.text+0x60>
               	mov	x13, #0x2               // =2
               	stur	w13, [x29, #-0x8]
               	b	0x400280 <.text+0x60>
               	ldursw	x0, [x29, #-0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x15, #0x1               // =1
               	stur	w15, [x29, #-0x8]
               	sub	x14, x29, #0x8
               	ldrsw	x0, [x14]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	bl	0x400238 <.text+0x18>
               	mov	x20, x0
               	bl	0x400240 <.text+0x20>
               	add	x13, x20, x0
               	sxtw	x21, w13
               	mov	x22, #0x1               // =1
               	mov	x0, x22
               	bl	0x400258 <.text+0x38>
               	add	x22, x21, x0
               	sxtw	x20, w22
               	bl	0x400290 <.text+0x70>
               	add	x21, x20, x0
               	sxtw	x21, w21
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
