
inline_asm_x64_P_memory_operand.x64:	file format elf64-x86-64

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
               	subq	$0x70, %rsp
               	movl	$0x5, -0x70(%rbp)
               	movl	$0x7, %eax
               	leaq	-0x70(%rbp), %rcx
               	xchgl	%eax, (%rcx)
               	xorq	$0x5, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	-0x70(%rbp), %eax
               	xorq	$0x7, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	-0x40(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movups	0x20(%rcx), %xmm14
               	movups	%xmm14, 0x20(%rax)
               	movups	0x30(%rcx), %xmm14
               	movups	%xmm14, 0x30(%rax)
               	leaq	-0x40(%rbp), %rax
               	prefetchw	(%rax)
               	leaq	-0x40(%rbp), %rax
               	clflush	(%rax)
               	movsbq	-0x40(%rbp), %rax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	-0x68(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movq	0x20(%rcx), %r10
               	movq	%r10, 0x20(%rax)
               	addq	$0x18, %rax
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	cmpq	$0x21, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movq	<rip>, %rax      # <addr>
               	cmpq	$0x14, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movl	$0x2a, %eax
               	leave
               	retq
