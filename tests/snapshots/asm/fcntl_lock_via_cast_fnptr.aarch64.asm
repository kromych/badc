
fcntl_lock_via_cast_fnptr.aarch64:	file format elf64-littleaarch64

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

<main>:
               	stp	x20, x21, [sp, #-0x110]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x24, x25, [sp, #0x20]
               	str	x26, [sp, #0x30]
               	str	x19, [sp, #0x40]
               	stp	x29, x30, [sp, #0x100]
               	add	x29, sp, #0x100
               	sub	x20, x29, #0xa0
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
               	mov	x1, #0x42               // =66
               	mov	x2, #0x1a4              // =420
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, x0
               	cmp	w20, #0x0
               	b.ge	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x100]
               	ldr	x19, [sp, #0x40]
               	ldr	x26, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x110
               	ret
               	sub	x21, x29, #0x60
               	mov	x22, #0x0               // =0
               	mov	x2, #0x60               // =96
               	mov	x0, x21
               	mov	x1, x22
               	bl	<addr>
               	mov	x25, #0x1               // =1
               	strh	w25, [x21]
               	strh	w22, [x21, #0x2]
               	sxtw	x22, w20
               	mov	x23, #0x6               // =6
               	mov	x0, x22
               	mov	x2, x21
               	mov	x1, x23
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x24, x0
               	sub	x2, x29, #0x60
               	mov	x0, #0x2                // =2
               	strh	w0, [x2]
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x26, x0
               	sub	x2, x29, #0x60
               	strh	w25, [x2]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	mov	x9, x0
               	mov	x0, x22
               	mov	x1, x23
               	blr	x9
               	mov	x21, x0
               	mov	x0, x22
               	bl	<addr>
               	sxtw	x0, w0
               	sub	x0, x29, #0xa0
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	w24, #0x0
               	cset	x0, ne
               	cbnz	x24, <addr>
               	cmp	w26, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x100]
               	ldr	x19, [sp, #0x40]
               	ldr	x26, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x110
               	ret
               	cbnz	x21, <addr>
               	mov	x0, #0x0                // =0
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x100]
               	ldr	x19, [sp, #0x40]
               	ldr	x26, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x110
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
               	b	<addr>

<__c5_sys_fcntl>:
               	b	<addr>
