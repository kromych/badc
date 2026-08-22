
inline_asm_extended_operands.x64:	file format elf64-x86-64

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
               	subq	$0x40, %rsp
               	movabsq	$0x123456789abcdef, %rcx # imm = 0x123456789ABCDEF
               	movabsq	$-0x123456789abcdf0, %rax # imm = 0xFEDCBA9876543210
               	movq	%rcx, -0x8(%rbp)
               	movl	$0xc, %ecx
               	leaq	-0x8(%rbp), %rdx
               	movq	%rax, -0x40(%rbp)
               	movq	%rcx, -0x38(%rbp)
               	movq	%rbx, -0x30(%rbp)
               	movq	%rdx, -0x28(%rbp)
               	movq	%rax, -0x20(%rbp)
               	movq	%rcx, -0x18(%rbp)
               	movq	-0x28(%rbp), %r10
               	movq	(%r10), %rax
               	movq	-0x20(%rbp), %rbx
               	movq	-0x18(%rbp), %rcx
               	shldq	%cl, %rbx, %rax
               	movq	-0x28(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x40(%rbp), %rax
               	movq	-0x38(%rbp), %rcx
               	movq	-0x30(%rbp), %rbx
               	movq	-0x8(%rbp), %rcx
               	movabsq	$0x3456789abcdeffed, %r11 # imm = 0x3456789ABCDEFFED
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x123456789abcdef, %rcx # imm = 0x123456789ABCDEF
               	movq	%rax, -0x8(%rbp)
               	movl	$0x14, %edx
               	leaq	-0x8(%rbp), %rax
               	movq	%rax, -0x40(%rbp)
               	movq	%rcx, -0x38(%rbp)
               	movq	%rbx, -0x30(%rbp)
               	movq	%rax, -0x28(%rbp)
               	movq	%rcx, -0x20(%rbp)
               	movq	%rdx, -0x18(%rbp)
               	movq	-0x28(%rbp), %r10
               	movq	(%r10), %rax
               	movq	-0x20(%rbp), %rbx
               	movq	-0x18(%rbp), %rcx
               	shrdq	%cl, %rbx, %rax
               	movq	-0x28(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x40(%rbp), %rax
               	movq	-0x38(%rbp), %rcx
               	movq	-0x30(%rbp), %rbx
               	movq	-0x8(%rbp), %rcx
               	movabsq	$-0x432100123456789b, %r11 # imm = 0xBCDEFFEDCBA98765
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0x11223344, %ecx       # imm = 0x11223344
               	movq	%rcx, -0x8(%rbp)
               	movl	-0x8(%rbp), %ecx
               	movq	%rax, -0x40(%rbp)
               	movq	%rax, -0x38(%rbp)
               	movq	%rcx, -0x30(%rbp)
               	movq	-0x30(%rbp), %rax
               	bswapl	%eax
               	movq	-0x38(%rbp), %r10
               	movl	%eax, (%r10)
               	movq	-0x40(%rbp), %rax
               	movl	-0x8(%rbp), %eax
               	cmpq	$0x44332211, %rax       # imm = 0x44332211
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x102030405060708, %rax # imm = 0x102030405060708
               	movq	%rax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rcx
               	movq	%rax, -0x40(%rbp)
               	movq	%rcx, -0x38(%rbp)
               	movq	%rax, -0x30(%rbp)
               	movq	-0x30(%rbp), %rax
               	bswapq	%rax
               	movq	-0x38(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x40(%rbp), %rax
               	movq	-0x8(%rbp), %rax
               	movabsq	$0x807060504030201, %r11 # imm = 0x807060504030201
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	%rax, -0x40(%rbp)
               	movq	%rcx, -0x38(%rbp)
               	movq	%rdx, -0x30(%rbp)
               	movq	%rcx, -0x28(%rbp)
               	rdtscp
               	shlq	$0x20, %rdx
               	orq	%rdx, %rax
               	movq	-0x28(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x40(%rbp), %rax
               	movq	-0x38(%rbp), %rcx
               	movq	-0x30(%rbp), %rdx
               	movq	-0x8(%rbp), %rcx
               	movq	%rcx, (%rax)
               	xorq	%rax, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
