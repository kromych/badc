
inline_zero_frame_callee_past_gate.x64:	file format elf64-x86-64

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

<consume>:
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movq	(%rdi), %rdx
               	leaq	0x2c8(%rdi), %rsi
               	movq	(%rsi), %rsi
               	addq	%rsi, %rdx
               	addq	%rdx, %rcx
               	movq	%rcx, (%rax)
               	retq

<submit>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xb40, %rsp            # imm = 0xB40
               	xorl	%eax, %eax
               	cmpl	$0x5a, %eax
               	jge	<addr>
               	leaq	-0xb40(%rbp), %rcx
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	addq	%rcx, %rdx
               	leaq	0x1(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	%rcx, %rax
               	cmpl	$0x5a, %eax
               	jl	<addr>
               	leaq	-0xb40(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rdx
               	movq	(%rax), %rsi
               	addq	$0x2c8, %rax            # imm = 0x2C8
               	movq	(%rax), %rax
               	addq	%rsi, %rax
               	addq	%rdx, %rax
               	movq	%rax, (%rcx)
               	xorl	%eax, %eax
               	cmpl	$0x5a, %eax
               	jge	<addr>
               	leaq	-0x870(%rbp), %rcx
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	addq	%rcx, %rdx
               	leaq	0x2(%rax), %rcx
               	movq	%rcx, (%rdx)
               	incq	%rax
               	cmpl	$0x5a, %eax
               	jl	<addr>
               	leaq	-0x870(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rdx
               	movq	(%rax), %rsi
               	addq	$0x2c8, %rax            # imm = 0x2C8
               	movq	(%rax), %rax
               	addq	%rsi, %rax
               	addq	%rdx, %rax
               	movq	%rax, (%rcx)
               	xorl	%eax, %eax
               	cmpl	$0x5a, %eax
               	jge	<addr>
               	leaq	-0x5a0(%rbp), %rcx
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	addq	%rcx, %rdx
               	leaq	0x3(%rax), %rcx
               	movq	%rcx, (%rdx)
               	incq	%rax
               	cmpl	$0x5a, %eax
               	jl	<addr>
               	leaq	-0x5a0(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rdx
               	movq	(%rax), %rsi
               	addq	$0x2c8, %rax            # imm = 0x2C8
               	movq	(%rax), %rax
               	addq	%rsi, %rax
               	addq	%rdx, %rax
               	movq	%rax, (%rcx)
               	xorl	%eax, %eax
               	cmpl	$0x5a, %eax
               	jge	<addr>
               	leaq	-0x2d0(%rbp), %rcx
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	addq	%rcx, %rdx
               	leaq	0x4(%rax), %rcx
               	movq	%rcx, (%rdx)
               	incq	%rax
               	cmpl	$0x5a, %eax
               	jl	<addr>
               	leaq	-0x2d0(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rdx
               	movq	(%rax), %rsi
               	addq	$0x2c8, %rax            # imm = 0x2C8
               	movq	(%rax), %rax
               	addq	%rsi, %rax
               	addq	%rdx, %rax
               	movq	%rax, (%rcx)
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	<rip>, %rdi
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x178, %rax            # imm = 0x178
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
