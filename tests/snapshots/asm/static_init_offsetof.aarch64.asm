
static_init_offsetof.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	adrp	x0, <page>
               	add	x0, x0, #0xd0
               	ldrb	w1, [x0]
               	cmp	x1, #0x0
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	add	x1, x0, #0x1
               	ldrb	w1, [x1]
               	mov	x17, #0x4               // =4
               	eor	x1, x1, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x1, x1, x17
               	cmp	x1, #0x0
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	add	x1, x0, #0x2
               	ldrb	w1, [x1]
               	mov	x17, #0x8               // =8
               	eor	x1, x1, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x1, x1, x17
               	cmp	x1, #0x0
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	add	x1, x0, #0x3
               	ldrb	w1, [x1]
               	mov	x17, #0x10              // =16
               	eor	x1, x1, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x1, x1, x17
               	cmp	x1, #0x0
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	add	x0, x0, #0x4
               	ldrb	w0, [x0]
               	mov	x17, #0x12              // =18
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	mov	x0, #0x0                // =0
               	ret
