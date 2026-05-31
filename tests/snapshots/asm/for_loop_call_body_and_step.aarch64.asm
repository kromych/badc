
for_loop_call_body_and_step.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x4002dc <.text+0xbc>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	sxtw	x15, w0
               	add	x14, x15, #0x1
               	sxtw	x0, w14
               	ret
               	sxtw	x15, w0
               	add	x14, x15, #0x1
               	sxtw	x0, w14
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	mov	x15, #0x0               // =0
               	stur	w15, [x29, #-0x8]
               	stur	w15, [x29, #-0x10]
               	b	0x40027c <.text+0x5c>
               	ldursw	x15, [x29, #-0x10]
               	cmp	x15, #0x7
               	b.ge	0x4002b4 <.text+0x94>
               	b	0x4002a0 <.text+0x80>
               	ldursw	x20, [x29, #-0x10]
               	mov	x0, x20
               	bl	0x400248 <.text+0x28>
               	stur	w0, [x29, #-0x10]
               	b	0x40027c <.text+0x5c>
               	ldursw	x21, [x29, #-0x8]
               	mov	x0, x21
               	bl	0x400238 <.text+0x18>
               	stur	w0, [x29, #-0x8]
               	b	0x40028c <.text+0x6c>
               	ldursw	x0, [x29, #-0x8]
               	mov	x17, #0x6               // =6
               	mul	x21, x0, x17
               	sxtw	x21, w21
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	bl	0x400258 <.text+0x38>
               	ldp	x29, x30, [sp], #0x10
               	ret
