
libc_math_fdim_scalbn.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3

<main>:
               	pushq	%rax
               	movsd	<rip>, %xmm0
               	movl	$0x3, %edi
               	callq	<addr>
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%r11
               	retq
               	movsd	<rip>, %xmm0
               	movq	$-0x1, %rdi
               	callq	<addr>
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%r11
               	retq
               	movsd	<rip>, %xmm0
               	movl	$0x4, %edi
               	callq	<addr>
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%r11
               	retq
               	movl	$0x2, %edi
               	movsd	<rip>, %xmm0
               	callq	<addr>
               	cvtsd2ss	%xmm0, %xmm0
               	ucomiss	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%r11
               	retq
               	movabsq	$0x4000000000000000, %r11 # imm = 0x4000000000000000
               	movq	%r11, %xmm0
               	cvtsd2ss	%xmm0, %xmm0
               	ucomiss	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%r11
               	retq
               	xorl	%eax, %eax
               	popq	%r11
               	retq
