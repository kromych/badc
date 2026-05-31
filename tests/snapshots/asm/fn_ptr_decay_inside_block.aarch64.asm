
fn_ptr_decay_inside_block.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400248 <.text+0x28>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	sxtw	x15, w0
               	add	x14, x15, #0x64
               	sxtw	x0, w14
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xa0
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x24, [sp, #0x20]
               	str	x25, [sp, #0x28]
               	str	x19, [sp, #0x30]
               	mov	x15, #0x0               // =0
               	stur	w15, [x29, #-0x8]
               	mov	x14, #0x1               // =1
               	sxtw	x15, w14
               	cmp	x15, #0x0
               	b.ne	0x4002cc <.text+0xac>
               	mov	x15, #0x1               // =1
               	mov	x0, x15
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x400000
               	add	x19, x19, #0x238
               	mov	x23, x19
               	stur	x23, [x29, #-0x30]
               	b	0x40032c <.text+0x10c>
               	adrp	x19, 0x400000
               	add	x19, x19, #0x238
               	mov	x20, x19
               	sub	x21, x29, #0x8
               	ldrsw	x22, [x21]
               	mov	x23, #0x1               // =1
               	mov	x9, x20
               	str	x23, [sp, #-0x10]!
               	ldr	x0, [sp]
               	blr	x9
               	add	sp, sp, #0x10
               	add	x23, x22, x0
               	str	w23, [x21]
               	sub	x24, x29, #0x8
               	ldrsw	x25, [x24]
               	mov	x23, #0x2               // =2
               	mov	x9, x20
               	str	x23, [sp, #-0x10]!
               	ldr	x0, [sp]
               	blr	x9
               	add	sp, sp, #0x10
               	add	x23, x25, x0
               	str	w23, [x24]
               	b	0x4002b8 <.text+0x98>
               	ldur	x23, [x29, #-0x30]
               	cmp	x23, #0x0
               	b.eq	0x400378 <.text+0x158>
               	b	0x400348 <.text+0x128>
               	mov	x23, #0x0               // =0
               	stur	x23, [x29, #-0x30]
               	b	0x40032c <.text+0x10c>
               	sub	x22, x29, #0x8
               	ldrsw	x23, [x22]
               	mov	x21, #0x3               // =3
               	ldur	x24, [x29, #-0x30]
               	mov	x9, x24
               	str	x21, [sp, #-0x10]!
               	ldr	x0, [sp]
               	blr	x9
               	add	sp, sp, #0x10
               	add	x24, x23, x0
               	str	w24, [x22]
               	b	0x40033c <.text+0x11c>
               	adrp	x19, 0x400000
               	add	x19, x19, #0x238
               	mov	x24, x19
               	stur	x24, [x29, #-0x48]
               	sub	x20, x29, #0x8
               	ldrsw	x25, [x20]
               	sub	x22, x29, #0x48
               	ldr	x24, [x22]
               	mov	x23, #0x4               // =4
               	mov	x9, x24
               	str	x23, [sp, #-0x10]!
               	ldr	x0, [sp]
               	blr	x9
               	add	sp, sp, #0x10
               	add	x23, x25, x0
               	str	w23, [x20]
               	ldursw	x0, [x29, #-0x8]
               	cmp	x0, #0x19a
               	b.ne	0x4003d0 <.text+0x1b0>
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0x60]
               	b	0x4003dc <.text+0x1bc>
               	mov	x0, #0x2                // =2
               	stur	x0, [x29, #-0x60]
               	b	0x4003dc <.text+0x1bc>
               	ldur	x0, [x29, #-0x60]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
