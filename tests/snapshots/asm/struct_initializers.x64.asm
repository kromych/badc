
struct_initializers.x64:	file format elf64-x86-64

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

<do_add>:
               	leaq	(%rdi,%rsi), %rax
               	movslq	%eax, %rax
               	retq

<do_sub>:
               	movq	%rdi, %rax
               	subq	%rsi, %rax
               	movslq	%eax, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	cmpl	$0x1, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movq	0x8(%rax), %rax
               	movl	$0x2, %edi
               	movl	$0x3, %esi
               	callq	*%rax
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	0x10(%rax), %rax
               	movl	$0xa, %edi
               	movl	$0x4, %esi
               	callq	*%rax
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	0x18(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x64, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	cmpl	$0x2, %ecx
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	movq	0x8(%rax), %rax
               	movl	$0x7, %edi
               	movl	$0x8, %esi
               	callq	*%rax
               	cmpl	$0xf, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	0x18(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x61, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	cmpl	$0x3, %ecx
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbp
               	retq
               	movq	0x8(%rax), %rax
               	movl	$0x1, %edi
               	movq	%rdi, %rsi
               	callq	*%rax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	0x10(%rax), %rax
               	movl	$0x5, %edi
               	movl	$0x1, %esi
               	callq	*%rax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	cmpl	$0xa, %ecx
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbp
               	retq
               	movslq	0x4(%rax), %rax
               	cmpl	$0x14, %eax
               	je	<addr>
               	movl	$0xc, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	cmpl	$0x1, %ecx
               	je	<addr>
               	movl	$0xd, %eax
               	popq	%rbp
               	retq
               	movslq	0x4(%rax), %rax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0xe, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
