
sroa_runtime_index_stays_memory.aarch64:	file format elf64-littleaarch64

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

<pick>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	mov	x2, x0
               	sxtw	x1, w1
               	sub	x0, x29, #0x40
               	add	x3, x0, #0x0
               	add	x4, x2, #0x0
               	ldr	x4, [x4]
               	mov	x17, #0x3               // =3
               	mul	x4, x4, x17
               	add	x4, x4, #0x1
               	str	x4, [x3]
               	ldr	x3, [x2, #0x8]
               	mov	x17, #0x3               // =3
               	mul	x3, x3, x17
               	add	x3, x3, #0x1
               	str	x3, [x0, #0x8]
               	ldr	x3, [x2, #0x10]
               	mov	x17, #0x3               // =3
               	mul	x3, x3, x17
               	add	x3, x3, #0x1
               	str	x3, [x0, #0x10]
               	ldr	x3, [x2, #0x18]
               	mov	x17, #0x3               // =3
               	mul	x3, x3, x17
               	add	x3, x3, #0x1
               	str	x3, [x0, #0x18]
               	ldr	x3, [x2, #0x20]
               	mov	x17, #0x3               // =3
               	mul	x3, x3, x17
               	add	x3, x3, #0x1
               	str	x3, [x0, #0x20]
               	ldr	x3, [x2, #0x28]
               	mov	x17, #0x3               // =3
               	mul	x3, x3, x17
               	add	x3, x3, #0x1
               	str	x3, [x0, #0x28]
               	ldr	x3, [x2, #0x30]
               	mov	x17, #0x3               // =3
               	mul	x3, x3, x17
               	add	x3, x3, #0x1
               	str	x3, [x0, #0x30]
               	ldr	x2, [x2, #0x38]
               	mov	x17, #0x3               // =3
               	mul	x2, x2, x17
               	add	x2, x2, #0x1
               	str	x2, [x0, #0x38]
               	mov	x17, #0x7               // =7
               	and	x2, x1, x17
               	ldr	x2, [x0, x2, lsl #3]
               	add	x1, x1, #0x5
               	sxtw	x1, w1
               	mov	x17, #0x7               // =7
               	and	x1, x1, x17
               	ldr	x0, [x0, x1, lsl #3]
               	add	x0, x2, x0
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x60]!
               	stp	x29, x30, [sp, #0x50]
               	add	x29, sp, #0x50
               	sub	x0, x29, #0x40
               	mov	x20, #0x0               // =0
               	add	x1, x0, #0x0
               	str	x20, [x1]
               	mov	x21, #0x1               // =1
               	str	x21, [x0, #0x8]
               	mov	x1, #0x2                // =2
               	str	x1, [x0, #0x10]
               	mov	x1, #0x3                // =3
               	str	x1, [x0, #0x18]
               	mov	x1, #0x4                // =4
               	str	x1, [x0, #0x20]
               	mov	x1, #0x5                // =5
               	str	x1, [x0, #0x28]
               	mov	x1, #0x6                // =6
               	str	x1, [x0, #0x30]
               	mov	x1, #0x7                // =7
               	str	x1, [x0, #0x38]
               	mov	x1, #0xa                // =10
               	bl	<addr>
               	cmp	x0, #0x1d
               	b.eq	<addr>
               	mov	x0, x21
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x0, x20
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x20, x21, [sp], #0x60
               	ret
