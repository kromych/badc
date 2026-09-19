
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
               	stp	x20, x21, [sp, #-0x90]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x29, x30, [sp, #0x80]
               	add	x29, sp, #0x80
               	sub	x20, x29, #0x60
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
               	sub	x0, x29, #0x60
               	mov	x1, #0x42               // =66
               	mov	x2, #0x1a4              // =420
               	bl	<addr>
               	mov	x20, x0
               	cmp	w20, #0x0
               	b.ge	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x80]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x90
               	ret
               	sub	x0, x29, #0x20
               	mov	x1, #0x0                // =0
               	mov	x2, #0x20               // =32
               	bl	<addr>
               	sub	x2, x29, #0x20
               	mov	x0, #0x1                // =1
               	strh	w0, [x2]
               	mov	x0, #0x0                // =0
               	strh	w0, [x2, #0x2]
               	sxtw	x0, w20
               	mov	x1, #0x6                // =6
               	bl	<addr>
               	mov	x21, x0
               	sub	x2, x29, #0x20
               	mov	x0, #0x2                // =2
               	strh	w0, [x2]
               	sxtw	x0, w20
               	mov	x1, #0x6                // =6
               	bl	<addr>
               	mov	x22, x0
               	sub	x2, x29, #0x20
               	mov	x0, #0x1                // =1
               	strh	w0, [x2]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x3, [x0]
               	sxtw	x0, w20
               	mov	x1, #0x6                // =6
               	mov	x9, x3
               	blr	x9
               	mov	x23, x0
               	sxtw	x0, w20
               	bl	<addr>
               	sub	x0, x29, #0x60
               	bl	<addr>
               	cbnz	w21, <addr>
               	cbz	w22, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x80]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x90
               	ret
               	cbnz	w23, <addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x80]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x90
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>

<__c5_sys_fcntl>:
               	b	<addr>
