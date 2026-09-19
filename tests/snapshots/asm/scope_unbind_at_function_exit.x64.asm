
scope_unbind_at_function_exit.x64:	file format elf64-x86-64

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

<by_param>:
               	movslq	%edi, %rax
               	retq

<by_local>:
               	movl	$0x1, %eax
               	retq

<by_block>:
               	movl	$0x2, %eax
               	retq

<by_static>:
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	retq

<by_typedef>:
               	movl	$0x4, %eax
               	retq

<by_extern_over_enum>:
               	movl	$0x5, %eax
               	retq

<use_m>:
               	movslq	%edi, %rax
               	retq

<use_n>:
               	leaq	(%rdi,%rsi), %rax
               	movslq	%eax, %rax
               	retq

<use_n2>:
               	leaq	(%rdi,%rsi), %rax
               	movslq	%eax, %rax
               	retq

<main>:
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rax
               	cmpl	$0xb, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rax
               	cmpl	$0x16, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x21, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x2c, %eax
               	je	<addr>
               	movl	$0xa, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x37, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	retq
               	leaq	<rip>, %rsi
               	movslq	(%rsi), %rax
               	cmpl	$0x58, %eax
               	je	<addr>
               	movl	$0xc, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rdi
               	cmpl	$0x63, %edi
               	je	<addr>
               	movl	$0xd, %eax
               	retq
               	movslq	(%rsi), %rsi
               	cmpl	$0x58, %esi
               	je	<addr>
               	movl	$0xf, %eax
               	retq
               	movslq	(%rax), %rsi
               	movslq	(%rcx), %rcx
               	addq	%rsi, %rcx
               	cmpl	$0x6e, %ecx
               	je	<addr>
               	movl	$0x10, %eax
               	retq
               	movslq	(%rax), %rax
               	movslq	(%rdx), %rcx
               	addq	%rcx, %rax
               	cmpl	$0x79, %eax
               	je	<addr>
               	movl	$0x11, %eax
               	retq
               	xorl	%eax, %eax
               	retq
