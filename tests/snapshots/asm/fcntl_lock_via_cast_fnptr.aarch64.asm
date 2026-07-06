
fcntl_lock_via_cast_fnptr.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x4d0              // =1232
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x20, x21, [sp, #-0x150]!
               	stp	x22, x23, [sp, #0x10]
               	str	x24, [sp, #0x20]
               	str	x19, [sp, #0x30]
               	stp	x29, x30, [sp, #0x140]
               	add	x29, sp, #0x140
               	sub	x20, x29, #0x40
               	mov	x21, #0x40              // =64
               	adrp	x22, <page>
               	add	x22, x22, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x3, x0
               	mov	x0, x20
               	mov	x2, x22
               	mov	x1, x21
               	bl	<addr>
               	sxtw	x0, w0
               	sub	x0, x29, #0x40
               	mov	x1, #0x42               // =66
               	mov	x2, #0x1a4              // =420
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, x0
               	sxtw	x0, w20
               	cmp	x0, #0x0
               	b.ge	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x140]
               	ldr	x19, [sp, #0x30]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x150
               	ret
               	sub	x0, x29, #0xa8
               	mov	x21, #0x0               // =0
               	mov	x2, #0x60               // =96
               	mov	x1, x21
               	bl	<addr>
               	sub	x0, x29, #0xa8
               	mov	x22, #0x1               // =1
               	strh	w22, [x0]
               	sub	x0, x29, #0xa8
               	strh	w21, [x0, #0x2]
               	sxtw	x0, w20
               	mov	x21, #0x6               // =6
               	sub	x2, x29, #0xa8
               	mov	x1, x21
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x23, x0
               	sub	x0, x29, #0xa8
               	mov	x1, #0x2                // =2
               	strh	w1, [x0]
               	sxtw	x0, w20
               	sub	x2, x29, #0xa8
               	mov	x1, x21
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x24, x0
               	sub	x0, x29, #0xa8
               	strh	w22, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	sxtw	x1, w20
               	sub	x2, x29, #0xa8
               	mov	x9, x0
               	mov	x0, x1
               	mov	x1, x21
               	blr	x9
               	sxtw	x21, w0
               	sxtw	x0, w20
               	bl	<addr>
               	sxtw	x0, w0
               	sub	x0, x29, #0x40
               	bl	<addr>
               	sxtw	x0, w0
               	sxtw	x0, w23
               	cmp	x0, #0x0
               	cset	x1, ne
               	cbnz	x1, <addr>
               	sxtw	x0, w24
               	cmp	x0, #0x0
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x140]
               	ldr	x19, [sp, #0x30]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x150
               	ret
               	cmp	x21, #0x0
               	b.ne	<addr>
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	ldp	x29, x30, [sp, #0x140]
               	ldr	x19, [sp, #0x30]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x150
               	ret
               	mov	x1, #0x1                // =1
               	b	<addr>
               	b	<addr>

<__c5_sys_fcntl>:
               	b	<addr>
