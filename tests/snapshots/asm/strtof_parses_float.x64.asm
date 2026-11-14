
strtof_parses_float.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	<rip>, %rdi
               	leaq	-0x8(%rbp), %rsi
               	callq	<addr>
               	cvtss2sd	%xmm0, %xmm0
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movq	-0x8(%rbp), %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x78, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	<rip>, %rdi
               	xorl	%esi, %esi
               	callq	<addr>
               	movsd	<rip>, %xmm1
               	cvtss2sd	%xmm0, %xmm0
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
