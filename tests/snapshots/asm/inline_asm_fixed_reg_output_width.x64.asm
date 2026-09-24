
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
               	leaq	-0x8(%rbp), %rcx
               	movabsq	$-0x2152411021524111, %rax # imm = 0xDEADBEEFDEADBEEF
               	movq	%rax, -0x10(%rbp)
               	movq	%rax, (%rcx)
               	rdtsc
               	movq	%rdx, -0x8(%rbp)
               	movq	%rax, -0x10(%rbp)
               	movq	-0x8(%rbp), %rcx
               	shlq	$0x20, %rcx
               	orq	%rcx, %rax
               	movq	%rax, (%rdi)
               	movq	-0x10(%rbp), %rax
               	movq	%rax, %rcx
               	shrq	$0x20, %rcx
               	xorl	%eax, %eax
               	testl	%ecx, %ecx
               	jne	<addr>
               	movq	-0x8(%rbp), %rax
               	shrq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	leave
               	retq

<tick_int_halves>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	rdtsc
               	movl	%edx, -0x8(%rbp)
               	movl	-0x8(%rbp), %ecx
               	shlq	$0x20, %rcx
               	movl	%eax, %eax
               	orq	%rcx, %rax
               	leave
               	retq

<long_output_fills_all_bytes>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movabsq	$-0x2152411021524111, %rax # imm = 0xDEADBEEFDEADBEEF
               	movq	%rax, -0x8(%rbp)
               	movl	$0x99, %eax
               	movq	%rax, -0x8(%rbp)
               	cmpq	$0x99, %rax
               	sete	%al
               	movzbq	%al, %rax
               	leave
               	retq

<short_output_keeps_neighbours>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x8(%rbp), %rax
               	movw	$0xbeef, (%rax)         # imm = 0xBEEF
               	xorl	%ecx, %ecx
               	movw	%cx, 0x2(%rax)
               	movw	$0xfeed, 0x4(%rax)      # imm = 0xFEED
               	leaq	0x2(%rax), %rdx
               	movl	$0x11223344, %eax       # imm = 0x11223344
               	movw	%ax, (%rdx)
               	leaq	-0x8(%rbp), %rdx
               	movzwq	(%rdx), %rax
               	xorq	$0xbeef, %rax           # imm = 0xBEEF
               	testl	%eax, %eax
               	jne	<addr>
               	movzwq	0x2(%rdx), %rax
               	xorq	$0x3344, %rax           # imm = 0x3344
               	testl	%eax, %eax
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorl	%eax, %eax
               	testq	%rcx, %rcx
               	je	<addr>
               	movzwq	0x4(%rdx), %rax
               	xorq	$0xfeed, %rax           # imm = 0xFEED
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	$0x0, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	callq	<addr>
               	movq	-0x8(%rbp), %rcx
               	shrq	$0x30, %rcx
               	movq	%rax, %rdx
               	shrq	$0x30, %rdx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	movq	-0x8(%rbp), %rcx
               	cmpq	%rcx, %rax
               	jae	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
