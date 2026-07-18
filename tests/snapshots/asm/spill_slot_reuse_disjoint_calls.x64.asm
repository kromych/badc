
spill_slot_reuse_disjoint_calls.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<opaque>:
               	testq	%rdi, %rdi
               	jge	<addr>
               	imulq	$-0x1, %rdi, %rax
               	retq
               	movq	%rdi, %rax
               	shlq	%rax
               	retq

<twogroups>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%r15, 0x20(%rsp)
               	leaq	0x1(%rdi), %rbx
               	leaq	0x2(%rdi), %r12
               	leaq	0x3(%rdi), %r13
               	leaq	0x4(%rdi), %r14
               	leaq	0x5(%rdi), %r15
               	leaq	0x6(%rdi), %r10
               	movq	%r10, 0x48(%rsp)
               	leaq	0x7(%rdi), %r10
               	movq	%r10, 0x40(%rsp)
               	leaq	0x8(%rdi), %r10
               	movq	%r10, 0x38(%rsp)
               	callq	<addr>
               	addq	%rbx, %rax
               	addq	%r12, %rax
               	addq	%r13, %rax
               	addq	%r14, %rax
               	addq	%r15, %rax
               	addq	0x48(%rsp), %rax
               	addq	0x40(%rsp), %rax
               	movq	%rax, %rdi
               	addq	0x38(%rsp), %rdi
               	leaq	0x1(%rdi), %rbx
               	leaq	0x2(%rdi), %r12
               	leaq	0x3(%rdi), %r13
               	leaq	0x4(%rdi), %r14
               	leaq	0x5(%rdi), %r15
               	leaq	0x6(%rdi), %r10
               	movq	%r10, 0x48(%rsp)
               	leaq	0x7(%rdi), %r10
               	movq	%r10, 0x40(%rsp)
               	leaq	0x8(%rdi), %r10
               	movq	%r10, 0x38(%rsp)
               	callq	<addr>
               	addq	%rbx, %rax
               	addq	%r12, %rax
               	addq	%r13, %rax
               	addq	%r14, %rax
               	addq	%r15, %rax
               	addq	0x48(%rsp), %rax
               	addq	0x40(%rsp), %rax
               	addq	0x38(%rsp), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq

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
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
