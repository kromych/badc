
dead_reads_across_calls.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1

<ext>:
               	mov	x17, #0x3               // =3
               	mul	x0, x0, x17
               	add	x0, x0, #0x1
               	ret

<unread_after_call>:
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x20, x1
               	mul	x0, x0, x2
               	bl	<addr>
               	add	x0, x0, x20
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret

<unread_in_loop>:
               	stp	x20, x21, [sp, #-0x30]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x22, x0
               	mov	x23, x2
               	mov	x20, #0x0               // =0
               	mov	x21, x20
               	cmp	w20, w23
               	b.ge	<addr>
               	add	x0, x22, x20
               	bl	<addr>
               	add	x21, x21, x0
               	add	x20, x20, #0x1
               	cmp	w20, w23
               	b.lt	<addr>
               	add	x0, x21, x22
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret

<six>:
               	stp	x20, x21, [sp, #-0x30]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x20, x0
               	mov	x22, x5
               	mov	x21, x2
               	add	x0, x20, x1
               	add	x0, x0, x21
               	add	x0, x0, x3
               	add	x0, x0, x4
               	add	x0, x0, x22
               	bl	<addr>
               	mov	x23, x0
               	mov	x0, x23
               	bl	<addr>
               	mov	x17, #0x64              // =100
               	mul	x1, x23, x17
               	add	x0, x1, x0
               	add	x0, x0, x20
               	add	x0, x0, x21
               	add	x0, x0, x22
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret

<digit_calls>:
               	stp	x20, x21, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x1, #0x0                // =0
               	cmp	x0, #0x0
               	b.le	<addr>
               	mov	x2, #0x6667             // =26215
               	movk	x2, #0x6666, lsl #16
               	movk	x2, #0x6666, lsl #32
               	movk	x2, #0x6666, lsl #48
               	smulh	x2, x0, x2
               	asr	x2, x2, #2
               	lsr	x3, x2, #63
               	add	x20, x2, x3
               	mov	x17, #0xa               // =10
               	mul	x2, x20, x17
               	sub	x0, x0, x2
               	mov	x17, #0x7               // =7
               	mul	x21, x1, x17
               	bl	<addr>
               	add	x1, x21, x0
               	mov	x0, x20
               	cmp	x0, #0x0
               	b.gt	<addr>
               	mov	x0, x1
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x50]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x24, x25, [sp, #0x20]
               	str	x26, [sp, #0x30]
               	stp	x29, x30, [sp, #0x40]
               	add	x29, sp, #0x40
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x20, [x0]
               	ldr	x21, [x0, #0x8]
               	ldr	x22, [x0, #0x10]
               	ldr	x24, [x0, #0x18]
               	ldr	x25, [x0, #0x20]
               	ldr	x23, [x0, #0x28]
               	mov	x0, x20
               	mov	x2, x22
               	mov	x1, x21
               	bl	<addr>
               	cmp	x0, #0x45
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x26, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	mov	x17, #-0x1              // =-1
               	mul	x0, x20, x17
               	mov	x1, x21
               	mov	x2, x22
               	bl	<addr>
               	mov	x17, #-0x39             // =-57
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x26, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	mov	x2, #0x3                // =3
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	cmp	x0, #0x2a
               	b.ne	<addr>
               	mov	x2, #0x0                // =0
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	cmp	x0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x26, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	add	x0, x20, x21
               	add	x0, x0, x22
               	add	x0, x0, x24
               	add	x0, x0, x25
               	add	x0, x0, x23
               	mov	x17, #0x3               // =3
               	mul	x0, x0, x17
               	add	x26, x0, #0x1
               	mov	x0, x20
               	mov	x5, x23
               	mov	x4, x25
               	mov	x3, x24
               	mov	x2, x22
               	mov	x1, x21
               	bl	<addr>
               	mov	x17, #0x64              // =100
               	mul	x1, x26, x17
               	mov	x17, #0x3               // =3
               	mul	x2, x26, x17
               	add	x2, x2, #0x1
               	add	x1, x1, x2
               	add	x1, x1, x20
               	add	x1, x1, x22
               	add	x1, x1, x23
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x26, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	mov	x20, #0xd89e            // =55454
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, #0x30]
               	bl	<addr>
               	cmp	x0, x20
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x26, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, #0x38]
               	bl	<addr>
               	cmp	x0, #0x4
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x26, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x20, [x0]
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x26, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
