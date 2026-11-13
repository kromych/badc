
block_lifetime_storage.x64:	file format elf64-x86-64

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

<volatiles>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0x1, -0x10(%rbp)
               	movl	-0x10(%rbp), %eax
               	incq	%rax
               	movl	%eax, -0x10(%rbp)
               	movl	-0x10(%rbp), %eax
               	movl	$0x3, -0x8(%rbp)
               	movl	-0x8(%rbp), %ecx
               	incq	%rcx
               	movl	%ecx, -0x8(%rbp)
               	movl	-0x8(%rbp), %ecx
               	addq	%rcx, %rax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0x1, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movq	%rax, <rip> # <addr>
               	addl	$0xa, (%rax)
               	movl	-0x8(%rbp), %ecx
               	movl	$0x2, -0x8(%rbp)
               	movq	%rax, <rip> # <addr>
               	addl	$0x14, (%rax)
               	movl	-0x8(%rbp), %edx
               	addq	%rdx, %rcx
               	movl	$0x3, -0x8(%rbp)
               	movq	%rax, <rip> # <addr>
               	movq	<rip>, %rax # <addr>
               	addl	$0x1e, (%rax)
               	movl	-0x8(%rbp), %eax
               	addq	%rax, %rcx
               	movl	$0x4, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movq	%rax, <rip> # <addr>
               	addl	$0x28, (%rax)
               	movl	-0x8(%rbp), %edx
               	addq	%rdx, %rcx
               	cmpl	$0x6e, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movl	$0x5, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rcx
               	movq	%rcx, <rip> # <addr>
               	movl	$0x6, -0x8(%rbp)
               	movq	%rax, <rip> # <addr>
               	movq	<rip>, %rax # <addr>
               	addl	$0x1, (%rax)
               	movl	-0x8(%rbp), %eax
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movq	%rcx, <rip> # <addr>
               	addl	$0x64, (%rcx)
               	movl	-0x10(%rbp), %eax
               	cmpl	$0x69, %eax
               	jne	<addr>
               	movl	$0x7, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rcx
               	movq	%rcx, <rip> # <addr>
               	movl	(%rcx), %eax
               	shlq	%rax
               	movl	%eax, (%rcx)
               	movslq	-0x8(%rbp), %rax
               	movabsq	$0x1122334455667788, %rdx # imm = 0x1122334455667788
               	movq	%rdx, -0x8(%rbp)
               	movq	%rcx, <rip> # <addr>
               	xorq	$0x1, (%rcx)
               	movq	<rip>, %rdx # <addr>
               	movq	(%rdx), %rdx
               	addq	%rax, %rdx
               	movl	$0x9, -0x8(%rbp)
               	movq	%rcx, <rip> # <addr>
               	movq	<rip>, %rax # <addr>
               	addl	$0x1, (%rax)
               	movslq	-0x8(%rbp), %rax
               	addq	%rdx, %rax
               	movabsq	$0x11223344556677a1, %r11 # imm = 0x11223344556677A1
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	movl	%eax, -0x8(%rbp)
               	movq	%rcx, <rip> # <addr>
               	addl	$0x1, (%rcx)
               	movl	-0x8(%rbp), %esi
               	addq	%rdx, %rsi
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rdx
               	movq	%rdx, <rip> # <addr>
               	movq	<rip>, %rdx # <addr>
               	addl	$0x2, (%rdx)
               	movl	-0x8(%rbp), %edx
               	addq	%rsi, %rdx
               	incq	%rax
               	cmpl	$0x3, %eax
               	jl	<addr>
               	cmpl	$0xf, %edx
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	callq	<addr>
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
