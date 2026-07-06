
sroa_runtime_index_stays_memory.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	sxtw	x1, w1
               	sub	x2, x29, #0x40
               	add	x2, x2, #0x0
               	add	x3, x0, #0x0
               	ldr	x3, [x3]
               	mov	x17, #0x3               // =3
               	mul	x3, x3, x17
               	add	x3, x3, #0x1
               	str	x3, [x2]
               	sub	x2, x29, #0x40
               	ldr	x3, [x0, #0x8]
               	mov	x17, #0x3               // =3
               	mul	x3, x3, x17
               	add	x3, x3, #0x1
               	str	x3, [x2, #0x8]
               	sub	x2, x29, #0x40
               	ldr	x3, [x0, #0x10]
               	mov	x17, #0x3               // =3
               	mul	x3, x3, x17
               	add	x3, x3, #0x1
               	str	x3, [x2, #0x10]
               	sub	x2, x29, #0x40
               	ldr	x3, [x0, #0x18]
               	mov	x17, #0x3               // =3
               	mul	x3, x3, x17
               	add	x3, x3, #0x1
               	str	x3, [x2, #0x18]
               	sub	x2, x29, #0x40
               	ldr	x3, [x0, #0x20]
               	mov	x17, #0x3               // =3
               	mul	x3, x3, x17
               	add	x3, x3, #0x1
               	str	x3, [x2, #0x20]
               	sub	x2, x29, #0x40
               	ldr	x3, [x0, #0x28]
               	mov	x17, #0x3               // =3
               	mul	x3, x3, x17
               	add	x3, x3, #0x1
               	str	x3, [x2, #0x28]
               	sub	x2, x29, #0x40
               	ldr	x3, [x0, #0x30]
               	mov	x17, #0x3               // =3
               	mul	x3, x3, x17
               	add	x3, x3, #0x1
               	str	x3, [x2, #0x30]
               	sub	x2, x29, #0x40
               	ldr	x0, [x0, #0x38]
               	mov	x17, #0x3               // =3
               	mul	x0, x0, x17
               	add	x0, x0, #0x1
               	str	x0, [x2, #0x38]
               	sub	x0, x29, #0x40
               	mov	x17, #0x7               // =7
               	and	x2, x1, x17
               	ldr	x2, [x0, x2, lsl #3]
               	sub	x0, x29, #0x40
               	add	x1, x1, #0x5
               	sxtw	x1, w1
               	mov	x17, #0x7               // =7
               	and	x1, x1, x17
               	ldr	x0, [x0, x1, lsl #3]
               	add	x0, x2, x0
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	sub	x0, x29, #0x40
               	mov	x1, #0x0                // =0
               	add	x0, x0, #0x0
               	str	x1, [x0]
               	sub	x0, x29, #0x40
               	mov	x1, #0x1                // =1
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0x40
               	mov	x1, #0x2                // =2
               	str	x1, [x0, #0x10]
               	sub	x0, x29, #0x40
               	mov	x1, #0x3                // =3
               	str	x1, [x0, #0x18]
               	sub	x0, x29, #0x40
               	mov	x1, #0x4                // =4
               	str	x1, [x0, #0x20]
               	sub	x0, x29, #0x40
               	mov	x1, #0x5                // =5
               	str	x1, [x0, #0x28]
               	sub	x0, x29, #0x40
               	mov	x1, #0x6                // =6
               	str	x1, [x0, #0x30]
               	sub	x0, x29, #0x40
               	mov	x1, #0x7                // =7
               	str	x1, [x0, #0x38]
               	sub	x0, x29, #0x40
               	mov	x1, #0xa                // =10
               	bl	<addr>
               	cmp	x0, #0x1d
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
