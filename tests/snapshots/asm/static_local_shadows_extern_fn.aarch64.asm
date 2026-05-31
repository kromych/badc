
static_local_shadows_extern_fn.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x4002e0 <.text+0xc0>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	mov	x15, x0
               	ldrb	w14, [x15]
               	add	x13, x15, #0x1
               	ldrb	w15, [x13]
               	add	x13, x14, x15
               	sxtw	x0, w13
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	sxtw	x15, w0
               	mov	x14, #0x0               // =0
               	stur	w14, [x29, #-0x8]
               	b	0x4002cc <.text+0xac>
               	ldursw	x14, [x29, #-0x8]
               	mov	x0, x14
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0xd0
               	mov	x20, x19
               	mov	x0, x20
               	bl	0x400238 <.text+0x18>
               	mov	x14, x0
               	stur	w14, [x29, #-0x8]
               	b	0x400278 <.text+0x58>
               	mov	x14, #0xffff            // =65535
               	movk	x14, #0xffff, lsl #16
               	movk	x14, #0xffff, lsl #32
               	movk	x14, #0xffff, lsl #48
               	stur	w14, [x29, #-0x8]
               	b	0x400278 <.text+0x58>
               	cmp	x15, #0x1
               	b.eq	0x400294 <.text+0x74>
               	cmp	x15, #0x2
               	b.eq	0x4002b4 <.text+0x94>
               	b	0x400278 <.text+0x58>
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	str	x20, [sp]
               	mov	x20, #0x1               // =1
               	mov	x0, x20
               	bl	0x400254 <.text+0x34>
               	mov	x14, x0
               	mov	x0, x14
               	ldr	x20, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
