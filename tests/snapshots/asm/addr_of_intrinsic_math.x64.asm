
addr_of_intrinsic_math.x64:	file format elf64-x86-64

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
               	movq	<rip>, %rax # <addr>
               	movsd	<rip>, %xmm0
               	callq	*%rax
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%r11
               	retq
               	movsd	<rip>, %xmm0
               	movq	<rip>, %rax # <addr>
               	callq	*%rax
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%r11
               	retq
               	movsd	<rip>, %xmm0
               	movq	<rip>, %rax # <addr>
               	callq	*%rax
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%r11
               	retq
               	movsd	<rip>, %xmm0
               	movq	<rip>, %rax # <addr>
               	callq	*%rax
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%r11
               	retq
               	movsd	<rip>, %xmm0
               	movq	<rip>, %rax # <addr>
               	callq	*%rax
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%r11
               	retq
               	movq	<rip>, %rax # <addr>
               	movsd	<rip>, %xmm0
               	callq	*%rax
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%r11
               	retq
               	movsd	<rip>, %xmm0
               	movq	<rip>, %rax # <addr>
               	callq	*%rax
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%r11
               	retq
               	movsd	<rip>, %xmm0
               	movq	<rip>, %rax # <addr>
               	callq	*%rax
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%r11
               	retq
               	movsd	<rip>, %xmm0
               	movsd	<rip>, %xmm1
               	vandpd	<rip>, %xmm1, %xmm1
               	ucomisd	%xmm0, %xmm1
               	jp	<addr>
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%r11
               	retq
               	movsd	<rip>, %xmm0
               	sqrtsd	%xmm0, %xmm0
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%r11
               	retq
               	xorl	%eax, %eax
               	popq	%r11
               	retq
