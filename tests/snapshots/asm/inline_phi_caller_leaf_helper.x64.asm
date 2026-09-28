
inline_phi_caller_leaf_helper.x64:	file format elf64-x86-64

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
               	subq	$0x20, %rsp
               	leaq	-0x20(%rbp), %rdi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	movl	$0x6a09e667, %ecx       # imm = 0x6A09E667
               	movl	$0xbb67ae85, %edx       # imm = 0xBB67AE85
               	movl	$0x3c6ef372, %esi       # imm = 0x3C6EF372
               	xorl	%eax, %eax
               	movq	%rcx, %r8
               	andq	%rdx, %r8
               	movq	%rcx, %r9
               	xorq	$-0x1, %r9
               	andq	%r9, %rsi
               	xorq	%r8, %rsi
               	movl	(%rdi,%rax,4), %r8d
               	addq	%r8, %rsi
               	incq	%rax
               	xchgq	%rdx, %rsi
               	xchgq	%rcx, %rdx
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movq	%rcx, %rax
               	xorq	%rdx, %rax
               	xorq	%rsi, %rax
               	movl	$0xff6fffef, %r11d      # imm = 0xFF6FFFEF
               	cmpl	%r11d, %eax
               	jne	<addr>
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
