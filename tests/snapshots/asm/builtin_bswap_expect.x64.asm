
builtin_bswap_expect.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0xaabbccdd, %eax       # imm = 0xAABBCCDD
               	movl	%eax, -0x8(%rbp)
               	movl	-0x8(%rbp), %eax
               	movq	%rax, %rcx
               	andq	$0xff, %rcx
               	shlq	$0x18, %rcx
               	movq	%rax, %rdx
               	shrq	$0x8, %rdx
               	andq	$0xff, %rdx
               	shlq	$0x10, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	shrq	$0x10, %rdx
               	andq	$0xff, %rdx
               	shlq	$0x8, %rdx
               	orq	%rdx, %rcx
               	shrq	$0x18, %rax
               	andq	$0xff, %rax
               	orq	%rcx, %rax
               	movl	$0xddccbbaa, %r11d      # imm = 0xDDCCBBAA
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
