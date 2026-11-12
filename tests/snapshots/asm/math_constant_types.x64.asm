
math_constant_types.x64:	file format elf64-x86-64

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
               	subq	$0x10, %rsp
               	movl	$0x7fc00000, -0x10(%rbp) # imm = 0x7FC00000
               	leaq	-0x8(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	movl	(%rdx), %r10d
               	movl	%r10d, (%rcx)
               	movl	-0x10(%rbp), %ecx
               	movl	$0xffc00000, %r11d      # imm = 0xFFC00000
               	andq	%r11, %rcx
               	cmpl	$0x7fc00000, %ecx       # imm = 0x7FC00000
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	movss	<rip>, %xmm0 # <addr>
               	ucomiss	%xmm0, %xmm0
               	jp	<addr>
               	je	<addr>
               	movss	<rip>, %xmm0 # <addr>
               	movl	$0x7f61b1e6, %ecx       # imm = 0x7F61B1E6
               	movq	%rcx, %xmm15
               	comiss	%xmm15, %xmm0
               	jbe	<addr>
               	movl	$0x7fc00000, -0x8(%rbp) # imm = 0x7FC00000
               	movl	-0x8(%rbp), %eax
               	shrq	$0x1f, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xffc00000, -0x8(%rbp) # imm = 0xFFC00000
               	movl	-0x8(%rbp), %eax
               	shrq	$0x1f, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	$0x8, %eax
               	leave
               	retq
