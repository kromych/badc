
int128_struct_member.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rdx
               	xorl	%eax, %eax
               	leaq	<rip>, %rcx      # <addr>
               	movq	(%rcx), %rcx
               	orq	%rax, %rcx
               	leaq	<rip>, %rsi      # <addr>
               	movl	(%rsi), %edi
               	cmpl	$0x1, %edi
               	jne	<addr>
               	movl	0x20(%rsi), %edi
               	cmpl	$0x2, %edi
               	jne	<addr>
               	movq	0x10(%rsi), %rdi
               	movq	0x18(%rsi), %rsi
               	xorq	%rcx, %rdi
               	xorq	%rdx, %rsi
               	orq	%rdi, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	leaq	<rip>, %rsi      # <addr>
               	movq	(%rsi), %rdi
               	movq	0x8(%rsi), %rsi
               	xorq	%rcx, %rdi
               	xorq	%rdx, %rsi
               	orq	%rdi, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	leaq	<rip>, %rsi      # <addr>
               	movq	(%rsi), %rdi
               	movq	0x8(%rsi), %r8
               	movabsq	$0x1000000000, %r11     # imm = 0x1000000000
               	xorq	%r11, %r8
               	orq	%r8, %rdi
               	testq	%rdi, %rdi
               	jne	<addr>
               	movq	0x8(%rsi), %rsi
               	movabsq	$0x1000000000, %r11     # imm = 0x1000000000
               	cmpq	%r11, %rsi
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	movq	%rcx, %rsi
               	xorq	$0x4, %rsi
               	movq	%rdx, %rdi
               	xorq	$0x9, %rdi
               	orq	%rdi, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	movq	%rcx, %rsi
               	xorq	%rcx, %rsi
               	movq	%rdx, %rdi
               	xorq	%rdx, %rdi
               	orq	%rdi, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x9, %eax
               	retq
               	leaq	0x3(%rcx), %rsi
               	cmpq	%rcx, %rsi
               	setb	%cl
               	movzbq	%cl, %rcx
               	incq	%rdx
               	addq	%rdx, %rcx
               	movq	%rsi, %rdx
               	xorq	$0x7, %rdx
               	xorq	$0xa, %rcx
               	orq	%rdx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0xb, %eax
               	retq
               	retq
