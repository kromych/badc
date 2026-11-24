
scanf_reads_the_standard_input.x64:	file format elf64-x86-64

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
               	subq	$0x40, %rsp
               	pushq	%rbx
               	movl	$0x0, 0x18(%rsp)
               	movl	$0x0, 0x20(%rsp)
               	movq	$0x0, 0x28(%rsp)
               	leaq	0x30(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	leaq	<rip>, %rdi
               	leaq	0x18(%rsp), %rsi
               	leaq	0x20(%rsp), %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movq	%rax, %rbx
               	movq	<rip>, %rax # <addr>
               	movq	(%rax), %rdi
               	leaq	<rip>, %rsi
               	leaq	0x28(%rsp), %rdx
               	leaq	0x30(%rsp), %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movq	%rax, %r8
               	leaq	<rip>, %rdi
               	movl	0x18(%rsp), %edx
               	movl	0x20(%rsp), %ecx
               	movsd	0x28(%rsp), %xmm0
               	leaq	0x30(%rsp), %r9
               	movq	%rbx, %rsi
               	movb	$0x1, %al
               	callq	<addr>
               	leaq	<rip>, %rdi
               	leaq	0x18(%rsp), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	%rax, %rsi
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	callq	<addr>
               	movq	%rax, %rbx
               	movl	$0x6, %edi
               	xorl	%esi, %esi
               	callq	<addr>
               	movq	%rax, %rsi
               	movq	(%rbx), %rdx
               	movq	0x8(%rbx), %rcx
               	movsbq	0x51(%rbx), %r8
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x6, %edi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	testq	%rax, %rax
               	sete	%sil
               	movzbq	%sil, %rsi
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	addq	$0x40, %rsp
               	retq
