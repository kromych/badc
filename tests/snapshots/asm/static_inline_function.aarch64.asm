
static_inline_function.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x4002c4 <.text+0xa4>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	sxtw	x15, w0
               	mov	x17, #0x3               // =3
               	mul	x15, x15, x17
               	sxtw	x15, w15
               	add	x15, x15, #0x1
               	sxtw	x0, w15
               	ret
               	str	x0, [sp, #-0x10]!
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x15, x0
               	stur	x15, [x29, #0x10]
               	mov	x14, #0x0               // =0
               	stur	x14, [x29, #-0x8]
               	b	0x400278 <.text+0x58>
               	ldur	x14, [x29, #0x10]
               	cbz	x14, 0x4002b0 <.text+0x90>
               	sub	x15, x29, #0x8
               	ldr	x14, [x15]
               	ldur	x13, [x29, #0x10]
               	mov	x17, #0x1               // =1
               	and	x13, x13, x17
               	add	x14, x14, x13
               	str	x14, [x15]
               	add	x13, x29, #0x10
               	ldr	x14, [x13]
               	lsr	x14, x14, #1
               	str	x14, [x13]
               	b	0x400278 <.text+0x58>
               	ldur	x0, [x29, #-0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	mov	x20, #0x2               // =2
               	mov	x0, x20
               	bl	0x400238 <.text+0x18>
               	cmp	x0, #0x7
               	b.eq	0x400308 <.text+0xe8>
               	mov	x20, #0x1               // =1
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0xffff            // =65535
               	movk	x21, #0xffff, lsl #16
               	movk	x21, #0xffff, lsl #32
               	movk	x21, #0xffff, lsl #48
               	mov	x0, x21
               	bl	0x400238 <.text+0x18>
               	mov	x17, #0xfffe            // =65534
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	0x400354 <.text+0x134>
               	mov	x21, #0x2               // =2
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0xbeef            // =48879
               	movk	x20, #0xdead, lsl #16
               	mov	x0, x20
               	bl	0x400254 <.text+0x34>
               	cmp	x0, #0x18
               	b.eq	0x400388 <.text+0x168>
               	mov	x20, #0x3               // =3
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0x0               // =0
               	mov	x0, x21
               	bl	0x400254 <.text+0x34>
               	cmp	x0, #0x0
               	b.eq	0x4003b8 <.text+0x198>
               	mov	x21, #0x4               // =4
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
