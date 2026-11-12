
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
               	movq	<rip>, %rdx # <addr>
               	xorl	%eax, %eax
               	movq	<rip>, %rcx # <addr>
               	orq	%rax, %rcx
               	movl	<rip>, %esi # <addr>
               	cmpl	$0x1, %esi
               	jne	<addr>
               	movl	<rip>, %esi # <addr>
               	cmpl	$0x2, %esi
               	jne	<addr>
               	movq	<rip>, %rsi # <addr>
               	movq	<rip>, %rdi # <addr>
               	xorq	%rcx, %rsi
               	xorq	%rdx, %rdi
               	orq	%rdi, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	movq	<rip>, %rsi # <addr>
               	movq	<rip>, %rdi # <addr>
               	xorq	%rcx, %rsi
               	xorq	%rdx, %rdi
               	orq	%rdi, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	movq	<rip>, %rdi # <addr>
               	movq	<rip>, %rsi # <addr>
               	movabsq	$0x1000000000, %r8      # imm = 0x1000000000
               	xorq	%rsi, %r8
               	orq	%r8, %rdi
               	testq	%rdi, %rdi
               	jne	<addr>
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
               	leaq	0x3(%rcx), %rsi
               	cmpq	%rcx, %rsi
               	setb	%cl
               	movzbq	%cl, %rcx
               	incq	%rdx
               	addq	%rdx, %rcx
               	xorq	$0x7, %rsi
               	xorq	$0xa, %rcx
               	orq	%rsi, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0xb, %eax
               	retq
               	retq
