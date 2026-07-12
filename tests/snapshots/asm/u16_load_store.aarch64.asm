
u16_load_store.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x2b0              // =688
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	str	x19, [sp, #-0x70]!
               	stp	x29, x30, [sp, #0x60]
               	add	x29, sp, #0x60
               	sub	x0, x29, #0x10
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldrb	w10, [x1, #0x8]
               	strb	w10, [x0, #0x8]
               	ldrb	w10, [x1, #0x9]
               	strb	w10, [x0, #0x9]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x20
               	mov	x1, #0x0                // =0
               	mov	x2, #0xa                // =10
               	bl	<addr>
               	sub	x0, x29, #0x20
               	mov	x1, #0x4241             // =16961
               	strh	w1, [x0, #0x2]
               	sub	x0, x29, #0x20
               	ldrb	w0, [x0]
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x20
               	ldrb	w0, [x0, #0x1]
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x19, [sp], #0x70
               	ret
               	sub	x0, x29, #0x20
               	ldrb	w0, [x0, #0x2]
               	mov	x17, #0x41              // =65
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x20
               	ldrb	w0, [x0, #0x3]
               	mov	x17, #0x42              // =66
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x19, [sp], #0x70
               	ret
               	sub	x0, x29, #0x20
               	ldrb	w0, [x0, #0x4]
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x19, [sp], #0x70
               	ret
               	sub	x0, x29, #0x10
               	add	x0, x0, #0x1
               	ldrh	w0, [x0]
               	mov	x17, #0xffff            // =65535
               	and	x0, x0, x17
               	mov	x17, #0x4342            // =17218
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x19, [sp], #0x70
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x19, [sp], #0x70
               	ret
               	b	<addr>
               	b	<addr>
