
spill_slot_reuse_disjoint_calls.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<twogroups>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	leaq	0x1(%rdi), %rcx
               	leaq	0x2(%rdi), %rdx
               	leaq	0x3(%rdi), %rsi
               	leaq	0x4(%rdi), %r8
               	leaq	0x5(%rdi), %r9
               	leaq	0x6(%rdi), %rbx
               	leaq	0x7(%rdi), %r12
               	leaq	0x8(%rdi), %r13
               	testq	%rdi, %rdi
               	jge	<addr>
               	imulq	$-0x1, %rdi, %rax
               	addq	%rcx, %rax
               	addq	%rdx, %rax
               	addq	%rsi, %rax
               	addq	%r8, %rax
               	addq	%r9, %rax
               	addq	%rbx, %rax
               	addq	%r12, %rax
               	addq	%r13, %rax
               	leaq	0x1(%rax), %rcx
               	leaq	0x2(%rax), %rdx
               	leaq	0x3(%rax), %rsi
               	leaq	0x4(%rax), %rdi
               	leaq	0x5(%rax), %r8
               	leaq	0x6(%rax), %r9
               	leaq	0x7(%rax), %rbx
               	leaq	0x8(%rax), %r12
               	testq	%rax, %rax
               	jge	<addr>
               	imulq	$-0x1, %rax, %rax
               	addq	%rcx, %rax
               	addq	%rdx, %rax
               	addq	%rsi, %rax
               	addq	%rdi, %rax
               	addq	%r8, %rax
               	addq	%r9, %rax
               	addq	%rbx, %rax
               	addq	%r12, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	shlq	%rax
               	jmp	<addr>
               	movq	%rdi, %rax
               	shlq	%rax
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0xa, %edi
               	callq	<addr>
               	cmpq	$0x574, %rax            # imm = 0x574
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movabsq	$-0x3, %rdi
               	callq	<addr>
               	cmpq	$0xba, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
