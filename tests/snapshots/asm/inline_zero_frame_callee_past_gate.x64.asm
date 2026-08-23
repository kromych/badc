
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
               	xorq	%rdx, %rdx
               	movq	(%rdi), %rsi
               	addq	$0x2c8, %rdi            # imm = 0x2C8
               	movq	(%rdi), %rdi
               	addq	%rdi, %rsi
               	addq	%rsi, %rcx
               	movq	%rcx, (%rax)
               	movq	%rdx, %rax
               	retq

<put_request>:
               	xorq	%rax, %rax
               	retq

<submit>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xb40, %rsp            # imm = 0xB40
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xb40(%rbp), %rdx
               	movq	%rcx, %rsi
               	shlq	$0x3, %rsi
               	addq	%rsi, %rdx
               	leaq	0x1(%rcx), %rsi
               	movslq	%esi, %rsi
               	movq	%rsi, (%rdx)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x5a, %rcx
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
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x870(%rbp), %rdx
               	movq	%rcx, %rsi
               	shlq	$0x3, %rsi
               	addq	%rsi, %rdx
               	leaq	0x2(%rcx), %rsi
               	movslq	%esi, %rsi
               	movq	%rsi, (%rdx)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x5a, %rcx
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
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x5a0(%rbp), %rdx
               	movq	%rcx, %rsi
               	shlq	$0x3, %rsi
               	addq	%rsi, %rdx
               	leaq	0x3(%rcx), %rsi
               	movslq	%esi, %rsi
               	movq	%rsi, (%rdx)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x5a, %rcx
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
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x2d0(%rbp), %rdx
               	movq	%rcx, %rsi
               	shlq	$0x3, %rsi
               	addq	%rsi, %rdx
               	leaq	0x4(%rcx), %rsi
               	movslq	%esi, %rsi
               	movq	%rsi, (%rdx)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x5a, %rcx
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
               	xorq	%rax, %rax
               	addq	$0xb40, %rsp            # imm = 0xB40
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xb40, %rsp            # imm = 0xB40
               	leaq	<rip>, %rdi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xb40(%rbp), %rdx
               	movq	%rcx, %rsi
               	shlq	$0x3, %rsi
               	addq	%rsi, %rdx
               	leaq	0x1(%rcx), %rsi
               	movslq	%esi, %rsi
               	movq	%rsi, (%rdx)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x5a, %rcx
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
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x870(%rbp), %rdx
               	movq	%rcx, %rsi
               	shlq	$0x3, %rsi
               	addq	%rsi, %rdx
               	leaq	0x2(%rcx), %rsi
               	movslq	%esi, %rsi
               	movq	%rsi, (%rdx)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x5a, %rcx
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
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x5a0(%rbp), %rdx
               	movq	%rcx, %rsi
               	shlq	$0x3, %rsi
               	addq	%rsi, %rdx
               	leaq	0x3(%rcx), %rsi
               	movslq	%esi, %rsi
               	movq	%rsi, (%rdx)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x5a, %rcx
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
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x2d0(%rbp), %rdx
               	movq	%rcx, %rsi
               	shlq	$0x3, %rsi
               	addq	%rsi, %rdx
               	leaq	0x4(%rcx), %rsi
               	movslq	%esi, %rsi
               	movq	%rsi, (%rdx)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x5a, %rcx
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
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x178, %rax            # imm = 0x178
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0xb40, %rsp            # imm = 0xB40
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0xb40, %rsp            # imm = 0xB40
               	popq	%rbp
               	retq
