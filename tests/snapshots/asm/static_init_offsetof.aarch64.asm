
static_init_offsetof.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	adrp	x15, <page>
               	add	x15, x15, #0xd0
               	ldrb	w14, [x15]
               	cmp	x14, #0x0
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	add	x14, x15, #0x1
               	ldrb	w14, [x14]
               	mov	x17, #0x4               // =4
               	eor	x14, x14, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x14, x14, x17
               	cmp	x14, #0x0
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	add	x14, x15, #0x2
               	ldrb	w14, [x14]
               	mov	x17, #0x8               // =8
               	eor	x14, x14, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x14, x14, x17
               	cmp	x14, #0x0
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	add	x14, x15, #0x3
               	ldrb	w14, [x14]
               	mov	x17, #0x10              // =16
               	eor	x14, x14, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x14, x14, x17
               	cmp	x14, #0x0
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	add	x15, x15, #0x4
               	ldrb	w15, [x15]
               	mov	x17, #0x12              // =18
               	eor	x15, x15, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x15, x15, x17
               	cmp	x15, #0x0
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	mov	x15, #0x0               // =0
               	mov	x0, x15
               	ret
