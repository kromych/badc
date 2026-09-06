
inline_section_mandatory.aarch64:	file format elf64-littleaarch64

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

<run_boot>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x5                // =5
               	bl	<addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp], #0x10
               	ret

<run_text>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x4                // =4
               	bl	<addr>
               	add	x0, x0, #0xd
               	sxtw	x0, w0
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x5                // =5
               	bl	<addr>
               	cmp	x0, #0x1c
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4                // =4
               	bl	<addr>
               	cmp	x0, #0x18
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
		...

<boot_offset>:
               	add	x0, x0, #0x7
               	sxtw	x0, w0
               	ret

<boot_step>:
               	mov	x17, #0x3               // =3
               	mul	x1, x0, x17
               	add	x1, x1, #0x1
               	add	x0, x0, #0x7
               	add	x0, x1, x0
               	sxtw	x0, w0
               	ret
