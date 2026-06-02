
static_init_paren_cast_string.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	adrp	x15, <page>
               	add	x15, x15, #0x128
               	ldr	x15, [x15]
               	ldrb	w15, [x15]
               	mov	x17, #0x5               // =5
               	eor	x15, x15, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x15, x15, x17
               	cmp	x15, #0x0
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	adrp	x15, <page>
               	add	x15, x15, #0x128
               	ldr	x15, [x15]
               	add	x15, x15, #0x5
               	ldrb	w15, [x15]
               	mov	x17, #0x1a              // =26
               	eor	x15, x15, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x15, x15, x17
               	cmp	x15, #0x0
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	adrp	x15, <page>
               	add	x15, x15, #0x128
               	add	x15, x15, #0x8
               	ldr	x15, [x15]
               	ldrb	w15, [x15]
               	mov	x17, #0x9               // =9
               	eor	x15, x15, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x15, x15, x17
               	cmp	x15, #0x0
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	adrp	x15, <page>
               	add	x15, x15, #0x128
               	add	x15, x15, #0x8
               	ldr	x15, [x15]
               	add	x15, x15, #0x9
               	ldrb	w15, [x15]
               	mov	x17, #0x4               // =4
               	eor	x15, x15, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x15, x15, x17
               	cmp	x15, #0x0
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	adrp	x15, <page>
               	add	x15, x15, #0x128
               	add	x15, x15, #0x10
               	ldr	x15, [x15]
               	add	x15, x15, #0x9
               	ldrb	w15, [x15]
               	mov	x17, #0x1               // =1
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
