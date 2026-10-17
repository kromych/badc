
const_through_a_pointer_typedef.x64:	file format elf64-x86-64

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

<fb>:
               	movl	$0x2, %eax
               	retq

<h0>:
               	leaq	0x1(%rdi), %rax
               	retq

<h1>:
               	leaq	0x2(%rdi), %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rax
               	callq	*%rax
               	movq	%rax, %rbx
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rax
               	callq	*%rax
               	addq	%rax, %rbx
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rax
               	callq	*%rax
               	addq	%rbx, %rax
               	cmpq	$0x6, %rax
               	jne	<addr>
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x61, %eax
               	jne	<addr>
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x62, %eax
               	jne	<addr>
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rax
               	movl	(%rax), %eax
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1, %edi
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rax
               	callq	*%rax
               	cmpl	$0x3, %eax
               	jne	<addr>
               	movl	$0x2, %edi
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rax
               	callq	*%rax
               	cmpl	$0x4, %eax
               	jne	<addr>
               	callq	<addr>
               	movq	%rax, %rbx
               	callq	<addr>
               	addq	%rbx, %rax
               	cmpq	$0x4, %rax
               	jne	<addr>
               	leaq	<rip>, %rax      # <addr>
               	movsbq	0x1(%rax), %rax
               	cmpl	$0x62, %eax
               	jne	<addr>
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %eax
               	cmpl	$0x5, %eax
               	jne	<addr>
               	movl	$0x1, %edi
               	callq	<addr>
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax      # <addr>
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rax)
               	movsbq	(%rcx), %rcx
               	cmpl	$0x7a, %ecx
               	jne	<addr>
               	movq	0x8(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x79, %eax
               	jne	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x4, %eax
               	jmp	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
