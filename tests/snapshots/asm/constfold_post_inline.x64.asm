
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
               	subq	$0x20, %rsp
               	movabsq	$0x123456789abcdef, %rax # imm = 0x123456789ABCDEF
               	movl	$0x40, %ecx
               	movq	%rcx, %r10
               	movq	%rax, %rcx
               	movq	%rcx, %r11
               	movq	%r10, %rcx
               	shlq	%cl, %r11
               	movq	%r11, %rcx
               	movabsq	$0x123456789abcdef, %r11 # imm = 0x123456789ABCDEF
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movl	$0x41, %ecx
               	shlq	%cl, %rax
               	movabsq	$0x2468acf13579bde, %r11 # imm = 0x2468ACF13579BDE
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	movq	%rcx, %rax
               	movabsq	$0x123456789abcdef, %rax # imm = 0x123456789ABCDEF
               	movq	%rax, -0x10(%rbp)
               	movq	-0x10(%rbp), %rax
               	leaq	0x5(%rax), %rdx
               	movabsq	$0x123456789abcdf4, %r11 # imm = 0x123456789ABCDF4
               	cmpq	%r11, %rdx
               	je	<addr>
               	movl	$0x24, %eax
               	leave
               	retq
               	cmpq	$-0x1, %rax
               	jbe	<addr>
               	movl	$0x28, %eax
               	leave
               	retq
               	movq	%rax, %rdx
               	rorq	$0x7, %rdx
               	movabsq	$-0x21fdb97530eca865, %r11 # imm = 0xDE02468ACF13579B
               	cmpq	%r11, %rdx
               	je	<addr>
               	movl	$0x29, %eax
               	leave
               	retq
               	pushq	%rcx
               	movl	$0x41, %ecx
               	shlq	%cl, %rax
               	popq	%rcx
               	movabsq	$0x2468acf13579bde, %r11 # imm = 0x2468ACF13579BDE
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x2a, %eax
               	leave
               	retq
               	movabsq	$-0x8, %rax
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	sarq	%rax
               	cmpq	$-0x4, %rax
               	je	<addr>
               	movl	$0x2b, %eax
               	leave
               	retq
               	movq	%rcx, %rax
               	leave
               	retq
