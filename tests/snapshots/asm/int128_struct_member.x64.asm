
int128_struct_member.x64:	file format elf64-x86-64

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
               	movq	<rip>, %rsi # <addr>
               	xorl	%eax, %eax
               	movq	<rip>, %rcx # <addr>
               	orq	%rax, %rcx
               	movl	<rip>, %edx # <addr>
               	cmpl	$0x1, %edx
               	jne	<addr>
               	movl	<rip>, %edx # <addr>
               	cmpl	$0x2, %edx
               	jne	<addr>
               	movq	<rip>, %rdx # <addr>
               	movq	<rip>, %rdi # <addr>
               	xorq	%rcx, %rdx
               	xorq	%rsi, %rdi
               	orq	%rdi, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	movq	<rip>, %rdx # <addr>
               	movq	<rip>, %rdi # <addr>
               	xorq	%rcx, %rdx
               	xorq	%rsi, %rdi
               	orq	%rdi, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	movq	<rip>, %rdx # <addr>
               	movq	<rip>, %rdi # <addr>
               	movabsq	$0x1000000000, %r8      # imm = 0x1000000000
               	xorq	%rdi, %r8
               	orq	%r8, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movabsq	$0x1000000000, %r11     # imm = 0x1000000000
               	movq	%rdi, %rdx
               	cmpq	%r11, %rdi
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	movq	%rcx, %rdx
               	xorq	$0x4, %rdx
               	movq	%rsi, %rdi
               	xorq	$0x9, %rdi
               	orq	%rdi, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	leaq	0x3(%rcx), %rdx
               	cmpq	%rcx, %rdx
               	setb	%cl
               	movzbq	%cl, %rcx
               	incq	%rsi
               	addq	%rsi, %rcx
               	xorq	$0x7, %rdx
               	xorq	$0xa, %rcx
               	orq	%rcx, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0xb, %eax
               	retq
               	retq
