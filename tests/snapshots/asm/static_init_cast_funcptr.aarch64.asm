
static_init_cast_funcptr.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x2c0              // =704
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	lsl	x0, x0, #1
               	sxtw	x0, w0
               	ret

<real_negate>:
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	mul	x0, x0, x17
               	sxtw	x0, w0
               	ret

<main>:
               	str	x20, [sp, #-0x30]!
               	str	x19, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	ldr	x0, [x20, #0x8]
               	mov	x1, #0x15               // =21
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	sxtw	x0, w0
               	cmp	x0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	ldr	x0, [x20, #0x20]
               	mov	x1, #0x7                // =7
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	sxtw	x0, w0
               	mov	x17, #0xfff9            // =65529
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	ldr	x0, [x20, #0x10]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	sxtw	x0, w0
               	cmp	x0, #0x64
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	ldr	x0, [x20, #0x28]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	sxtw	x0, w0
               	mov	x17, #0xffef            // =65519
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	ldr	x0, [x20]
               	ldrb	w0, [x0]
               	mov	x17, #0x64              // =100
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	ldr	x0, [x20, #0x18]
               	ldrb	w0, [x0]
               	mov	x17, #0x6e              // =110
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret

<__c5_sys_atoi>:
               	str	x0, [sp, #-0x10]!
               	str	x19, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	ldur	x0, [x29, #0x10]
               	bl	<addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	add	sp, sp, #0x10
               	ret
