
undeclared_library_calls_keep_the_header_types.x64:	file format elf64-x86-64

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
               	subq	$0x18, %rsp
               	leaq	<rip>, %rdi
               	xorl	%esi, %esi
               	callq	<addr>
               	movsd	%xmm0, 0x8(%rsp)
               	leaq	<rip>, %rdi
               	movb	$0x1, %al
               	callq	<addr>
               	movsd	0x8(%rsp), %xmm0
               	xorl	%ecx, %ecx
               	movl	$0x1, %edx
               	ucomisd	<rip>, %xmm0
               	cmovneq	%rdx, %rcx
               	cmovpq	%rdx, %rcx
               	xorl	%edx, %edx
               	movl	$0x2, %esi
               	cmpl	$0x5, %eax
               	cmovneq	%rsi, %rdx
               	orq	%rdx, %rcx
               	movq	%rcx, %rax
               	addq	$0x18, %rsp
               	retq
