
member_name_space_keeps_object_shape.x64:	file format elf64-x86-64

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
               	xorl	%edx, %edx
               	leaq	<rip>, %rax # <addr>
               	movq	%rdx, %rcx
               	imulq	$0x30, %rcx, %rdi
               	leaq	(%rax,%rdi), %rsi
               	leaq	0x1(%rdx), %r8
               	movl	%edx, (%rsi)
               	leaq	0x1(%r8), %rdx
               	movl	%r8d, 0x4(%rsi)
               	leaq	0x1(%rdx), %r8
               	movl	%edx, 0x8(%rsi)
               	leaq	(%rax,%rdi), %rdx
               	leaq	0x1(%r8), %rsi
               	movl	%r8d, 0xc(%rdx)
               	imulq	$0x30, %rcx, %rdi
               	leaq	(%rax,%rdi), %rdx
               	leaq	0x1(%rsi), %r8
               	movl	%esi, 0x10(%rdx)
               	leaq	0x1(%r8), %rsi
               	movl	%r8d, 0x14(%rdx)
               	leaq	0x1(%rsi), %r8
               	movl	%esi, 0x18(%rdx)
               	leaq	(%rax,%rdi), %rdx
               	leaq	0x1(%r8), %rsi
               	movl	%r8d, 0x1c(%rdx)
               	imulq	$0x30, %rcx, %rdi
               	leaq	(%rax,%rdi), %rdx
               	leaq	0x1(%rsi), %r8
               	movl	%esi, 0x20(%rdx)
               	leaq	0x1(%r8), %rsi
               	movl	%r8d, 0x24(%rdx)
               	leaq	0x1(%rsi), %r8
               	movl	%esi, 0x28(%rdx)
               	leaq	(%rax,%rdi), %rsi
               	leaq	0x1(%r8), %rdx
               	movl	%r8d, 0x2c(%rsi)
               	incq	%rcx
               	cmpl	$0x2, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x17, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movabsq	$0x100000000, %rax      # imm = 0x100000000
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x300000002, %rax      # imm = 0x300000002
               	movq	%rax, <rip> # <addr>
               	movabsq	$0xb0000000a, %rax      # imm = 0xB0000000A
               	movq	%rax, <rip> # <addr>
               	movl	$0xc, <rip> # <addr>
               	movl	$0xd, <rip> # <addr>
               	movabsq	$0x1500000014, %rax     # imm = 0x1500000014
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x1700000016, %rax     # imm = 0x1700000016
               	movq	%rax, <rip> # <addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	leaq	<rip>, %rax # <addr>
               	leaq	0x10(%rax), %rcx
               	subq	%rax, %rcx
               	movq	%rcx, %rax
               	sarq	$0x3f, %rax
               	shrq	$0x3e, %rax
               	addq	%rcx, %rax
               	sarq	$0x2, %rax
               	cmpq	$0x4, %rax
               	jne	<addr>
               	xorl	%eax, %eax
               	retq
               	movl	$0x6, %eax
               	retq
