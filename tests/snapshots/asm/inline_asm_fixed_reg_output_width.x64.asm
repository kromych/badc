
inline_asm_fixed_reg_output_width.x64:	file format elf64-x86-64

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

<tick_halves_are_clean>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x10(%rbp), %rcx
               	leaq	-0x8(%rbp), %rdx
               	movabsq	$-0x2152411021524111, %rax # imm = 0xDEADBEEFDEADBEEF
               	movq	%rax, (%rcx)
               	movq	%rax, (%rdx)
               	rdtsc
               	movq	%rax, -0x10(%rbp)
               	movq	%rdx, -0x8(%rbp)
               	movq	-0x10(%rbp), %rax
               	movq	-0x8(%rbp), %rcx
               	shlq	$0x20, %rcx
               	orq	%rcx, %rax
               	movq	%rax, (%rdi)
               	movq	-0x10(%rbp), %rax
               	movq	%rax, %rcx
               	shrq	$0x20, %rcx
               	xorq	%rax, %rax
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	-0x8(%rbp), %rax
               	shrq	$0x20, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	jmp	<addr>

<tick_int_halves>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	rdtsc
               	movl	%eax, -0x8(%rbp)
               	movl	%edx, -0x10(%rbp)
               	movl	-0x10(%rbp), %eax
               	shlq	$0x20, %rax
               	movl	-0x8(%rbp), %ecx
               	orq	%rcx, %rax
               	leave
               	retq

<long_output_fills_all_bytes>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x8(%rbp), %rax
               	movabsq	$-0x2152411021524111, %rcx # imm = 0xDEADBEEFDEADBEEF
               	movq	%rcx, (%rax)
               	movl	$0x99, %eax
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	cmpq	$0x99, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	leave
               	retq

<short_output_keeps_neighbours>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x8(%rbp), %rax
               	movl	$0xbeef, %ecx           # imm = 0xBEEF
               	movw	%cx, (%rax)
               	xorq	%rcx, %rcx
               	movw	%cx, 0x2(%rax)
               	movl	$0xfeed, %edx           # imm = 0xFEED
               	movw	%dx, 0x4(%rax)
               	leaq	0x2(%rax), %rdx
               	movl	$0x11223344, %eax       # imm = 0x11223344
               	movw	%ax, (%rdx)
               	leaq	-0x8(%rbp), %rax
               	movzwq	(%rax), %rdx
               	xorq	$0xbeef, %rdx           # imm = 0xBEEF
               	movl	%edx, %edx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movzwq	0x2(%rax), %rcx
               	xorq	$0x3344, %rcx           # imm = 0x3344
               	movl	%ecx, %ecx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorq	%rdx, %rdx
               	testq	%rcx, %rcx
               	je	<addr>
               	movzwq	0x4(%rax), %rax
               	xorq	$0xfeed, %rax           # imm = 0xFEED
               	movl	%eax, %eax
               	testl	%eax, %eax
               	sete	%dl
               	movzbq	%dl, %rdx
               	movslq	%edx, %rax
               	leave
               	retq
               	jmp	<addr>
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	xorq	%rax, %rax
               	movq	%rax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	callq	<addr>
               	movq	-0x8(%rbp), %rcx
               	shrq	$0x30, %rcx
               	movq	%rax, %rdx
               	shrq	$0x30, %rdx
               	cmpq	%rdx, %rcx
               	jne	<addr>
               	movq	-0x8(%rbp), %rcx
               	cmpq	%rcx, %rax
               	setb	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	xorq	%rax, %rax
               	leave
               	retq
