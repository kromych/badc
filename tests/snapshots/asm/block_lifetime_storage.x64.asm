
block_lifetime_storage.x64:	file format elf64-x86-64

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

<volatiles>:
               	subq	$0x18, %rsp
               	movl	$0x1, (%rsp)
               	movl	(%rsp), %eax
               	incq	%rax
               	movl	%eax, (%rsp)
               	movl	(%rsp), %eax
               	movl	$0x3, 0x8(%rsp)
               	movl	0x8(%rsp), %ecx
               	incq	%rcx
               	movl	%ecx, 0x8(%rsp)
               	movl	0x8(%rsp), %ecx
               	addq	%rcx, %rax
               	addq	$0x18, %rsp
               	retq

<main>:
               	subq	$0x18, %rsp
               	movl	$0x1, 0x8(%rsp)
               	leaq	0x8(%rsp), %rax
               	movq	%rax, <rip> # <addr>
               	addl	$0xa, (%rax)
               	movl	0x8(%rsp), %edx
               	movl	$0x2, %ecx
               	movl	%ecx, 0x8(%rsp)
               	movq	%rax, <rip> # <addr>
               	addl	$0x14, (%rax)
               	movl	0x8(%rsp), %esi
               	addq	%rsi, %rdx
               	movl	$0x3, 0x8(%rsp)
               	movq	%rax, <rip> # <addr>
               	addl	$0x1e, (%rax)
               	movl	0x8(%rsp), %esi
               	addq	%rsi, %rdx
               	movl	$0x4, 0x8(%rsp)
               	movq	%rax, <rip> # <addr>
               	addl	$0x28, (%rax)
               	movl	0x8(%rsp), %eax
               	addq	%rdx, %rax
               	cmpl	$0x6e, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	$0x5, (%rsp)
               	leaq	(%rsp), %rdx
               	movl	$0x6, 0x8(%rsp)
               	leaq	0x8(%rsp), %rax
               	movq	%rax, <rip> # <addr>
               	addl	$0x1, (%rax)
               	movl	0x8(%rsp), %esi
               	cmpl	$0x7, %esi
               	je	<addr>
               	movq	%rcx, %rax
               	addq	$0x18, %rsp
               	retq
               	movq	%rdx, <rip> # <addr>
               	addl	$0x64, (%rdx)
               	movl	(%rsp), %edx
               	cmpl	$0x69, %edx
               	jne	<addr>
               	movl	$0x7, 0x8(%rsp)
               	movq	%rax, <rip> # <addr>
               	movl	(%rax), %ecx
               	shlq	%rcx
               	movl	%ecx, (%rax)
               	movslq	0x8(%rsp), %rdx
               	movabsq	$0x1122334455667788, %rcx # imm = 0x1122334455667788
               	movq	%rcx, 0x8(%rsp)
               	movq	%rax, <rip> # <addr>
               	xorq	$0x1, (%rax)
               	movq	<rip>, %rax # <addr>
               	movq	(%rax), %rax
               	addq	%rdx, %rax
               	movl	$0x9, 0x8(%rsp)
               	leaq	0x8(%rsp), %rcx
               	movq	%rcx, <rip> # <addr>
               	addl	$0x1, (%rcx)
               	movslq	0x8(%rsp), %rdx
               	addq	%rdx, %rax
               	movabsq	$0x11223344556677a1, %r11 # imm = 0x11223344556677A1
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x18, %rsp
               	retq
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	movl	%eax, 0x8(%rsp)
               	movq	%rcx, <rip> # <addr>
               	addl	$0x1, (%rcx)
               	movl	0x8(%rsp), %esi
               	addq	%rdx, %rsi
               	movl	%eax, 0x8(%rsp)
               	movq	%rcx, <rip> # <addr>
               	movq	<rip>, %rdx # <addr>
               	addl	$0x2, (%rdx)
               	movl	0x8(%rsp), %edx
               	addq	%rsi, %rdx
               	incq	%rax
               	cmpl	$0x3, %eax
               	jl	<addr>
               	cmpl	$0xf, %edx
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x18, %rsp
               	retq
               	callq	<addr>
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x18, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x18, %rsp
               	retq
