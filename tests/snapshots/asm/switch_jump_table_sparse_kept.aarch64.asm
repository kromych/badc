
switch_jump_table_sparse_kept.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	sxtw	x0, w0
               	cmp	x0, #0x32
               	b.lt	<addr>
               	cmp	x0, #0x46
               	b.lt	<addr>
               	cmp	x0, #0x50
               	b.lt	<addr>
               	cmp	x0, #0x5a
               	b.lt	<addr>
               	cmp	x0, #0x5a
               	b.eq	<addr>
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	ret
               	mov	x0, #0xa                // =10
               	ret
               	cmp	x0, #0x50
               	b.ne	<addr>
               	mov	x0, #0x9                // =9
               	ret
               	cmp	x0, #0x46
               	b.ne	<addr>
               	mov	x0, #0x8                // =8
               	ret
               	cmp	x0, #0x3c
               	b.lt	<addr>
               	cmp	x0, #0x3c
               	b.ne	<addr>
               	mov	x0, #0x7                // =7
               	ret
               	cmp	x0, #0x32
               	b.ne	<addr>
               	mov	x0, #0x6                // =6
               	ret
               	cmp	x0, #0x14
               	b.lt	<addr>
               	cmp	x0, #0x1e
               	b.lt	<addr>
               	cmp	x0, #0x28
               	b.lt	<addr>
               	cmp	x0, #0x28
               	b.ne	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	cmp	x0, #0x1e
               	b.ne	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	cmp	x0, #0x14
               	b.ne	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	cmp	x0, #0xa
               	b.lt	<addr>
               	cmp	x0, #0xa
               	b.ne	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	b	<addr>

<main>:
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x20, #0x0               // =0
               	b	<addr>
               	mov	x17, #0xa               // =10
               	mul	x0, x20, x17
               	sxtw	x0, w0
               	bl	<addr>
               	add	x1, x20, #0x1
               	sxtw	x1, w1
               	cmp	x0, x1
               	b.ne	<addr>
               	sxtw	x0, w20
               	add	x20, x0, #0x1
               	sxtw	x0, w20
               	cmp	x0, #0xa
               	b.lt	<addr>
               	mov	x0, #0x5                // =5
               	bl	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0xfff6             // =65526
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	bl	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0x64               // =100
               	bl	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	b	<addr>
