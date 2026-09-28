
gcc_vector_size_attribute.x64:	file format elf64-x86-64

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

<identity>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movups	%xmm0, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rax
               	movq	%rax, %rcx
               	movups	(%rcx), %xmm0
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-0x20(%rbp), %r9
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	movups	%xmm0, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rax
               	movzbq	(%rax), %rcx
               	movzbq	0x7(%rax), %rdx
               	movzbq	0xf(%rax), %rax
               	xorq	$0x1, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movq	%rdx, %rcx
               	xorq	$0x8, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	xorq	$0x10, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	leaq	-0x20(%rbp), %rax
               	movzbq	(%rax), %rcx
               	movzbq	0xf(%rax), %rax
               	xorq	$0x1, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	xorq	$0x10, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
