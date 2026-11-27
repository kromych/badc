
local_address_through_phi.x64:	file format elf64-x86-64

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

<fill>:
               	leaq	<rip>, %rax
               	movq	(%rax), %r10
               	movq	%r10, (%rdi)
               	movl	0x8(%rax), %r10d
               	movl	%r10d, 0x8(%rdi)
               	movzbq	0xc(%rax), %r10
               	movb	%r10b, 0xc(%rdi)
               	movl	$0xd, %eax
               	retq

<keep>:
               	movq	%rdi, %rax
               	movq	%rax, <rip> # <addr>
               	retq

<dir_length>:
               	subq	$0x50, %rsp
               	pushq	%rbx
               	movq	%rdi, %rbx
               	leaq	0x10(%rsp), %rdi
               	movl	$0x3f, %esi
               	callq	<addr>
               	movq	%rax, %rcx
               	testq	%rcx, %rcx
               	jle	<addr>
               	leaq	0x10(%rsp), %rax
               	movb	$0x0, 0x10(%rsp,%rcx)
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rax, %rdi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	<addr>
               	popq	%rbx
               	addq	$0x50, %rsp
               	retq
               	movq	$-0x1, %rax
               	jmp	<addr>
               	testq	%rbx, %rbx
               	je	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	jmp	<addr>

<main>:
               	pushq	%rax
               	leaq	<rip>, %rdi
               	callq	<addr>
               	cmpl	$0xd, %eax
               	jne	<addr>
               	cmpq	$0x0, <rip> # <addr>
               	je	<addr>
               	xorl	%eax, %eax
               	popq	%r11
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
