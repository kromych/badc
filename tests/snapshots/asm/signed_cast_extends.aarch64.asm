
signed_cast_extends.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	str	x19, [sp, #-0xf0]!
               	stp	x29, x30, [sp, #0xe0]
               	add	x29, sp, #0xe0
               	b	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0xe0]
               	ldr	x19, [sp], #0xf0
               	ret
               	b	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0xe0]
               	ldr	x19, [sp], #0xf0
               	ret
               	b	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0xe0]
               	ldr	x19, [sp], #0xf0
               	ret
               	b	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0xe0]
               	ldr	x19, [sp], #0xf0
               	ret
               	b	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0xe0]
               	ldr	x19, [sp], #0xf0
               	ret
               	b	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0xe0]
               	ldr	x19, [sp], #0xf0
               	ret
               	b	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0xe0]
               	ldr	x19, [sp], #0xf0
               	ret
               	b	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0xe0]
               	ldr	x19, [sp], #0xf0
               	ret
               	b	<addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0xe0]
               	ldr	x19, [sp], #0xf0
               	ret
               	b	<addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp, #0xe0]
               	ldr	x19, [sp], #0xf0
               	ret
               	b	<addr>
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp, #0xe0]
               	ldr	x19, [sp], #0xf0
               	ret
               	sub	x0, x29, #0xb8
               	mov	x1, #0xff               // =255
               	strb	w1, [x0]
               	sub	x0, x29, #0xb8
               	mov	x1, #0x42               // =66
               	strb	w1, [x0, #0x1]
               	sub	x0, x29, #0xb8
               	mov	x1, #0x10               // =16
               	strb	w1, [x0, #0x2]
               	sub	x0, x29, #0xb8
               	ldrb	w0, [x0]
               	sxtb	x0, w0
               	sxtw	x0, w0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	ldp	x29, x30, [sp, #0xe0]
               	ldr	x19, [sp], #0xf0
               	ret
               	sub	x0, x29, #0xb8
               	ldrb	w0, [x0]
               	sxtb	x0, w0
               	lsl	x0, x0, #8
               	sub	x1, x29, #0xb8
               	ldrb	w1, [x1, #0x1]
               	orr	x0, x0, x1
               	sxtw	x0, w0
               	mov	x17, #0xff42            // =65346
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	ldp	x29, x30, [sp, #0xe0]
               	ldr	x19, [sp], #0xf0
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0xe0]
               	ldr	x19, [sp], #0xf0
               	ret
