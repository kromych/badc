
vtable_back_to_back_4arg.x64:	file format elf64-x86-64

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

<g_init>:
               	leaq	<rip>, %rax # <addr>
               	movq	%rax, (%rdi)
               	leaq	(%rdx,%rcx), %rax
               	movl	%eax, 0x8(%rdi)
               	xorl	%eax, %eax
               	retq

<g_generate>:
               	movq	%rdx, %rax
               	movl	0x8(%rdi), %ecx
               	addq	$0x64, %rcx
               	movl	%ecx, (%rsi)
               	retq

<driver>:
               	subq	$0x28, %rsp
               	leaq	0x10(%rsp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movq	<rip>, %rax # <addr>
               	leaq	<rip>, %rsi # <addr>
               	movl	$0x1, %edx
               	movl	$0x64, %ecx
               	callq	*%rax
               	leaq	0x10(%rsp), %rdi
               	movq	0x10(%rsp), %rax
               	movq	0x8(%rax), %rax
               	leaq	0x8(%rsp), %rsi
               	movl	$0x1, %edx
               	callq	*%rax
               	movl	0x8(%rsp), %eax
               	addq	$0x28, %rsp
               	retq

<main>:
               	subq	$0x28, %rsp
               	leaq	0x10(%rsp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movq	<rip>, %rax # <addr>
               	leaq	<rip>, %rsi # <addr>
               	movl	$0x1, %edx
               	movl	$0x64, %ecx
               	callq	*%rax
               	leaq	0x10(%rsp), %rdi
               	movq	0x10(%rsp), %rax
               	movq	0x8(%rax), %rax
               	leaq	0x8(%rsp), %rsi
               	movl	$0x1, %edx
               	callq	*%rax
               	movl	0x8(%rsp), %eax
               	addq	$0x28, %rsp
               	retq
