
inline_asm_extended_operands.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<shl_double>:
               	popq	%r10
               	subq	$0x30, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movslq	%edx, %rdx
               	movq	%rdi, 0x10(%rbp)
               	leaq	0x10(%rbp), %rax
               	movq	%rax, -0x30(%rbp)
               	movq	%rcx, -0x28(%rbp)
               	movq	%rbx, -0x20(%rbp)
               	movq	%rax, -0x18(%rbp)
               	movq	%rsi, -0x10(%rbp)
               	movq	%rdx, -0x8(%rbp)
               	movq	-0x18(%rbp), %r11
               	movq	(%r11), %rax
               	movq	-0x10(%rbp), %rbx
               	movq	-0x8(%rbp), %rcx
               	shldq	%cl, %rbx, %rax
               	movq	-0x18(%rbp), %r11
               	movq	%rax, (%r11)
               	movq	-0x30(%rbp), %rax
               	movq	-0x28(%rbp), %rcx
               	movq	-0x20(%rbp), %rbx
               	movq	0x10(%rbp), %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x30, %rsp
               	pushq	%r11
               	retq

<shr_double>:
               	popq	%r10
               	subq	$0x30, %rsp
               	movq	%rsi, 0x10(%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movslq	%edx, %rdx
               	movq	%rsi, 0x20(%rbp)
               	leaq	0x20(%rbp), %rax
               	movq	%rax, -0x30(%rbp)
               	movq	%rcx, -0x28(%rbp)
               	movq	%rbx, -0x20(%rbp)
               	movq	%rax, -0x18(%rbp)
               	movq	%rdi, -0x10(%rbp)
               	movq	%rdx, -0x8(%rbp)
               	movq	-0x18(%rbp), %r11
               	movq	(%r11), %rax
               	movq	-0x10(%rbp), %rbx
               	movq	-0x8(%rbp), %rcx
               	shrdq	%cl, %rbx, %rax
               	movq	-0x18(%rbp), %r11
               	movq	%rax, (%r11)
               	movq	-0x30(%rbp), %rax
               	movq	-0x28(%rbp), %rcx
               	movq	-0x20(%rbp), %rbx
               	movq	0x20(%rbp), %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x30, %rsp
               	pushq	%r11
               	retq

<bswap32>:
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rdi, 0x10(%rbp)
               	leaq	0x10(%rbp), %rax
               	movl	0x10(%rbp), %ecx
               	movq	%rax, -0x20(%rbp)
               	movq	%rax, -0x18(%rbp)
               	movq	%rcx, -0x10(%rbp)
               	movq	-0x10(%rbp), %rax
               	bswapl	%eax
               	movq	-0x18(%rbp), %r11
               	movl	%eax, (%r11)
               	movq	-0x20(%rbp), %rax
               	movl	0x10(%rbp), %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq

<bswap64>:
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rdi, 0x10(%rbp)
               	leaq	0x10(%rbp), %rax
               	movq	0x10(%rbp), %rcx
               	movq	%rax, -0x20(%rbp)
               	movq	%rax, -0x18(%rbp)
               	movq	%rcx, -0x10(%rbp)
               	movq	-0x10(%rbp), %rax
               	bswapq	%rax
               	movq	-0x18(%rbp), %r11
               	movq	%rax, (%r11)
               	movq	-0x20(%rbp), %rax
               	movq	0x10(%rbp), %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movabsq	$0x123456789abcdef, %rbx # imm = 0x123456789ABCDEF
               	movabsq	$-0x123456789abcdf0, %r12 # imm = 0xFEDCBA9876543210
               	movl	$0xc, %edx
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	movabsq	$0x3456789abcdeffed, %r11 # imm = 0x3456789ABCDEFFED
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0x14, %edx
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	movabsq	$-0x432100123456789b, %r11 # imm = 0xBCDEFFEDCBA98765
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0x11223344, %edi       # imm = 0x11223344
               	callq	<addr>
               	cmpq	$0x44332211, %rax       # imm = 0x44332211
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x102030405060708, %rdi # imm = 0x102030405060708
               	callq	<addr>
               	movabsq	$0x807060504030201, %r11 # imm = 0x807060504030201
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	leaq	-0x30(%rbp), %rcx
               	movq	%rax, -0x50(%rbp)
               	movq	%rcx, -0x48(%rbp)
               	movq	%rdx, -0x40(%rbp)
               	movq	%rcx, -0x38(%rbp)
               	rdtscp
               	shlq	$0x20, %rdx
               	orq	%rdx, %rax
               	movq	-0x38(%rbp), %r11
               	movq	%rax, (%r11)
               	movq	-0x50(%rbp), %rax
               	movq	-0x48(%rbp), %rcx
               	movq	-0x40(%rbp), %rdx
               	movq	-0x30(%rbp), %rcx
               	movq	%rcx, (%rax)
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
