
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
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdi)
               	movq	0x10(%rax), %rcx
               	movq	%rcx, 0x10(%rdi)
               	movq	0x18(%rax), %rcx
               	movq	%rcx, 0x18(%rdi)
               	popq	%rcx
               	movl	$0x6a09e667, %ecx       # imm = 0x6A09E667
               	movl	$0xbb67ae85, %edx       # imm = 0xBB67AE85
               	movl	$0x3c6ef372, %esi       # imm = 0x3C6EF372
               	xorl	%eax, %eax
               	movq	%rcx, %r9
               	andq	%rdx, %r9
               	movq	%rcx, %r8
               	xorq	$-0x1, %r8
               	andq	%r8, %rsi
               	xorq	%r9, %rsi
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
