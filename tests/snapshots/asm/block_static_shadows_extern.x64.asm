
block_static_shadows_extern.x64:	file format elf64-x86-64

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

<sink>:
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	cmpl	%esi, %eax
               	jge	<addr>
               	shlq	$0x4, %rcx
               	movzbq	(%rdi,%rax), %rdx
               	addq	%rdx, %rcx
               	incq	%rax
               	cmpl	%esi, %eax
               	jl	<addr>
               	movq	%rcx, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	leaq	<rip>, %rdi
               	movl	$0x2, %esi
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	callq	*%rax
               	cmpl	$0x12, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdi
               	movl	$0x3, %esi
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	callq	*%rax
               	cmpl	$0x345, %eax            # imm = 0x345
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdi
               	movl	$0x2, %esi
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	callq	*%rax
               	cmpl	$0x67, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdi
               	movl	$0x1, %esi
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	callq	*%rax
               	cmpl	$0x8, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdi
               	movl	$0x1, %esi
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	callq	*%rax
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rdi
               	movl	$0x3, %esi
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	callq	*%rax
               	movq	%rax, %rbx
               	leaq	<rip>, %rax
               	leaq	0x1(%rax), %rdi
               	movl	$0x2, %esi
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	callq	*%rax
               	addq	%rax, %rbx
               	leaq	<rip>, %rax
               	movq	0x8(%rax), %rdi
               	movl	$0x1, %esi
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	callq	*%rax
               	addq	%rax, %rbx
               	leaq	<rip>, %rdi
               	movl	$0x1, %esi
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	callq	*%rax
               	addq	%rax, %rbx
               	leaq	<rip>, %rax
               	movq	(%rax), %rdi
               	movl	$0x1, %esi
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	callq	*%rax
               	addq	%rbx, %rax
               	cmpl	$0xb9b, %eax            # imm = 0xB9B
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
