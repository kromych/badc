
spill_slot_reuse_disjoint_calls.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	cmp	x0, #0x0
               	b.ge	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	mul	x0, x0, x17
               	ret
               	lsl	x0, x0, #1
               	ret

<twogroups>:
               	stp	x20, x21, [sp, #-0x50]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x24, x25, [sp, #0x20]
               	stp	x26, x27, [sp, #0x30]
               	stp	x29, x30, [sp, #0x40]
               	add	x29, sp, #0x40
               	add	x20, x0, #0x1
               	add	x21, x0, #0x2
               	add	x22, x0, #0x3
               	add	x23, x0, #0x4
               	add	x24, x0, #0x5
               	add	x25, x0, #0x6
               	add	x26, x0, #0x7
               	add	x27, x0, #0x8
               	bl	<addr>
               	add	x0, x0, x20
               	add	x0, x0, x21
               	add	x0, x0, x22
               	add	x0, x0, x23
               	add	x0, x0, x24
               	add	x0, x0, x25
               	add	x0, x0, x26
               	add	x0, x0, x27
               	add	x20, x0, #0x1
               	add	x21, x0, #0x2
               	add	x22, x0, #0x3
               	add	x23, x0, #0x4
               	add	x24, x0, #0x5
               	add	x25, x0, #0x6
               	add	x26, x0, #0x7
               	add	x27, x0, #0x8
               	bl	<addr>
               	add	x0, x0, x20
               	add	x0, x0, x21
               	add	x0, x0, x22
               	add	x0, x0, x23
               	add	x0, x0, x24
               	add	x0, x0, x25
               	add	x0, x0, x26
               	add	x0, x0, x27
               	ldp	x29, x30, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0xa                // =10
               	bl	<addr>
               	cmp	x0, #0x574
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xfffd             // =65533
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	bl	<addr>
               	cmp	x0, #0xba
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
