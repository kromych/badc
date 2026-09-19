
constfold_post_inline.x64:	file format elf64-x86-64

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
               	movabsq	$0x123456789abcdef, %rax # imm = 0x123456789ABCDEF
               	movl	$0x40, %ecx
               	movq	%rax, %rdx
               	shlq	%cl, %rdx
               	movabsq	$0x123456789abcdef, %r11 # imm = 0x123456789ABCDEF
               	movq	%rdx, %rcx
               	cmpq	%r11, %rdx
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movl	$0x41, %ecx
               	movq	%rax, %rdx
               	shlq	%cl, %rdx
               	movabsq	$0x2468acf13579bde, %r11 # imm = 0x2468ACF13579BDE
               	movq	%rdx, %rcx
               	cmpq	%r11, %rdx
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movq	%rax, -0x10(%rbp)
               	movq	-0x10(%rbp), %rax
               	leaq	0x5(%rax), %rcx
               	movabsq	$0x123456789abcdf4, %r11 # imm = 0x123456789ABCDF4
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x24, %eax
               	leave
               	retq
               	cmpq	$-0x1, %rax
               	jbe	<addr>
               	movl	$0x28, %eax
               	leave
               	retq
               	movq	%rax, %rcx
               	rorq	$0x7, %rcx
               	movabsq	$-0x21fdb97530eca865, %r11 # imm = 0xDE02468ACF13579B
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x29, %eax
               	leave
               	retq
               	movl	$0x41, %ecx
               	shlq	%cl, %rax
               	movabsq	$0x2468acf13579bde, %r11 # imm = 0x2468ACF13579BDE
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x2a, %eax
               	leave
               	retq
               	movq	$-0x8, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	sarq	%rax
               	cmpq	$-0x4, %rax
               	je	<addr>
               	movl	$0x2b, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
