
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
               	mul	x14, x15, x17
               	sxtw	x14, w14
               	add	x15, x14, #0x1
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
               	and	x12, x13, x17
               	add	x13, x14, x12
               	str	x13, [x15]
               	add	x12, x29, #0x10
               	ldr	x13, [x12]
               	lsr	x15, x13, #1
               	str	x15, [x12]
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
               	b.eq	0x400304 <.text+0xe4>
               	mov	x0, #0x1                // =1
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
               	b.eq	0x40034c <.text+0x12c>
               	mov	x0, #0x2                // =2
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
               	b.eq	0x40037c <.text+0x15c>
               	mov	x0, #0x3                // =3
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0x0               // =0
               	mov	x0, x21
               	bl	0x400254 <.text+0x34>
               	cmp	x0, #0x0
               	b.eq	0x4003a8 <.text+0x188>
               	mov	x0, #0x4                // =4
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0x0               // =0
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
