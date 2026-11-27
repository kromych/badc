
constfold_post_inline.x64:	file format elf64-x86-64

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
               	subq	$0x18, %rsp
               	movabsq	$0x123456789abcdef, %rax # imm = 0x123456789ABCDEF
               	movl	$0x40, %ecx
               	shlxq	%rcx, %rax, %rcx
               	movabsq	$0x123456789abcdef, %r11 # imm = 0x123456789ABCDEF
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	$0x41, %ecx
               	shlxq	%rcx, %rax, %rcx
               	movabsq	$0x2468acf13579bde, %r11 # imm = 0x2468ACF13579BDE
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x18, %rsp
               	retq
               	movq	%rax, (%rsp)
               	movq	(%rsp), %rax
               	leaq	0x5(%rax), %rcx
               	movabsq	$0x123456789abcdf4, %r11 # imm = 0x123456789ABCDF4
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x24, %eax
               	addq	$0x18, %rsp
               	retq
               	cmpq	$-0x1, %rax
               	jbe	<addr>
               	movl	$0x28, %eax
               	addq	$0x18, %rsp
               	retq
               	rorxq	$0x7, %rax, %rcx
               	movabsq	$-0x21fdb97530eca865, %r11 # imm = 0xDE02468ACF13579B
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x29, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	$0x41, %ecx
               	shlq	%cl, %rax
               	movabsq	$0x2468acf13579bde, %r11 # imm = 0x2468ACF13579BDE
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x2a, %eax
               	addq	$0x18, %rsp
               	retq
               	movq	$-0x8, 0x8(%rsp)
               	movq	0x8(%rsp), %rax
               	sarq	%rax
               	cmpq	$-0x4, %rax
               	je	<addr>
               	movl	$0x2b, %eax
               	addq	$0x18, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x18, %rsp
               	retq
