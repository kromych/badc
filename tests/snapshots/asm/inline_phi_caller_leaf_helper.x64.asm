
inline_phi_caller_leaf_helper.x64:	file format elf64-x86-64

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

<main>:
               	subq	$0x28, %rsp
               	leaq	(%rsp), %r9
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r9)
               	movl	$0x6a09e667, %ecx       # imm = 0x6A09E667
               	movl	$0xbb67ae85, %edx       # imm = 0xBB67AE85
               	movl	$0x3c6ef372, %esi       # imm = 0x3C6EF372
               	xorl	%eax, %eax
               	movq	%rcx, %r8
               	andq	%rdx, %r8
               	movq	%rcx, %rdi
               	xorq	$-0x1, %rdi
               	andq	%rsi, %rdi
               	xorq	%rdi, %r8
               	movl	(%rsp,%rax,4), %esi
               	addq	%r8, %rsi
               	incq	%rax
               	xchgq	%rdx, %rsi
               	xchgq	%rcx, %rdx
               	cmpl	$0x8, %eax
               	jl	<addr>
               	xorq	%rdx, %rcx
               	xorq	%rsi, %rcx
               	xorl	%eax, %eax
               	movl	$0x1, %edx
               	cmpl	$0xff6fffef, %ecx       # imm = 0xFF6FFFEF
               	cmovneq	%rdx, %rax
               	addq	$0x28, %rsp
               	retq
