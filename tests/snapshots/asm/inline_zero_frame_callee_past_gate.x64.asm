
inline_zero_frame_callee_past_gate.x64:	file format elf64-x86-64

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

<consume>:
               	movq	<rip>, %rax # <addr>
               	movq	(%rdi), %rcx
               	movq	0x2c8(%rdi), %rdx
               	addq	%rdx, %rcx
               	addq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	retq

<submit>:
               	subq	$0xb48, %rsp            # imm = 0xB48
               	xorl	%eax, %eax
               	leaq	(%rsp), %rcx
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rcx
               	incq	%rax
               	movq	%rax, (%rcx)
               	cmpl	$0x5a, %eax
               	jl	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	(%rsp), %rcx
               	movq	0x2c8(%rsp), %rdx
               	addq	%rdx, %rcx
               	addq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	xorl	%eax, %eax
               	leaq	0x2d0(%rsp), %rcx
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rcx
               	leaq	0x2(%rax), %rdx
               	movq	%rdx, (%rcx)
               	incq	%rax
               	cmpl	$0x5a, %eax
               	jl	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	0x2d0(%rsp), %rcx
               	movq	0x598(%rsp), %rdx
               	addq	%rdx, %rcx
               	addq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	xorl	%eax, %eax
               	leaq	0x5a0(%rsp), %rcx
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rcx
               	leaq	0x3(%rax), %rdx
               	movq	%rdx, (%rcx)
               	incq	%rax
               	cmpl	$0x5a, %eax
               	jl	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	0x5a0(%rsp), %rcx
               	movq	0x868(%rsp), %rdx
               	addq	%rdx, %rcx
               	addq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	xorl	%eax, %eax
               	leaq	0x870(%rsp), %rcx
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rcx
               	leaq	0x4(%rax), %rdx
               	movq	%rdx, (%rcx)
               	incq	%rax
               	cmpl	$0x5a, %eax
               	jl	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	0x870(%rsp), %rcx
               	movq	0xb38(%rsp), %rdx
               	addq	%rdx, %rcx
               	addq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	addq	$0xb48, %rsp            # imm = 0xB48
               	retq

<main>:
               	pushq	%rax
               	leaq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x178, %rax            # imm = 0x178
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%r11
               	retq
               	xorl	%eax, %eax
               	popq	%r11
               	retq
